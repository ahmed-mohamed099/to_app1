import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_app138/features/splash/splash_screen.dart';
import 'features/login/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});




  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420, 821),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(

          scaffoldBackgroundColor: Colors.white,

        ),

        home: const LoginScreen(),
      ),
    );
  }
}