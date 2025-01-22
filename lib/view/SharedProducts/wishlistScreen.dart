// //flutter
// import 'package:flutter/material.dart';
// //package
// import 'package:get/get.dart';
// //constants
// import 'package:getxnative/constants/colorConst.dart';
// //controllers
// import 'package:getxnative/controllers/shareProductsController.dart';
// //theme
// import 'package:getxnative/theme/nativeTheme.dart';
// //widget
// import 'package:getxnative/widget/alignWidget.dart';
// import 'package:getxnative/widget/iconButtonWidget.dart';
// import 'package:getxnative/widget/textWidget.dart';
//
// class WishlistScreen extends StatelessWidget {
//   final ShareProductController _controller = Get.find<ShareProductController>();
//   WishlistScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverGrid(
//           delegate: SliverChildBuilderDelegate(
//             (context, index) {
//               final products = _controller.wishlistList[index];
//               return InkWell(
//                 onTap: () {},
//                 child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: COLOR.background,
//                     borderRadius: BorderRadius.circular(0),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Container(
//                         height: (MediaQuery.of(context).size.height * 18) / 100,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               products.imageUrl!,
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                           child: AlignWidget(
//                             alignment: Alignment.topRight,
//                             child: GetBuilder<ShareProductController>(
//                               builder: (_controller) => CircleAvatar(
//                                 maxRadius: 15,
//                                 backgroundColor: COLOR.background.withOpacity(0.8),
//                                 child: IconButtonWidget(
//                                   voidCallback: () {
//                                     if (products.isFavorite == false) {
//                                       products.isFavorite = true;
//                                     } else {
//                                       products.isFavorite = false;
//                                     }
//                                     _controller.update();
//                                   },
//                                   color: products.isFavorite == false ? COLOR.pink : COLOR.black,
//                                   icons: products.isFavorite == false ? Icons.favorite : Icons.favorite_border,
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                           child: Column(
//                             children: <Widget>[
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(bottom: 5),
//                                           child: AlignWidget(
//                                             alignment: Alignment.centerLeft,
//                                             child: TextWiget(
//                                               title: '${products.name}',
//                                               style: Themes.light.textTheme.bodyMedium!.copyWith(
//                                                 color: COLOR.grey,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             TextWiget(
//                                               title: '₹${products.price!.toStringAsFixed(0)} ',
//                                               style: Themes.dark.textTheme.displayMedium,
//                                             ),
//                                             TextWiget(
//                                               title: '${products.price!.toStringAsFixed(0)}',
//                                               style: Themes.light.textTheme.bodyMedium!.copyWith(
//                                                 color: COLOR.grey,
//                                                 decoration: TextDecoration.lineThrough,
//                                               ),
//                                             ),
//                                             TextWiget(
//                                               title: ' 9% off',
//                                               style: Themes.dark.textTheme.displayLarge!.copyWith(
//                                                 color: COLOR.green,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 30,
//                                     child: IconButtonWidget(
//                                       voidCallback: () {},
//                                       icons: Icons.share_outlined,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               AlignWidget(
//                                 alignment: Alignment.centerLeft,
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                                   decoration: BoxDecoration(
//                                     color: COLOR.green50,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: TextWiget(
//                                     title: '₹${products.price!.toStringAsFixed(0)} with 1 Special Offer',
//                                     style: Themes.light.textTheme.displayMedium!.copyWith(color: COLOR.green, fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 5),
//                                 child: AlignWidget(
//                                   alignment: Alignment.centerLeft,
//                                   child: SizedBox(
//                                     height: 15,
//                                     child: Row(
//                                       children: [
//                                         TextWiget(title: '₹5 Off', style: Themes.light.textTheme.displayMedium),
//                                         VerticalDivider(
//                                           thickness: 0.5,
//                                           width: 6,
//                                           color: COLOR.black,
//                                         ),
//                                         TextWiget(
//                                           title: '1st Order Discount',
//                                           style: Themes.light.textTheme.displayMedium,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               AlignWidget(
//                                 alignment: Alignment.centerLeft,
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                                   decoration: BoxDecoration(
//                                     color: COLOR.greyLight.withOpacity(0.5),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: TextWiget(
//                                     title: 'Free Delivery',
//                                     style: Themes.light.textTheme.headlineMedium!.copyWith(color: COLOR.black),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: AlignWidget(
//                                   alignment: Alignment.centerLeft,
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
//                                         decoration: BoxDecoration(
//                                           color: COLOR.green,
//                                           borderRadius: BorderRadius.circular(20),
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             TextWiget(
//                                               title: '${products.rate}',
//                                               style: Themes.light.textTheme.displaySmall!.copyWith(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: COLOR.background,
//                                               ),
//                                             ),
//                                             Icon(Icons.star, size: 13, color: COLOR.background)
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 4),
//                                         child: TextWiget(
//                                           title: '(28,717)',
//                                           style: Themes.light.textTheme.bodyMedium!.copyWith(color: COLOR.grey),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//             childCount: _controller.wishlistList.length,
//           ),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: Get.height > 800 ? 1.27 / 2 : 1 / 2,
//             crossAxisSpacing: 2,
//             mainAxisSpacing: 2,
//           ),
//         ),
//       ],
//     );
//   }
// }
