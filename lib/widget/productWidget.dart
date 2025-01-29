import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/models/productModel.dart';
import 'package:keep_app/widget/textWidget.dart';

import '../Theme/nativeTheme.dart';
import '../constant/app_constant.dart';
import '../constant/colorConst.dart';
import '../controller/homeController.dart';
import 'alignWidget.dart';
import 'iconButtonWidget.dart';

class ProductComponent extends StatelessWidget {
  const ProductComponent({
    super.key,
    @required this.products,
  });

  final ProductModel? products;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(() => ProductDetailScreen(products: products!));
      },
      child: Container(
        // height: (MediaQuery.of(context).size.height * 50) / 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: COLOR.background,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height * 25) / 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      NetworkImage('$IMAGE_URL${products!.subcategoryImage}'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: AlignWidget(
                  alignment: Alignment.topRight,
                  child: GetBuilder<HomeController>(
                    builder: (_controller) => CircleAvatar(
                      maxRadius: 15,
                      backgroundColor: COLOR.background.withOpacity(0.8),
                      child: IconButtonWidget(
                        voidCallback: () {
                          if (products!.isFav == false) {
                            products!.isFav = true;
                          } else {
                            products!.isFav = false;
                          }

                          _controller.update();
                        },
                        color:
                            products!.isFav == false ? COLOR.black : COLOR.pink,
                        icons: products!.isFav == false
                            ? Icons.favorite_border
                            : Icons.favorite,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 5),
                              alignment: Alignment.centerLeft,
                              child: TextWiget(
                                title: '${products!.productName}',
                                style:
                                    Themes.light.textTheme.bodyMedium!.copyWith(
                                  color: COLOR.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                TextWiget(
                                  title:
                                      '₹${products!.packInfo![0].productdetailSrp!} ',
                                  style: Themes.dark.textTheme.displayMedium,
                                ),
                                TextWiget(
                                  title:
                                      products!.packInfo![0].productdetailMrp!,
                                  style: Themes.light.textTheme.bodyMedium!
                                      .copyWith(
                                    color: COLOR.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                TextWiget(
                                  title: ' 9% off',
                                  style: Themes.dark.textTheme.displayLarge!
                                      .copyWith(
                                    color: COLOR.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 30,
                        child: IconButtonWidget(
                          voidCallback: () {},
                          icons: Icons.share_outlined,
                        ),
                      )
                    ],
                  ),
                  AlignWidget(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: COLOR.green50,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextWiget(
                        title:
                            '₹${products!.packInfo![0].productdetailSrp!} with 1 Special Offer',
                        style: Themes.light.textTheme.displayMedium!.copyWith(
                          color: COLOR.green,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: AlignWidget(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 15,
                        child: Row(
                          children: [
                            TextWiget(
                                title: '₹5 Off',
                                style: Themes.light.textTheme.displayMedium),
                            VerticalDivider(
                              thickness: 0.5,
                              width: 6,
                              color: COLOR.black,
                            ),
                            TextWiget(
                              title: '1st Order Discount',
                              style: Themes.light.textTheme.displayMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AlignWidget(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: COLOR.greyLight.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextWiget(
                        title: 'Free Delivery',
                        style: Themes.light.textTheme.headlineMedium!
                            .copyWith(color: COLOR.black),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5),
                  //   child: AlignWidget(
                  //     alignment: Alignment.centerLeft,
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           padding: EdgeInsets.symmetric(
                  //               vertical: 5, horizontal: 6),
                  //           decoration: BoxDecoration(
                  //             color: COLOR.green,
                  //             borderRadius: BorderRadius.circular(5),
                  //           ),
                  //           child: Row(
                  //             children: [
                  //               TextWiget(
                  //                 title: '${products!.categoryId}',
                  //                 style: Themes.light.textTheme.displaySmall!
                  //                     .copyWith(
                  //                   fontWeight: FontWeight.w500,
                  //                   color: COLOR.background,
                  //                 ),
                  //               ),
                  //               Icon(Icons.star,
                  //                   size: 13, color: COLOR.background)
                  //             ],
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(left: 4),
                  //           child: TextWiget(
                  //             title: '(28,717)',
                  //             style: Themes.light.textTheme.bodyMedium!
                  //                 .copyWith(color: COLOR.grey),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
