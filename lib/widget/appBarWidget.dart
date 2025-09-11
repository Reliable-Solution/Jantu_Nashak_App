//flutter
import 'package:flutter/material.dart';

import '../constant/colorConst.dart';
//constants

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;

  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  final double? elevation;
  final double? titleSpacing;

  final double? appbarPadding;
  final double? actionPadding;

  const MyCustomAppBar({
    Key? key,
    @required this.height,
    this.title,
    this.appbarPadding,
    this.titleSpacing,
    this.elevation,
    this.action,
    this.leading,
    this.actionPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: appbarPadding!, bottom: appbarPadding!),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            actionsPadding: EdgeInsets.all(actionPadding ?? 0),
            leading: leading,
            backgroundColor: Color(0xff226706),
            elevation: elevation,
            titleSpacing: titleSpacing,
            centerTitle: false,
            title: title,
            actions: action,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}
