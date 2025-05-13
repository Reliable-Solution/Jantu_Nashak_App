// flutter
import 'package:flutter/material.dart';
// // constants
// import 'package:getxnative/constants/colorConst.dart';
// // theme
// import 'package:getxnative/theme/nativeTheme.dart';
// // widget
// import 'package:getxnative/widget/textWidget.dart';
import 'package:keep_app/widget/textWidget.dart';

import '../Theme/nativeTheme.dart';
import '../constant/colorConst.dart';

class DropDownWidget extends StatelessWidget {
  final String? dropdownInitialValue;
  final List<String>? items;
  final Widget? hint;
  final String? label;
  final Function()? onTap;
  final Function(String?)? onChanged;
  final FocusNode? focusNode;
  DropDownWidget({Key? key, this.dropdownInitialValue, this.hint, @required this.focusNode, this.label, this.items, this.onChanged, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButtonFormField(
        focusNode: focusNode,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: COLOR.pink),
          ),
          labelText: label,
          labelStyle: Themes.light.textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.w500,
            color: (focusNode != null && focusNode!.hasFocus) ? COLOR.pink : COLOR.grey,
          ),
        ),
        hint: hint,
        isExpanded: true,
        iconSize: 28,
        value: dropdownInitialValue,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: COLOR.greyback,
        ),
        items: items!.map((String items) {
          return DropdownMenuItem(
            value: items,
            enabled: true,
            child: TextWiget(
              title: items,
              style: Themes.light.textTheme.bodyLarge!,
            ),
          );
        }).toList(),
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }
}
