// flutter
import 'package:flutter/material.dart';
// package
import 'package:get/get.dart';
import 'package:keep_app/controller/cartController.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/cartWidget.dart';
import '../../widget/textButtonWidget.dart';
import '../../widget/textWidget.dart';
import '../dashboard/dashboardScreen.dart';

class CartScreen extends StatelessWidget {
  Function? removeCart;
  CartScreen({this.removeCart,super.key});

  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        height: 90,
        appbarPadding: 0,
        elevation: 1,
        title: TextWiget(
          title: 'CART',
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
      backgroundColor: COLOR.greyLight,

      body: Container(
          color: COLOR.background,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder<CartController>(builder: (controller) {
            if (controller.isCartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.cartList.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 250,
                    child: Image.asset(Images.cart),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWiget(
                      title: 'Your cart is empty',
                      style: Themes.light.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButtonWidget(
                      text: 'View Products',
                      onPressed: () {
                        Get.to(() => DashboardScreen(pageIndex: 0));
                      }),
                ],
              );
            } else {
              return ListView.builder(
                  itemCount: controller.cartList.length,
                  itemBuilder: (context, index) {
                    return MyCartComponent(
                      cartData: controller.cartList[index],
                      onRemove: () {
                          controller.cartList.removeAt(index);
                          controller.update();
                          if(removeCart != null){
                            removeCart!();
                          }
                      },
                    );
                  });
            }
          })),
      bottomSheet: Container(
        color: Colors.grey[200],
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Cart Total"),
            Obx(()=>Text(
              cartController.cartTotal!.value.totalInteger.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),),
          ],
        ),
      ),
    );
  }
}


