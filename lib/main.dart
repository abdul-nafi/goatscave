import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goatscave/core/router/app_router.dart';
import 'package:goatscave/core/theme/app_theme.dart';

void main() {
  runApp(const GoatsCaveApp());
}

class GoatsCaveApp extends StatelessWidget {
  const GoatsCaveApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
              title: 'GoatsCave',
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme);
        });
  }
}
