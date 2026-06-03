import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/Core/routing/app_routes.dart';
import 'package:stylish/core/servises/getit_service.dart';
import 'package:stylish/core/servises/shared_preferences_services.dart';
import 'package:stylish/generated/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        final isLoggedIn = getit<SharedPreferencesServices>().isLoggedIn;
        if (isLoggedIn == true) {
          GoRouter.of(context).pushReplacement(AppRoutes.kHomeRoute);
        } else {
          GoRouter.of(context).pushReplacement(AppRoutes.kLoginRoute);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.assetsImagesAppIcon,
                width: 125.w,
                height: 100.h,
              ),
              SizedBox(width: 10.w),
              Text(
                'Stylish',
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
