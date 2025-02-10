// flutter
import 'package:flutter/material.dart';

import '../../../Theme/nativeTheme.dart';
import '../../../constant/colorConst.dart';
import '../../../widget/textWidget.dart';
// constants
class Settingcontainer extends StatelessWidget {
  final String? title;
  final void Function(bool)? onChanged;
  final bool? value;
  const Settingcontainer({
    @required this.title,
    this.value,
    @required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextWiget(
            title: title,
            style: Themes.light.textTheme.displayLarge,
          ),
          Switch(
            value: value!,
            activeColor: COLOR.background,
            activeTrackColor: COLOR.appBaseColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
