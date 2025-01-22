// //  flutte
// import 'package:flutter/material.dart';
// // package
// import 'package:get/get.dart';
// // constants
// import 'package:getxnative/constants/colorConst.dart';
// // controllers
// import 'package:getxnative/controllers/homeController.dart';
// // theme
// import 'package:getxnative/theme/nativeTheme.dart';
// // views
// import 'package:getxnative/views/home/priceStroescreen.dart';
// // widget
// import 'package:getxnative/widget/alignWidget.dart';
// import 'package:getxnative/widget/textWidget.dart';
//
// class HomePriceList extends StatelessWidget {
//   final HomeController _controller = Get.find<HomeController>();
//   HomePriceList({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 15, bottom: 5),
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: AlignWidget(
//               alignment: Alignment.centerLeft,
//               child: TextWiget(
//                 title: 'Price Stroe',
//                 style: Themes.light.textTheme.headlineSmall,
//               ),
//             ),
//           ),
//           Container(
//             height: 100,
//             width: MediaQuery.of(context).size.width,
//             child: ListView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               scrollDirection: Axis.horizontal,
//               itemCount: _controller.price.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.only(right: Get.width > 360 ? 45 : 20),
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(bottom: 5, top: 8),
//                         child: InkWell(
//                           onTap: () {
//                             // Get.to(() => PriceStroeScreen());
//                           },
//                           child: CircleAvatar(
//                             maxRadius: 30,
//                             child: FittedBox(
//                                 child: Column(
//                               children: [
//                                 TextWiget(
//                                   title: 'UNDER',
//                                   textAlign: TextAlign.center,
//                                   style: Themes.light.textTheme.displayMedium!.copyWith(color: COLOR.background, fontWeight: FontWeight.w700),
//                                 ),
//                                 TextWiget(
//                                   title: '₹${_controller.price[index]}',
//                                   textAlign: TextAlign.center,
//                                   style: Themes.dark.textTheme.headlineMedium!.copyWith(color: COLOR.background, fontWeight: FontWeight.normal),
//                                 ),
//                               ],
//                             )),
//                             backgroundColor: COLOR.purple,
//                           ),
//                         ),
//                       ),
//                       TextWiget(title: 'Under ₹${_controller.price[index]}'),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
