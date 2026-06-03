import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/Core/widgets/custom_button.dart';
import 'package:stylish/Features/auth/presentation/manager/login/login_cubit.dart';
import 'package:stylish/Features/auth/presentation/manager/login/login_state.dart';
import 'package:stylish/Features/onboarding/presentation/views/widgets/signup_navigation.dart';
import 'package:stylish/Features/onboarding/presentation/views/widgets/social_login_buttons.dart';
import 'package:stylish/Features/onboarding/presentation/views/widgets/welcome_text.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'login_form.dart';
import 'or_continue_with_divider.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<LoginFormState>();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          GoRouter.of(context).go(AppRoutes.kHomeRoute);
        } else if (state is LoginFailure) {
          // Handle login failure, e.g., show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeText(),
              LoginForm(key: formKey),
              SizedBox(height: 52.h),
              state is LoginLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'Login',
                      onPressed: () {
                        if (formKey.currentState?.formKey.currentState
                                ?.validate() ??
                            false) {
                          final email = formKey.currentState?.email ?? '';
                          final password = formKey.currentState?.password ?? '';
                          context
                              .read<LoginCubit>()
                              .login(email: email, password: password);
                        }
                      },
                    ),
              SizedBox(height: 75.h),
              const OrContinueWithDivider(),
              SizedBox(height: 20.h),
              const SocialLoginButtons(),
              SizedBox(height: 28.h),
              const SignupNavigation(),
            ],
          ),
        );
      },
    );
  }
}
