// flutter
import 'package:flutter/material.dart';
// package
import 'package:get/get.dart';
// // theme
// import 'package:getxnative/Theme/nativeTheme.dart';
// // constants
// import 'package:getxnative/constants/colorConst.dart';
// // controllers
// import 'package:getxnative/controllers/editProfileController.dart';
// // views
// import 'package:getxnative/views/acc ̰ount/widget/settingContainer.dart';
// // widget
// import 'package:getxnative/widget/dividerWidgets.dart';
// import 'package:getxnative/widget/textWidget.dart';
import 'package:keep_app/view/account/widget/settingContainer.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../utils/string_res.dart';
import '../../widget/dividerWidgets.dart';
import '../../widget/textWidget.dart';

class EditProfileSettingScreen extends StatelessWidget {
  EditProfileSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextWiget(
              title: StringRes.socialProfile,
              style: Themes.light.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
