
import 'package:flutter/material.dart';
// import 'package:suratjugaad/a_structure/constant/app_text_styles.dart';

import 'app_common_fontStyle.dart';

Widget textBold({
  required String text,
  required double fontSize,
  bool isNotLanguageConvert = false,
  Color? fontColor,
  TextAlign? textAlign,
  bool? isUnderlined,
  TextOverflow? textOverflow,
}) {
  return Text(
    text,
    // isNotLanguageConvert ? text :text.tr(),
    style: AppFontStyle.boldTextStyle(fontSize,
        fontColor: fontColor,
        isUnderlined: isUnderlined),
    textAlign: textAlign ?? TextAlign.start,
    overflow: textOverflow,
  );
}
Widget textExtraBold({
  required String text,
  required double fontSize,
  bool isNotLanguageConvert = false,
  Color? fontColor,
  TextAlign? textAlign,
  bool? isUnderlined,
  TextOverflow? textOverflow,
}) {
  return Text(
    text,
    // isNotLanguageConvert ? text :text.tr(),
    style: AppFontStyle.extraBoldTextStyle(fontSize,
        fontColor: fontColor,
        isUnderlined: isUnderlined),
    textAlign: textAlign ?? TextAlign.start,
    overflow: textOverflow,
  );
}
Widget textSemiBold({
  required String text,
  required double fontSize,
  bool isNotLanguageConvert = false,
  Color? fontColor,
  TextAlign? textAlign,
  bool? isUnderlined,
  TextOverflow? textOverflow,
}) {
  return Text(
    text,
    // isNotLanguageConvert ? text :text.tr(),
    style: AppFontStyle.semiBoldTextStyle(fontSize,
        fontColor: fontColor,
        isUnderlined: isUnderlined),
    textAlign: textAlign ?? TextAlign.start,
    overflow: textOverflow,
  );
}
Widget textMedium({
  required String text,
  required double fontSize,
  bool isNotLanguageConvert = false,
  Color? fontColor,
  TextAlign? textAlign,
  bool? isUnderlined,
  TextOverflow? textOverflow,
  int? maxLines
}) {
  return Text(
    text,
    // isNotLanguageConvert ? text :text.tr(),
    style: AppFontStyle.mediumTextStyle(fontSize,
        fontColor: fontColor,
        isUnderlined: isUnderlined),
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxLines,
    overflow: textOverflow,
  );
}
Widget textRegular({
  required String text,
  required double fontSize,
  bool isNotLanguageConvert = false,
  Color? fontColor,
  TextAlign? textAlign,
  bool? isUnderlined,
  TextOverflow? textOverflow,
}) {
  return Text(
    text,
    // isNotLanguageConvert ? text :text.tr(),
    style: AppFontStyle.regularTextStyle(fontSize,
        fontColor: fontColor,
        isUnderlined: isUnderlined),
    textAlign: textAlign ?? TextAlign.start,
    overflow: textOverflow,
  );
}