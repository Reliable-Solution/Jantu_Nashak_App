// //flutter
// import 'package:flutter/material.dart';
//
// //package
// import 'package:get/get.dart';
// import 'package:keep_app/widget/appBarWidget.dart';
//
// import '../../Theme/nativeTheme.dart';
// import '../../constant/app_constant.dart';
// import '../../constant/colorConst.dart';
// import '../../controller/shareProductsController.dart';
// import '../../widget/alignWidget.dart';
// import '../../widget/iconButtonWidget.dart';
// import '../../widget/textWidget.dart';
//
// class WishlistScreen extends StatelessWidget {
//   final ShareProductController _controller = Get.find<ShareProductController>();
//
//   WishlistScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyCustomAppBar(
//         height: 90,
//         appbarPadding: 0,
//         elevation: 1,
//         // height: 0.5,
//         title: Text("Wishlist"),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverGrid(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 // final products = _controller.wishlistList[index];
//                 return Container(
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
//                               '$IMAGE_URL ${_controller.wishList[index].packInfo![index].productdetailImages![index]}',
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 10),
//                           child: AlignWidget(
//                             alignment: Alignment.topRight,
//                             child: GetBuilder<ShareProductController>(
//                               builder: (_controller) => CircleAvatar(
//                                 maxRadius: 15,
//                                 backgroundColor:
//                                     COLOR.background.withOpacity(0.8),
//                                 child: IconButtonWidget(
//                                   voidCallback: () {
//                                     if (_controller.wishList[index].isFav ==
//                                         false) {
//                                       _controller.wishList[index].isFav = true;
//                                     } else {
//                                       _controller.wishList[index].isFav = false;
//                                     }
//                                     _controller.update();
//                                   },
//                                   color:
//                                       _controller.wishList[index].isFav == false
//                                           ? COLOR.pink400
//                                           : COLOR.black,
//                                   icons:
//                                       _controller.wishList[index].isFav == false
//                                           ? Icons.favorite
//                                           : Icons.favorite_border,
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                           child: Column(
//                             children: <Widget>[
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                     child: Column(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(bottom: 5),
//                                           child: AlignWidget(
//                                             alignment: Alignment.centerLeft,
//                                             child: TextWiget(
//                                               title:
//                                                   '${_controller.wishList[index].productName}',
//                                               style: Themes
//                                                   .light.textTheme.bodyMedium!
//                                                   .copyWith(
//                                                 color: COLOR.grey,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             TextWiget(
//                                               title:
//                                                   '₹${_controller.wishList[index].packInfo![index].productdetailMrp} ',
//                                               style: Themes
//                                                   .dark.textTheme.displayMedium,
//                                             ),
//                                             TextWiget(
//                                               title:
//                                                   '${_controller.wishList[index].packInfo![index].productdetailSrp}',
//                                               style: Themes
//                                                   .light.textTheme.bodyMedium!
//                                                   .copyWith(
//                                                 color: COLOR.grey,
//                                                 decoration:
//                                                     TextDecoration.lineThrough,
//                                               ),
//                                             ),
//                                             TextWiget(
//                                               title: ' 9% off',
//                                               style: Themes
//                                                   .dark.textTheme.displayLarge!
//                                                   .copyWith(
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
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 5, vertical: 2),
//                                   decoration: BoxDecoration(
//                                     color: COLOR.green50,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: TextWiget(
//                                     title:
//                                         '₹${_controller.wishList[index].packInfo![index].productdetailSrp} with 1 Special Offer',
//                                     style: Themes.light.textTheme.displayMedium!
//                                         .copyWith(
//                                             color: COLOR.green,
//                                             fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 5),
//                                 child: AlignWidget(
//                                   alignment: Alignment.centerLeft,
//                                   child: SizedBox(
//                                     height: 15,
//                                     child: Row(
//                                       children: [
//                                         TextWiget(
//                                             title: '₹5 Off',
//                                             style: Themes
//                                                 .light.textTheme.displayMedium),
//                                         VerticalDivider(
//                                           thickness: 0.5,
//                                           width: 6,
//                                           color: COLOR.black,
//                                         ),
//                                         TextWiget(
//                                           title: '1st Order Discount',
//                                           style: Themes
//                                               .light.textTheme.displayMedium,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               AlignWidget(
//                                 alignment: Alignment.centerLeft,
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(
//                                       vertical: 5, horizontal: 10),
//                                   decoration: BoxDecoration(
//                                     color: COLOR.greyLight.withOpacity(0.5),
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: TextWiget(
//                                     title: 'Free Delivery',
//                                     style: Themes
//                                         .light.textTheme.headlineMedium!
//                                         .copyWith(color: COLOR.black),
//                                   ),
//                                 ),
//                               ),
//                               // Padding(
//                               //   padding: const EdgeInsets.only(top: 4),
//                               //   child: AlignWidget(
//                               //     alignment: Alignment.centerLeft,
//                               //     child: Row(
//                               //       children: [
//                               //         Container(
//                               //           padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
//                               //           decoration: BoxDecoration(
//                               //             color: COLOR.green,
//                               //             borderRadius: BorderRadius.circular(20),
//                               //           ),
//                               //           child: Row(
//                               //             children: [
//                               //               TextWiget(
//                               //                 title: '${products.rate}',
//                               //                 style: Themes.light.textTheme.displaySmall!.copyWith(
//                               //                   fontWeight: FontWeight.w500,
//                               //                   color: COLOR.background,
//                               //                 ),
//                               //               ),
//                               //               Icon(Icons.star, size: 13, color: COLOR.background)
//                               //             ],
//                               //           ),
//                               //         ),
//                               //         Padding(
//                               //           padding: const EdgeInsets.only(left: 4),
//                               //           child: TextWiget(
//                               //             title: '(28,717)',
//                               //             style: Themes.light.textTheme.bodyMedium!.copyWith(color: COLOR.grey),
//                               //           ),
//                               //         ),
//                               //       ],
//                               //     ),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               },
//               childCount: _controller.wishList.length,
//             ),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: Get.height > 800 ? 1.27 / 2 : 1 / 2,
//               crossAxisSpacing: 2,
//               mainAxisSpacing: 2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// mixin products {}
