import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Home/home_page.dart';
import 'package:todo_app/Home/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (context,child) {
        return MaterialApp(
          home: SplashScreen(),
        );
      }
    );
  }
}
