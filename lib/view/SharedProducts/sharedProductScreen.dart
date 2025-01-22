// //  flutter
// import 'package:flutter/material.dart';
// // package
// import 'package:get/get.dart';
// // constants
// import 'package:getxnative/constants/colorConst.dart';
// // controllers
// import 'package:getxnative/controllers/shareProductsController.dart';
// // theme
// import 'package:getxnative/theme/nativeTheme.dart';
// // views
// import 'package:getxnative/views/SharedProducts/sharedScreen.dart';
// import 'package:getxnative/views/SharedProducts/wishlistScreen.dart';
// // widget
// import 'package:getxnative/widget/alignWidget.dart';
// import 'package:getxnative/widget/appBarWidget.dart';
// import 'package:getxnative/widget/dividerWidgets.dart';
// import 'package:getxnative/widget/tabbarViewWidgets.dart';
// import 'package:getxnative/widget/textWidget.dart';
//
// class ShareProductScreen extends StatelessWidget {
//   final ShareProductController _controller = Get.find<ShareProductController>();
//   ShareProductScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyCustomAppBar(
//         height: 90,
//         appbarPadding: 0,
//         elevation: 1,
//         titleSpacing: 0.0,
//         title: TextWiget(
//           title: 'MY PRODUCTS',
//           style: Themes.light.textTheme.displayLarge,
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
//       ),
//       backgroundColor: COLOR.greyLight,
//       body: Column(
//         children: <Widget>[
//           Container(
//             color: COLOR.background,
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
//                 AlignWidget(
//                   alignment: Alignment.centerLeft,
//                   child: TabBar(
//                     isScrollable: true,
//                     indicatorSize: TabBarIndicatorSize.label,
//                     controller: _controller.tabController,
//                     indicatorColor: COLOR.pink,
//                     unselectedLabelColor: COLOR.black,
//                     labelColor: COLOR.pink,
//                     tabs: _controller.productsTabs,
//                   ),
//                 ),
//                 DividerWidget(thickness: 1, height: 0.0),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabbarViewWidget(
//               controller: _controller.tabController,
//               children: [
//                 WishlistScreen(),
//                 SharedScreen(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
