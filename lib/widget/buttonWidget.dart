// Flutter
import 'package:flutter/material.dart';
import 'package:keep_app/widget/textWidget.dart';
// Common Widgets

class ButtonWidgets extends StatelessWidget {
  final VoidCallback? voidCallback;
  final String? title;
  final Color? color;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  ButtonWidgets({
    @required this.title,
    this.padding,
    @required this.voidCallback,
    @required this.color,
    @required this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FittedBox(
          child: TextWiget(
            title: '$title',
            style: style!,
          ),
        ),
      ),
      onPressed: voidCallback,
      style: ElevatedButton.styleFrom(
        padding: padding ?? null,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
