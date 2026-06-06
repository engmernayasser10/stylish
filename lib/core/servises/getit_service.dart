import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish/core/networking/dio_consumer.dart';
import 'package:stylish/core/networking/api_consumer.dart';
import 'package:stylish/Features/auth/data/repos/auth_repo.dart';
import 'package:stylish/Features/auth/data/repos/auth_repo_implementation.dart';
import 'package:stylish/core/servises/secure_storage_services.dart';
import 'package:stylish/core/servises/shared_preferences_services.dart';
import 'package:stylish/Features/auth/presentation/cubit/login_cubit.dart';

final getit = GetIt.instance;
Future<void> setupGetIt() async {
  // Register Dio singleton
  getit.registerLazySingleton<Dio>(() => Dio());

  // Register SharedPreferencesServices
  final sharedPreferences = await SharedPreferences.getInstance();
  getit.registerLazySingleton<SharedPreferencesServices>(
    () => SharedPreferencesServices.init(sharedPreferences),
  );

  getit.registerLazySingleton<SecureStorageServices>(
    () => SecureStorageServices(),
  );

  // Register DioConsumer as an ApiConsumer singleton
  // DioConsumer implements ApiConsumer; cast to ApiConsumer to satisfy the typedef
  getit.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getit<Dio>()) as ApiConsumer,
  );

  // Register AuthRepoImplementation as a singleton, injecting ApiConsumer
  getit.registerLazySingleton<AuthRepo>(
    () => AuthRepoImplementation(
      getit<ApiConsumer>(),
      getit<SecureStorageServices>(),
      getit<SharedPreferencesServices>(),
    ),
  );

  // Register LoginCubit
  getit.registerLazySingleton<LoginCubit>(
    () => LoginCubit(getit<AuthRepo>()),
  );
}
