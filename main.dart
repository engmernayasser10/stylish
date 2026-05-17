import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stylish/core/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utilis/app_theme.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const Stylish());
}

class Stylish extends StatelessWidget {
  const Stylish({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => MaterialApp.router(
        locale: const Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: AppTheme.getLightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
