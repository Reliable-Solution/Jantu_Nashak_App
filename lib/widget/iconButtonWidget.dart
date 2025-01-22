// Flutter
import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback? voidCallback;
  final IconData? icons;
  final Color? color;

  final double? size;
  const IconButtonWidget({
    this.icons,
    @required this.voidCallback,
    this.color,
    this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: voidCallback,
      icon: Icon(
        icons,
        color: color,
        size: size ?? 25,
      ),
    );
  }
}
