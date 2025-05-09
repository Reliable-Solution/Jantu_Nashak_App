// flutter
import 'package:flutter/material.dart';

// package
import 'package:get/get.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/shareProductsController.dart';
import 'package:keep_app/models/productModel.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../new.dart';
import '../../utils/string_res.dart';
import '../../widget/alignWidget.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/cartWidget.dart';
import '../../widget/iconButtonWidget.dart';
import '../../widget/productWidget.dart';
import '../../widget/textButtonWidget.dart';
import '../../widget/textWidget.dart';
import '../../widget/wishlistWidget.dart';
import '../dashboard/dashboardScreen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  ShareProductController shareProductController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    shareProductController.getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.greyLight,
      appBar: MyCustomAppBar(
        actionPadding: 10,
        height: 90,
        appbarPadding: 0,
        elevation: 1,
        title: TextWiget(
          title: StringRes.title,
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
      ),
      // backgroundColor: COLOR.greyLight,
      body: Container(
          color: COLOR.background,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder<ShareProductController>(builder: (controller) {
            if (controller.isWishLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.wishList.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 250,
                    child: Image.asset(Images.wishlist),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWiget(
                      title: StringRes.emptyMessage,
                      style: Themes.light.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButtonWidget(
                      text: StringRes.viewProducts,
                      onPressed: () {
                        Get.to(() => DashboardScreen(pageIndex: 0));
                      }),
                ],
              );
            } else {
              return SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.9, // Ensuring proper scroll
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1/1.4,
                        // childAspectRatio: Get.width >= 480 ? 1.15 / 2 : 1 / 2.1,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: controller.wishList.length,
                      itemBuilder: (context, index) {
                        ProductModel productModel = ProductModel(
                          productId: controller.wishList[index].productId,
                          brandId: controller.wishList[index].brandId,
                          packInfo: controller.wishList[index].packInfo!,
                          productName: controller.wishList[index].productName,
                          categoryId: controller.wishList[index].categoryId,
                          isFav: controller.wishList[index].isFav,
                          productDescription:
                          controller.wishList[index].productDescription,
                          productCDT: controller.wishList[index].productCDT,
                          productStatus:
                          controller.wishList[index].productStatus,
                        );
                        return ProductComponent(products: productModel);
                      }));
            }
          })),
    );
  }
}
