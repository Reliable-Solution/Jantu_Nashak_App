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
import '../../widget/dividerWidgets.dart';
import '../../widget/textWidget.dart';

class EditProfileSettingScreen extends StatelessWidget {
  // final EditProfileController _controller = Get.find<EditProfileController>();
  EditProfileSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextWiget(
              title: 'Choose the information you want to show on your social profile.',
              style: Themes.light.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.2,
          //   color: COLOR.background,
          //   child: Obx(
          //         () => Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Settingcontainer(
          //           // value: _controller.switchVal1.value,
          //           title: 'Show my Wishlist',
          //           onChanged: (bool value) {
          //             // _controller.onSwitchedValue1();
          //           },
          //         ),
          //         DividerWidget(thickness: 1, height: 0),
          //         Settingcontainer(
          //           // value: _controller.switchval2.value,
          //           title: 'Show Shared Products',
          //           onChanged: (bool value) {
          //             // _controller.onSwitchedValue2();
          //           },
          //         ),
          //         DividerWidget(thickness: 1, height: 0),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
