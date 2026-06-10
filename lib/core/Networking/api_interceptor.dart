import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stylish/core/Networking/api_endpoints.dart';
import 'package:stylish/core/servises/getit_service.dart';
import 'package:stylish/core/servises/secure_storage_services.dart';
import 'package:stylish/core/servises/shared_preferences_services.dart';

class ApiInterceptors extends Interceptor {
  final Dio dio;
  static Completer<bool>? _refreshCompleter;

  ApiInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final secureStorage = getit<SecureStorageServices>();
    final accessToken = await secureStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('Response: ${response.statusCode} ${response.requestOptions.path}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (_refreshCompleter != null) {
        final success = await _refreshCompleter!.future;
        if (success) {
          final secureStorage = getit<SecureStorageServices>();
          final accessToken = await secureStorage.getAccessToken();
          if (accessToken != null) {
            err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
          }
          try {
            final response = await dio.fetch(err.requestOptions);
            return handler.resolve(response);
          } catch (_) {
            return handler.next(err);
          }
        }
        return handler.next(err);
      }

      _refreshCompleter = Completer<bool>();
      final secureStorage = getit<SecureStorageServices>();
      final refreshToken = await secureStorage.getRefreshToken();
      if (refreshToken == null) {
        _refreshCompleter!.complete(false);
        _refreshCompleter = null;
        await _performLogout();
        return handler.next(err);
      }

      try {
        final refreshDio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
        final response = await refreshDio.post(
          '/auth/refresh',
          data: {'refresh_token': refreshToken},
        );
        final newAccessToken = response.data['access_token'] as String?;
        final newRefreshToken = response.data['refresh_token'] as String?;
        if (newAccessToken == null || newRefreshToken == null) {
          throw Exception('Token refresh failed');
        }
        await secureStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );
        _refreshCompleter!.complete(true);
        _refreshCompleter = null;
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final retryResponse = await dio.fetch(err.requestOptions);
        return handler.resolve(retryResponse);
      } catch (e) {
        _refreshCompleter!.complete(false);
        _refreshCompleter = null;
        await _performLogout();
        return handler.next(err);
      }
    }

    return super.onError(err, handler);
  }
}

Future<void> _performLogout() async {
  await getit<SecureStorageServices>().deleteTokens();
  await getit<SharedPreferencesServices>().clearAuthData();
  AuthEventBus.instance.addEvent(AuthEvent.loggedOut);
}

enum AuthEvent { loggedOut }

class AuthEventBus {
  AuthEventBus._();

  static final AuthEventBus instance = AuthEventBus._();
  final _controller = StreamController<AuthEvent>.broadcast();

  Stream<AuthEvent> get events => _controller.stream;

  Null get stream => null;

  void addEvent(AuthEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  void dispose() {
    _controller.close();
  }
}
