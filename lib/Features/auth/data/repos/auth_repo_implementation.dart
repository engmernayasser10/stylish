import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/Failures.dart';
import 'package:stylish/core/networking/api_consumer.dart';
import 'package:stylish/core/networking/api_endpoints.dart';
import 'package:stylish/Features/auth/data/repos/auth_repo.dart';
import 'package:stylish/core/servises/secure_storage_services.dart';
import 'package:stylish/core/servises/shared_preferences_services.dart';

class AuthRepoImplementation implements AuthRepo {
  final ApiConsumer apiConsumer;
  final SecureStorageServices secureStorageServices;
  final SharedPreferencesServices sharedPreferencesServices;

  AuthRepoImplementation(this.apiConsumer, this.secureStorageServices,
      this.sharedPreferencesServices);
  @override
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String name,
    required String email,
    required String password,
    required String avatarURL,
  }) async {
    try {
      final response = await apiConsumer.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'avatar_url': avatarURL,
        },
      );
      final accessToken = response['access_token'] as String?;
      final refreshToken = response['refresh_token'] as String?;
      if (accessToken != null && refreshToken != null) {
        await secureStorageServices.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
        await sharedPreferencesServices.setLoggedIn(true);
      }
      return Right(response);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiConsumer.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      final accessToken = response['access_token'] as String?;
      final refreshToken = response['refresh_token'] as String?;
      if (accessToken != null && refreshToken != null) {
        await secureStorageServices.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
        await sharedPreferencesServices.setLoggedIn(true);
        return Right(response);
      } else {
        return Left(
            ServerFailure(errorMessage: 'Invalid token response from server'));
      }
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
