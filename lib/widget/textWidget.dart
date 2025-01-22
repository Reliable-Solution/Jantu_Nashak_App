// Flutter
import 'package:flutter/material.dart';
//Packages

import '../theme/nativeTheme.dart';

class TextWiget extends StatelessWidget {
  final String? title;
  final TextStyle? style;
  final TextAlign? textAlign;
  TextWiget({
    @required this.title,
    this.style,
    this.textAlign,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '$title',
        style: style ?? Themes.dark.textTheme.displayLarge,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
