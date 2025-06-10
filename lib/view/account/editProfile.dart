// flutter
import 'package:flutter/material.dart';
// package
import 'package:get/get.dart';
// // constants
// import 'package:getxnative/constants/colorConst.dart';
// // controllers
// import 'package:getxnative/controllers/editProfileController.dart';
// // theme
// import 'package:getxnative/theme/nativeTheme.dart';
// // views
// import 'package:getxnative/views/editProfile/EditProfileSetting.dart';
// import 'package:getxnative/views/editProfile/primaryScreen.dart';
// // widget
// import 'package:getxnative/widget/alignWidget.dart';
// import 'package:getxnative/widget/appBarWidget.dart';
// import 'package:getxnative/widget/buttonWidget.dart';
// import 'package:getxnative/widget/dividerWidgets.dart';
// import 'package:getxnative/widget/tabbarViewWidgets.dart';
// import 'package:getxnative/widget/textWidget.dart';
import 'package:keep_app/view/account/primary.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../controller/editController.dart';
import '../../utils/string_res.dart';
import '../../widget/alignWidget.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/buttonWidget.dart';
import '../../widget/dividerWidgets.dart';
import '../../widget/tabbarWidget.dart';
import '../../widget/textWidget.dart';
import 'editProfileSetting.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
   final EditProfileController _controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: MyCustomAppBar(
          height: 90,
          appbarPadding: 0,
          elevation: 1,
          titleSpacing: 0.0,
          title: TextWiget(
            title: StringRes.profileInformation,
            style: Themes.light.textTheme.displayLarge,
          ),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: COLOR.greyback,
              size: 20,
            ),
          ),
        ),
        backgroundColor: COLOR.greyLight,
        body: Column(
          children: <Widget>[
            Container(
              color: COLOR.background,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AlignWidget(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                       controller: _controller.tabController,
                      indicatorColor: COLOR.pink,
                      unselectedLabelColor: COLOR.black,
                      labelColor: COLOR.pink,
                       tabs: _controller.editprofileTabs,
                    ),
                  ),
                  DividerWidget(thickness: 1, height: 0.0),
                ],
              ),
            ),
            Expanded(
              child: TabbarViewWidget(
                 controller: _controller.tabController,
                children: [
                  SingleChildScrollView(child: PrimaryScreen()),
                  // EditProfileSettingScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
