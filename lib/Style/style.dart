import 'package:flutter/material.dart';

class Style {
  Style._();

  // ---------- Color   ---------- //

  static const primaryColor = Color(0xff24A19C);
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;

  // ---------- Gradient   ---------- //

  static const linearGradient = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [
        Color(0xff24A19C),
        Color(0x4024A19C),
      ]);

  static const primaryDisabledGradient = LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [
        Color.fromARGB(255, 167, 221, 219),
        Color(0x1524A19C),
      ]);

  static const darkModeColor = Colors.black;

  static textStyleSemiBold({double size = 18, Color textColor = blackColor}) =>
      TextStyle(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.w600,
      );

  static textStyleNormal(
          {double size = 16,
          Color textColor = blackColor,
          bool isDone = false}) =>
      TextStyle(
          fontSize: size,
          color: textColor,
          fontWeight: FontWeight.normal,
          decoration:
              isDone ? TextDecoration.lineThrough : TextDecoration.none);

  static textStyleBold({double size = 18, Color textColor = blackColor}) =>
      TextStyle(fontSize: size, color: textColor, fontWeight: FontWeight.bold);

  static textStyleSemiRegular(
          {double size = 16, Color textColor = blackColor}) =>
      TextStyle(fontSize: size, color: textColor, fontWeight: FontWeight.w400);
}
