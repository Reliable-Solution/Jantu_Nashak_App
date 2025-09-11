// flutter
import 'package:flutter/material.dart';
import 'package:keep_app/constant/colorConst.dart';
// constants

class TextButtonWidget extends StatelessWidget {
  final String? text;
  final int? border;
  final TextStyle? style;
  final Color? color;
  final void Function()? onPressed;
  final FocusNode? focusNode;
  const TextButtonWidget({
    @required this.text,
    this.style,
    this.border,
    this.focusNode,
    this.color,
    @required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: focusNode,
      child: Text(
        text!,
        style: style,
      ),
      style: border == 1
          ? null
          : ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 10, vertical: 11),
              ),
              foregroundColor:
                  MaterialStateProperty.all<Color>(color ?? COLOR.appBaseColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: color ?? COLOR.appBaseColor),
                ),
              ),
            ),
      onPressed: onPressed,
    );
  }
}
