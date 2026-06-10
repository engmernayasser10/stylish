import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/routing/app_router.dart';
import 'package:stylish/core/utilis/app_theme.dart';
import 'package:stylish/core/servises/auth_event_bus.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/core/servises/getit_service.dart';
import 'package:stylish/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  runApp(const Stylish());
}

class Stylish extends StatefulWidget {
  const Stylish({super.key});

  @override
  State<Stylish> createState() => _StylishState();
}

class _StylishState extends State<Stylish> {
  late StreamSubscription<AuthEvent> _authSubscription;
  @override
  void initState() {
    super.initState();
    _authSubscription = AuthEventBus.instance.stream.listen((event) {
      if (event == AuthEvent.loggedOut) {
        // Handle logout event, e.g., navigadte to login screen
        AppRouter.router.go(AppRoutes.kLoginRoute);
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        localizationsDelegates: [
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
