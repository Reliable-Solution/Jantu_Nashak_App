//flutter
import 'package:flutter/material.dart';
//package
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_app/constant/colorConst.dart';
//constants

class Themes {
  static final light = ThemeData(
    // backgroundColor: Colors.white,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: COLOR.appBaseColor),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
      headlineLarge: GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),

      bodyMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),

      // TextStyle(
      //     fontSize: 12,
      //     color: Colors.black87,
      //   ),
      displayLarge: GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      labelLarge: GoogleFonts.roboto(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      // displayLargeAppBar: GoogleFonts.roboto(
      // fontSize: 15,
      // fontWeight: FontWeight.bold,
      //   color: Colors.black87,
      //
      //
      // ),

      // TextStyle(
      //     color: Colors.black87,
      //     fontFamily: 'assets/fonts/GentiumPlus-Bold.ttf',
      //     fontSize: 15,
      //   ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black45,
      ),

      // TextStyle(
      //     // fontSize: Get.width > 360 ? 16 : 14,
      //     fontFamily: 'assets/fontsGentiumPlus-Regular.ttf',
      //     color: Colors.black87,
      //   ),
      //   displayMedium: TextStyle(
      //     color: Colors.black,
      //     fontSize: 11,
      //   ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 11,
        // fontWeight: FontWeight.w600,
        color: Colors.white,
      ),

      headlineMedium: TextStyle(
        color: Colors.grey,
        fontSize: 10,
      ),
      headlineSmall: GoogleFonts.robotoSerif(
        fontSize: 21,
        fontWeight: FontWeight.w700,
        color: Colors.black45,
        // color: COLOR.black,
        //     fontSize: 21,
        //     fontWeight: FontWeight.w700,
      ),

      // TextStyle(
      //     color: COLOR.black,
      //     fontSize: 21,
      //     fontWeight: FontWeight.w700,
      //   ),
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: COLOR.appBaseColor,
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
      displayMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      // displayMedium: TextStyle(
      //   fontSize: 16,
      //   color: COLOR.black,
      //   fontWeight: FontWeight.w600,
      // ),
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
