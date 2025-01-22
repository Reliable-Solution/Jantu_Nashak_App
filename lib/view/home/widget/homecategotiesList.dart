// //  flutter
// import 'package:flutter/material.dart';
// // package
// import 'package:get/get.dart';
// // constants
// import 'package:getxnative/constants/colorConst.dart';
// // controllers
// import 'package:getxnative/controllers/homeController.dart';
// //theme
// import 'package:getxnative/theme/nativeTheme.dart';
// // views
// import 'package:getxnative/views/dashboard/dashboardScreen.dart';
// import 'package:getxnative/views/home/bestSellersScreen.dart';
// // widget
// import 'package:getxnative/widget/textWidget.dart';
//
// class HomecategoriesList extends StatelessWidget {
//   final HomeController _controller = Get.find<HomeController>();
//
//   HomecategoriesList({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: <Widget>[
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(horizontal: 15),
//               //   child: InkWell(
//               //     onTap: () {
//               //         Get.to(() => DeshboardScreen(pageIndex: 1));
//               //     },
//               //     child: CircleAvatar(
//               //       maxRadius: 30,
//               //       backgroundColor: COLOR.pinkLight,
//               //       child: Center(
//               //         child: Icon(
//               //           Icons.grid_view_rounded,
//               //           color: COLOR.pink,
//               //           size: 40,
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               // SizedBox(
//               //   width: 75,
//               //   child: Padding(
//               //     padding: const EdgeInsets.only(top: 8.0),
//               //     child: TextWiget(
//               //       title: 'Categories',
//               //       style: Themes.light.textTheme.bodyLarge,
//               //     ),
//               //   ),
//               // )
//             ],
//           ),
//           Row(
//             children: List.generate(
//               _controller.categoryList.length,
//               (index) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       child: Container(
//                         width: 60,
//                         height: 60,
//                         child: InkWell(
//                           onTap: () {
//                               Get.to(() => BestSellersScreen());
//                           },
//                           child: CircleAvatar(
//                             maxRadius: 30,
//                             backgroundColor: COLOR.transparent,
//                             backgroundImage: AssetImage(  _controller.categoryList[index].categoryImage!,)
//                             // NetworkImage(
//                             //   _controller.categoryList[index].imageUrl!,
//                             // ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: TextWiget(
//                         title: _controller.categoryList[index].categoryName,
//                         style: Themes.light.textTheme.bodyLarge,
//                       ),
//                     )
//                   ],
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
