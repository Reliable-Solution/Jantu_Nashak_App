// //  flutter
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// // package
// import 'package:get/get.dart';
// // // utils
// // import 'package:getxnative/utils/global.dart' as global;
// // //constants
// // import 'package:getxnative/constants/colorConst.dart';
// // import 'package:getxnative/constants/imagesConst.dart';
// // //controllers
// // import 'package:getxnative/controllers/profileController.dart';
// // //theme
// // import 'package:getxnative/theme/nativeTheme.dart';
// // //views
// // import 'package:getxnative/views/SharedProducts/sharedScreen.dart';
// // import 'package:getxnative/views/SharedProducts/wishlistScreen.dart';
// // import 'package:getxnative/views/editProfile/EditProfileScreen.dart';
// // //widget
// // import 'package:getxnative/widget/alignWidget.dart';
// // import 'package:getxnative/widget/tabbarViewWidgets.dart';
// // import 'package:getxnative/widget/appBarWidget.dart';
// // import 'package:getxnative/widget/dividerWidgets.dart';
// // import 'package:getxnative/widget/iconButtonWidget.dart';
// // import 'package:getxnative/widget/textButtonWidget.dart';
// // import 'package:getxnative/widget/textWidget.dart';
//
// import '../../Theme/nativeTheme.dart';
// import '../../constant/colorConst.dart';
// import '../../constant/imagesConst.dart';
// import '../../widget/appBarWidget.dart';
// import '../../widget/dividerWidgets.dart';
// import '../../widget/iconButtonWidget.dart';
// import '../../widget/textButtonWidget.dart';
// import '../../widget/textWidget.dart';
// import 'editProfile.dart';
//
// class ProfileScreen extends StatelessWidget {
//   ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final snackBar = SnackBar(
//       backgroundColor: COLOR.background,
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: [
//             GestureDetector(
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: TextWiget(
//                     title: 'Gallary',
//                     style: Themes.light.textTheme.displayLarge),
//               ),
//               onTap: () {
//                 _openGallary(context);
//               },
//             ),
//             DividerWidget(),
//             GestureDetector(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 8),
//                 child: TextWiget(
//                   title: 'Camera',
//                   style: Themes.light.textTheme.displayLarge,
//                 ),
//               ),
//               onTap: () {
//                 _openCamera(context);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//     return Scaffold(
//       appBar: MyCustomAppBar(
//         height: 90,
//         appbarPadding: 0,
//         elevation: 1,
//         titleSpacing: 0.0,
//         title: TextWiget(
//           title: 'PROFILE',
//           style: Themes.light.textTheme.headlineLarge,
//         ),
//         leading: InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: COLOR.greyback,
//             size: 20,
//           ),
//         ),
//         action: [
//           TextButtonWidget(
//             onPressed: () => Get.to(() => EditProfileScreen()),
//             text: 'EDIT PROFILE',
//             style: Themes.light.textTheme.displaySmall!.copyWith(
//               color: COLOR.pink,
//               fontWeight: FontWeight.w600,
//             ),
//             border: 1,
//           )
//         ],
//       ),
//       backgroundColor: COLOR.greyLight,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               color: COLOR.background,
//               child: Stack(
//                 clipBehavior: Clip.hardEdge,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.23,
//                         decoration: BoxDecoration(
//                           color: COLOR.pink.withOpacity(0.2),
//                           image: DecorationImage(
//                             colorFilter: new ColorFilter.mode(
//                                 COLOR.black.withOpacity(0.8),
//                                 BlendMode.dstATop),
//                             image: NetworkImage(
//                               "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.07,
//                       ),
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                         alignment: Alignment.centerLeft,
//                         child: TextWiget(
//                           title: '{global.appname} User',
//                           style: Themes.light.textTheme.headlineSmall,
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 15),
//                         alignment: Alignment.centerLeft,
//                         child: TextWiget(
//                           title: 'Bardoli, Gujarat',
//                           style: Themes.light.textTheme.displaySmall,
//                         ),
//                       ),
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.12,
//                         padding:
//                             EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 TextWiget(
//                                   title: '0',
//                                   style: Themes.dark.textTheme.headlineMedium,
//                                 ),
//                                 TextWiget(
//                                   title: 'Helpfuls',
//                                   style: Themes.light.textTheme.displaySmall!
//                                       .copyWith(color: COLOR.grey),
//                                 )
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 TextWiget(
//                                   title: '0',
//                                   style: Themes.dark.textTheme.headlineMedium,
//                                 ),
//                                 TextWiget(
//                                   title: 'Followers',
//                                   style: Themes.light.textTheme.displaySmall!
//                                       .copyWith(color: COLOR.grey),
//                                 )
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 TextWiget(
//                                   title: '0',
//                                   style: Themes.dark.textTheme.headlineMedium,
//                                 ),
//                                 TextWiget(
//                                   title: 'Following',
//                                   style: Themes.light.textTheme.displaySmall!
//                                       .copyWith(color: COLOR.grey),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: DividerWidget(thickness: 1),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 10, left: 15, right: 15),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             TextWiget(
//                               title: 'About Me',
//                               style: Themes.light.textTheme.headlineSmall,
//                             ),
//                             TextButtonWidget(
//                               text: 'ADD DETAILS',
//                               style:
//                                   Themes.light.textTheme.displaySmall!.copyWith(
//                                 color: COLOR.pink,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               border: 1,
//                               // onPressed: () => Get.to(() => EditProfileScreen()),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5),
//                         child: Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                           alignment: Alignment.centerLeft,
//                           child: TextWiget(
//                               title:
//                                   'Share your journey on Mesho with other customers',
//                               style: Themes.light.textTheme.displayLarge!
//                                   .copyWith(color: COLOR.grey)),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Positioned(
//                     top: MediaQuery.of(context).size.height * 0.17,
//                     left: MediaQuery.of(context).size.width * 0.06,
//                     child: Stack(
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: COLOR.greyLight,
//                           maxRadius: 40,
//                           backgroundImage: AssetImage(Images.profileicon),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 1,
//                           child: CircleAvatar(
//                             radius: 15,
//                             backgroundColor: COLOR.grey,
//                             child: CircleAvatar(
//                               radius: 14,
//                               backgroundColor: COLOR.background,
//                               child: IconButtonWidget(
//                                 icons: Icons.camera_alt_outlined,
//                                 color: COLOR.black,
//                                 size: 20,
//                                 voidCallback: () {
//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(snackBar);
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _openGallary(BuildContext context) async {
//     final picker = ImagePicker();
//     var picture = await picker.pickImage(source: ImageSource.gallery);
//     if (picture == null) {
//       return;
//     }
//   }
//
//   _openCamera(BuildContext context) async {
//     final picker = ImagePicker();
//     var picture = await picker.pickImage(source: ImageSource.camera);
//     if (picture == null) {
//       return;
//     }
//   }
// }

//  flutter
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// package
import 'package:get/get.dart';
import 'package:keep_app/utils/string_res.dart';
// // utils
// import 'package:getxnative/utils/global.dart' as global;
// //constants
// import 'package:getxnative/constants/colorConst.dart';
// import 'package:getxnative/constants/imagesConst.dart';
// //controllers
// import 'package:getxnative/controllers/profileController.dart';
// //theme
// import 'package:getxnative/theme/nativeTheme.dart';
// //views
// import 'package:getxnative/views/SharedProducts/sharedScreen.dart';
// import 'package:getxnative/views/SharedProducts/wishlistScreen.dart';
// import 'package:getxnative/views/editProfile/EditProfileScreen.dart';
// //widget
// import 'package:getxnative/widget/alignWidget.dart';
// import 'package:getxnative/widget/tabbarViewWidgets.dart';
// import 'package:getxnative/widget/appBarWidget.dart';
// import 'package:getxnative/widget/dividerWidgets.dart';
// import 'package:getxnative/widget/iconButtonWidget.dart';
// import 'package:getxnative/widget/textButtonWidget.dart';
// import 'package:getxnative/widget/textWidget.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/dividerWidgets.dart';
import '../../widget/iconButtonWidget.dart';
import '../../widget/textButtonWidget.dart';
import '../../widget/textWidget.dart';
import 'editProfile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: COLOR.background,
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextWiget(title: StringRes.gallery, style: Themes.light.textTheme.displayLarge),
              ),
              onTap: () {
                _openGallary(context);
              },
            ),
            DividerWidget(),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextWiget(
                  title: StringRes.camera,
                  style: Themes.light.textTheme.displayLarge,
                ),
              ),
              onTap: () {
                _openCamera(context);
              },
            )
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: MyCustomAppBar(
        height: 90,
        appbarPadding: 0,
        elevation: 1,
        titleSpacing: 0.0,
        title: TextWiget(
          title: "Profile",
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
        action: [
          TextButtonWidget(
            onPressed: () => Get.to(() => EditProfileScreen()),
            text: "Edit Profile",
            style: Themes.light.textTheme.displaySmall!.copyWith(
              color: COLOR.pink,
              fontWeight: FontWeight.w600,
            ),
            border: 1,
          )
        ],
      ),
      backgroundColor: COLOR.greyLight,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: COLOR.background,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.23,
                        decoration: BoxDecoration(
                          color: COLOR.pink.withOpacity(0.2),
                          image: DecorationImage(
                            colorFilter: new ColorFilter.mode(COLOR.black.withOpacity(0.8), BlendMode.dstATop),
                            image: NetworkImage(
                              "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: TextWiget(
                          title: '{global.appname} User',
                          style: Themes.light.textTheme.headlineSmall,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.centerLeft,
                        child: TextWiget(
                          title: 'Bardoli, Gujarat',
                          style: Themes.light.textTheme.displaySmall,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextWiget(
                                  title: '0',
                                  style: Themes.dark.textTheme.headlineMedium,
                                ),
                                TextWiget(
                                  title: 'Helpfuls',
                                  style: Themes.light.textTheme.displaySmall!.copyWith(color: COLOR.grey),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextWiget(
                                  title: '0',
                                  style: Themes.dark.textTheme.headlineMedium,
                                ),
                                TextWiget(
                                  title: 'Followers',
                                  style: Themes.light.textTheme.displaySmall!.copyWith(color: COLOR.grey),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextWiget(
                                  title: '0',
                                  style: Themes.dark.textTheme.headlineMedium,
                                ),
                                TextWiget(
                                  title: 'Following',
                                  style: Themes.light.textTheme.displaySmall!.copyWith(color: COLOR.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: DividerWidget(thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextWiget(
                              title: 'About Me',
                              style: Themes.light.textTheme.headlineSmall,
                            ),
                            TextButtonWidget(
                              text: 'ADD DETAILS',
                              style: Themes.light.textTheme.displaySmall!.copyWith(
                                color: COLOR.pink,
                                fontWeight: FontWeight.w600,
                              ),
                              border: 1,
                              // onPressed: () => Get.to(() => EditProfileScreen()),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          alignment: Alignment.centerLeft,
                          child: TextWiget(title: 'Share your journey on Mesho with other customers', style: Themes.light.textTheme.displayLarge!.copyWith(color: COLOR.grey)),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.17,
                    left: MediaQuery.of(context).size.width * 0.06,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: COLOR.greyLight,
                          maxRadius: 40,
                          backgroundImage: AssetImage(Images.profileicon),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 1,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: COLOR.grey,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: COLOR.background,
                              child: IconButtonWidget(
                                icons: Icons.camera_alt_outlined,
                                color: COLOR.black,
                                size: 20,
                                voidCallback: () {
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openGallary(BuildContext context) async {
    final picker = ImagePicker();
    var picture = await picker.pickImage(source: ImageSource.gallery);
    if (picture == null) {
      return;
    }
  }

  _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    var picture = await picker.pickImage(source: ImageSource.camera);
    if (picture == null) {
      return;
    }
  }
}
