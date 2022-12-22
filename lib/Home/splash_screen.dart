import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:todo_app/Home/home_page.dart';
import 'package:todo_app/Style/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    Future.delayed(Duration(seconds: 4), () {
      isLoading = false;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: ((context) => HomePage())),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/Logo.png',
              height: 250,
              width: 250,
            ),
            Text(
              'Todo App',
              style: Theme.of(context).textTheme.headline1,
            ),
            12.verticalSpace,
            Text(
              'The best to do list application for you',
              style: Theme.of(context).textTheme.headline2,
            ),
            50.verticalSpace,
            isLoading
                ? LoadingAnimationWidget.beat(
                    color: Color(0xff24A19C), size: 40)
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
