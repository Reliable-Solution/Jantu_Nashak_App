// flutter
import 'package:flutter/material.dart';

class AlignWidget extends StatelessWidget {
  final Alignment? alignment;
  final Widget? child;
  const AlignWidget({
    @required this.child,
    @required this.alignment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment!,
      child: child,
    );
  }
}
