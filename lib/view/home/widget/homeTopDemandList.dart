// //flutter
// import 'package:flutter/material.dart';
// //package
// import 'package:get/get.dart';
// //constants
// import 'package:keep_app/constant/colorConst.dart';
// import 'package:keep_app/controller/homeController.dart';
// import 'package:keep_app/theme/nativeTheme.dart';
// import 'package:keep_app/widget/alignWidget.dart';
// import 'package:keep_app/widget/textWidget.dart';
//
// class TopDemandList extends StatelessWidget {
//   final HomeController _controller = Get.find<HomeController>();
//   TopDemandList({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 15, bottom: 10),
//       child: Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: AlignWidget(
//               alignment: Alignment.centerLeft,
//               child: TextWiget(
//                 title: 'Top Demand',
//                 style: Themes.light.textTheme.headlineSmall,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.22,
//               color: COLOR.background,
//               child: ListView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _controller.topDemandList.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           // Get.to(() => TrendingScreen());
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 10),
//                           child: Container(
//                             height: Get.width > 360 ? MediaQuery.of(context).size.height * 0.14 : MediaQuery.of(context).size.height * 0.15,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               color: COLOR.amber,
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 colorFilter: new ColorFilter.mode(COLOR.black.withOpacity(0.8), BlendMode.dstATop),
//                                 image: NetworkImage(
//                                   _controller.topDemandList[index].image!,
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: TextWiget(
//                             title: '${_controller.topDemandList[index].name}',
//                             style: Themes.light.textTheme.bodyLarge!.copyWith(
//                               color: COLOR.grey,
//                               fontWeight: FontWeight.w600,
//                             )),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 0),
//                         child: TextWiget(
//                           title: 'From ₹${_controller.topDemandList[index].price!.toStringAsFixed(0)}',
//                           style: Themes.light.textTheme.displaySmall!.copyWith(
//                             color: COLOR.black,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       )
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
