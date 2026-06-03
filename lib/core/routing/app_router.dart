import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/Features/auth/data/repos/auth_repo.dart';
import 'package:stylish/Features/auth/presentation/manager/login/login_cubit.dart';
import 'package:stylish/Features/onboarding/presentation/manager/register/register_cubit.dart';
import 'package:stylish/Features/home/presentation/views/home_view.dart';
import 'package:stylish/Features/onboarding/presentation/views/forget_password_view.dart';
import 'package:stylish/Features/onboarding/presentation/views/login_view.dart';
import 'package:stylish/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:stylish/Features/splash/presentation/views/splash_view.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/core/servises/getit_service.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.kOnboardingView,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: AppRoutes.kLoginRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(getit<AuthRepo>()),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.kSignupRoute,
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(authRepo: getit<AuthRepo>()),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: AppRoutes.kHomeRoute,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: AppRoutes.kForgotPasswordRoute,
        builder: (context, state) => const ForgetPassView(),
      ),
    ],
  );
}
