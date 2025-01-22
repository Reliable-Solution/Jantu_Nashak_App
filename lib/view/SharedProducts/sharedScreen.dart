// //  flutter
// import 'package:flutter/material.dart';
// // package
// import 'package:get/get.dart';
// // controllers
// import 'package:getxnative/controllers/homeController.dart';
// // views
// import 'package:getxnative/views/home/widget/homeProductList.dart';
//
// class SharedScreen extends StatelessWidget {
//   final HomeController _controller = Get.find<HomeController>();
//   SharedScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverGrid(
//           delegate: SliverChildBuilderDelegate(
//             (context, index) {
//               final products = _controller.productsList[index];
//               return HomeProductList(products: products);
//             },
//             childCount: _controller.productsList.length - 3,
//           ),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: Get.width >= 480 ? 1.15 / 2 : 1 / 2.1,
//             crossAxisSpacing: 2,
//             mainAxisSpacing: 2,
//           ),
//         ),
//       ],
//     );
//   }
// }
