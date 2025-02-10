

import 'package:flutter/cupertino.dart';
import 'package:keep_app/constant/colorConst.dart';

class ButtonDataConst extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final Color? color;
  final BoxShape? shape;
  final double? topPadding,bottomPadding;
  const ButtonDataConst({Key? key,this.shape,this.color,this.onPressed,this.child,this.topPadding,this.bottomPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.only(top: topPadding ??10,left: 12,right: 12,bottom: bottomPadding ?? 10),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 40,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color ?? COLOR.appBaseColor,
              shape: shape ?? BoxShape.rectangle
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: child,
          )),
        ),
      ),
    );
  }
}
