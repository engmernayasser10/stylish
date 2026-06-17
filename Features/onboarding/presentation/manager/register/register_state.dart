part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final Map<String, dynamic> responseData;
  RegisterSuccess({required this.responseData});
}

class RegisterError extends RegisterState {
  final String errorMessage;
  RegisterError({required this.errorMessage});
}
