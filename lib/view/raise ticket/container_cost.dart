import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerConst extends StatelessWidget {
  final double? topPadding,
      bottomPadding,
      leftPadding,
      rightPadding,
      radius,
      height,
      width;
  final Widget? child;
  final Color? color;
  final Function()? onTap;
  final Border? border;
  const ContainerConst(
      {Key? key,
      this.bottomPadding,
      this.onTap,
      this.border,
      this.child,
      this.color,
      this.height,
      this.width,
      this.leftPadding,
      this.radius,
      this.rightPadding,
      this.topPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(
            top: topPadding ?? 8,
            left: leftPadding ?? 12,
            right: rightPadding ?? 12,
            bottom: bottomPadding ?? 0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
              height: height ?? size.height,
              width: width ?? size.width,
              decoration: BoxDecoration(
                  color: color ?? Colors.white,
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  border: border),
              child: child),
        ));
  }
}

class ContainerConstWithoutHW extends StatelessWidget {
  final double? topPadding, bottomPadding, leftPadding, rightPadding, radius;
  final Widget? child;
  final Color? color;
  final Function()? onTap;
  const ContainerConstWithoutHW(
      {Key? key,
      this.bottomPadding,
      this.onTap,
      this.child,
      this.color,
      this.leftPadding,
      this.radius,
      this.rightPadding,
      this.topPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: topPadding ?? 8,
            left: leftPadding ?? 12,
            right: rightPadding ?? 12,
            bottom: bottomPadding ?? 0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                color: color ?? Colors.white,
                borderRadius: BorderRadius.circular(radius ?? 10)),
            child: Padding(
                padding:
                    EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
                child: child),
          ),
        ));
  }
}
