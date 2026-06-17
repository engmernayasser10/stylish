import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/Features/auth/data/repos/auth_repo.dart';
import 'package:stylish/Features/auth/presentation/manager/login/login_cubit.dart';
import 'package:stylish/Features/onboarding/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        context.read<AuthRepo>(),
      ),
      child: const Scaffold(
        body: SafeArea(
          child: LoginViewBody(),
        ),
      ),
    );
  }
}
