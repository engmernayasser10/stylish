import 'package:dartz/dartz.dart';
import 'package:stylish/core/errors/Failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, Map<String, dynamic>>> register({
    required String name,
    required String email,
    required String password,
    required String avatarURL,
  });
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  });
}
