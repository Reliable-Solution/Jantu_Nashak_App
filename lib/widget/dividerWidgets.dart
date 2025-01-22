// flutter
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double? height;
  final double? thickness;
  const DividerWidget({
    this.height,
    this.thickness,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      height: height ?? 1,
    );
  }
}
