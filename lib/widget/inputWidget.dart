// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Packages
import 'package:get/get.dart';
import 'package:keep_app/constant/colorConst.dart';
import 'package:keep_app/theme/nativeTheme.dart';
// constants
// theme

class InputFiledArea extends StatelessWidget {
  final String? hintText;
  final String? suffixText;
  final String? counterText;
  final String? helperText;
  final String? initialValue;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? enabled;
  final bool? readOnly;
  final int? border;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final int? maxlength;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final TextStyle? style;
  final bool? autoFocus;
  final EdgeInsetsGeometry? contentPadding;
  final String? validationMessage;

  InputFiledArea({
    Key? key,
    this.border,
    this.labelText,
    this.hintText,
    this.suffixText,
    this.prefixIcon,
    this.counterText,
    this.helperText,
    this.initialValue,
    this.suffixIcon,
    this.enabled,
    this.contentPadding,
    this.readOnly,
    @required this.keyboardType,
    this.validator,
    @required this.controller,
    this.maxlength,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.autoFocus,
    this.style,
    this.validationMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxlength,
      onSaved: onSaved,
      onChanged: onChanged,
      onTap: onTap,
      enabled: enabled,
      readOnly: false,
      focusNode: focusNode,
      style: style ?? Themes.light.textTheme.labelLarge,
      initialValue: initialValue,
      inputFormatters: [
        if (maxlength != null) LengthLimitingTextInputFormatter(maxlength)
      ],
      decoration: InputDecoration(
        isDense: true,
        labelText: labelText,
        labelStyle: TextStyle(
          color: (focusNode != null && focusNode!.hasFocus)
              ? COLOR.appBaseColor
              : COLOR.black,
        ),
        prefixIcon: prefixIcon,
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ?? null,
        counterText: counterText,
        helperText: helperText,
        suffixStyle: Get.theme.textTheme.titleMedium,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffDEDEDE)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffDEDEDE)),
        ),
        enabledBorder: (border == 1)
            ? OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              )
            : UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: (border == 1)
            ? OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: COLOR.appBaseColor),
              ),
      ),
      validator: validator,
    );
  }
}
