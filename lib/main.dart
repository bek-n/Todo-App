import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/Home/home_page.dart';
import 'package:todo_app/Home/splash_screen.dart';
import 'package:todo_app/Store/local.dart';
import 'package:todo_app/Style/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  bool isChangeTheme = true;
  @override
  void initState() {
    getTheme();
    super.initState();
  }

  getTheme() async {
    isChangeTheme = await LocalStore.getTheme();

    setState(() {});
  }

  void change() {
    isChangeTheme = !isChangeTheme;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            themeMode: isChangeTheme ? ThemeMode.light : ThemeMode.dark,
            theme: ThemeData(
              scaffoldBackgroundColor: Style.whiteColor,
              appBarTheme: AppBarTheme(
                backgroundColor: Style.primaryColor,
                titleTextStyle: Style.textStyleNormal(
                  textColor: Style.whiteColor,
                  size: 20,
                ),
              ),
              textTheme: TextTheme(
                headline1: Style.textStyleNormal(
                    size: 26, textColor: Style.blackColor),
                headline2: Style.textStyleNormal(
                    size: 13, textColor: Style.blackColor),
              ),
            ),
            darkTheme: ThemeData(
              textTheme: TextTheme(
                headline1: Style.textStyleNormal(
                    size: 26, textColor: Style.whiteColor),
                headline2: Style.textStyleNormal(
                    size: 13, textColor: Style.whiteColor,),
              ),
              scaffoldBackgroundColor: Style.darkModeColor,
              appBarTheme: AppBarTheme(
                backgroundColor: Style.primaryColor,
                titleTextStyle: Style.textStyleNormal(
                  textColor: Style.whiteColor,
                  size: 20,
                ),
              ),
            ),
            home: SplashScreen(),
          );
        });
  }
}
