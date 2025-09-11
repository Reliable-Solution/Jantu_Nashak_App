import 'package:flutter/material.dart';
// import 'package:suratjugaad/a_structure/constant/app_styles.dart';

import '../../constant/colorConst.dart';

class AppFontStyle {
  static TextStyle extraBoldTextStyle(double fontSize,
      {Color? fontColor,
      FontWeight? fontWeight,
      bool? isUnderlined,
      bool isOtherLanguage = false}) {
    return TextStyle(
        fontFamily: 'PoppinsExtraBold',
        color: fontColor ?? COLOR.appBaseColor,
        fontSize: fontSize,
        decoration: isUnderlined ?? false
            ? TextDecoration.underline
            : TextDecoration.none,
        fontWeight: fontWeight ?? FontWeight.w800,
        decorationThickness: 1.5);
  }

  static TextStyle boldTextStyle(double fontSize,
      {Color? fontColor,
      FontWeight? fontWeight,
      bool? isUnderlined,
      bool isOtherLanguage = false}) {
    return TextStyle(
        fontFamily: 'PoppinsBold',
        color: fontColor ?? COLOR.appBaseColor,
        fontSize: fontSize,
        decoration: isUnderlined ?? false
            ? TextDecoration.underline
            : TextDecoration.none,
        fontWeight: fontWeight ?? FontWeight.w700,
        decorationThickness: 1.5);
  }

  static TextStyle semiBoldTextStyle(double fontSize,
      {Color? fontColor,
      FontWeight? fontWeight,
      bool? isUnderlined,
      bool isOtherLanguage = false}) {
    return TextStyle(
        decoration: isUnderlined ?? false
            ? TextDecoration.underline
            : TextDecoration.none,
        fontFamily: 'PoppinsSemiBold',
        color: fontColor ?? COLOR.appBaseColor,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w600,
        decorationThickness: 1.5);
  }

  static TextStyle mediumTextStyle(double fontSize,
      {Color? fontColor,
      FontWeight? fontWeight,
      bool? isUnderlined,
      bool isOtherLanguage = false}) {
    return TextStyle(
      fontFamily: 'PoppinsMedium',
      color: fontColor ?? COLOR.appBaseColor,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w500,
      decoration: isUnderlined ?? false
          ? TextDecoration.underline
          : TextDecoration.none,
      decorationThickness: 1.5,
    );
  }

  static TextStyle regularTextStyle(double fontSize,
      {Color? fontColor,
      FontWeight? fontWeight,
      bool? isUnderlined,
      bool isOtherLanguage = false}) {
    return TextStyle(
      fontFamily: 'PoppinsRegular',
      color: fontColor ?? COLOR.appBaseColor,
      fontSize: fontSize,
      decoration: isUnderlined ?? false
          ? TextDecoration.underline
          : TextDecoration.none,
      fontWeight: fontWeight ?? FontWeight.w400,
      decorationThickness: 1.5,
    );
  }
}
