//flutter
import 'package:flutter/material.dart';
//package
import 'package:get/get.dart';
import 'package:keep_app/constant/colorConst.dart';
//constants

class Themes {
  static final light = ThemeData(
    // backgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: COLOR.pink),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        color: Colors.black87,
      ),
      displayLarge: TextStyle(
        color: Colors.black87,
        fontFamily: 'assets/fonts/GentiumPlus-Bold.ttf',
        fontSize: 15,
      ),
      displaySmall: TextStyle(
        // fontSize: Get.width > 360 ? 16 : 14,
        fontFamily: 'assets/fontsGentiumPlus-Regular.ttf',
        color: Colors.black87,
      ),
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 11,
      ),
      headlineMedium: TextStyle(
        color: Colors.grey,
        fontSize: 10,
      ),
      headlineSmall: TextStyle(
        color: COLOR.black,
        fontSize: 21,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: COLOR.pink,
      ),
    ),
  );
  static final dark = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 24,
        color: COLOR.black,
      ),
      bodyMedium: TextStyle(
        color: COLOR.green,
        fontWeight: FontWeight.w500,
        fontSize: 27,
      ),
      displayLarge: TextStyle(
        fontSize: 12,
        color: COLOR.black,
      ),
      displayMedium: TextStyle(
        fontSize: 16,
        color: COLOR.black,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        fontSize: 13,
        color: COLOR.black,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontSize: 19,
        color: COLOR.black,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        fontSize: 17,
        color: COLOR.black,
      ),
      titleLarge: TextStyle(
        fontSize: 17,
        color: COLOR.black,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
