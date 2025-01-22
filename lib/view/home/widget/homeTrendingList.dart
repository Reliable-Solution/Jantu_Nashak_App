// // flutter
// import 'package:flutter/material.dart';
// // package
// import 'package:get/get.dart';
// // controllers
//
// import 'package:keep_app/constant/colorConst.dart';
// import 'package:keep_app/controller/homeController.dart';
// import 'package:keep_app/theme/nativeTheme.dart';
// import 'package:keep_app/widget/textWidget.dart';
//
// class HomeTrendingList extends StatelessWidget {
//   final HomeController _controller = Get.find<HomeController>();
//   HomeTrendingList({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15),
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height * 0.06,
//             width: MediaQuery.of(context).size.width,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   TextWiget(
//                     title: 'Trending Now',
//                     style: Themes.light.textTheme.headlineSmall,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       // Get.to(() => TrendingScreen());
//                     },
//                     child: TextWiget(
//                       title: 'VIEW ALL',
//                       style: Themes.light.textTheme.displayLarge!.copyWith(
//                         color: COLOR.pink,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.23,
//             color: COLOR.background,
//             child: ListView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               scrollDirection: Axis.horizontal,
//               itemCount: _controller.trendingList.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: InkWell(
//                         onTap: () {
//                           // Get.to(() => PriceStroeScreen());
//                         },
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.15,
//                           width: 100,
//                           decoration: BoxDecoration(
//                             color: COLOR.amber,
//                             image: DecorationImage(
//                               colorFilter: new ColorFilter.mode(COLOR.black.withOpacity(0.8), BlendMode.dstATop),
//                               image: NetworkImage(
//                                 _controller.trendingList[index].image!,
//                               ),
//                               fit: BoxFit.cover,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: TextWiget(
//                           title: '${_controller.trendingList[index].name}',
//                           style: Themes.light.textTheme.bodyLarge!.copyWith(
//                             color: COLOR.grey,
//                             fontWeight: FontWeight.w600,
//                           )),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 0),
//                       child: TextWiget(
//                         title: 'From ₹${_controller.trendingList[index].price!.toStringAsFixed(0)}',
//                         style: Themes.light.textTheme.displaySmall!.copyWith(
//                           color: COLOR.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
