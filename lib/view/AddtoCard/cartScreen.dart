// flutter
import 'package:flutter/material.dart';

// package
import 'package:get/get.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/view/checkout/checkoutScreen.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../utils/string_res.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/buttonWidget.dart';
import '../../widget/cartWidget.dart';
import '../../widget/category_detail_shimmer.dart';
import '../../widget/textButtonWidget.dart';
import '../../widget/textWidget.dart';
import '../dashboard/dashboardScreen.dart';

class CartScreen extends StatelessWidget {
  Function? removeCart;

  CartScreen({this.removeCart, super.key});

  CartController cartController = Get.find();
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: MyCustomAppBar(
          actionPadding: 10,
          height: 90,
          appbarPadding: 0,
          elevation: 1,
          title: TextWiget(
            title: StringRes.cartTitle,
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
        backgroundColor: COLOR.background.withOpacity(0.96),
        body: GetBuilder<CartController>(
          builder: (cartController) => RefreshIndicator(
              onRefresh: () {
                // cartController.cartList.clear();
                return cartController.getCartDetails(
                    cartController.customerModel!.value.customerId!);
              },
              child:
                  // cartController.cartList.isEmpty?const CategoryDetailShimmer():
                  Container(
                      // color: COLOR.background.withOpacity(0.0),
                      width: MediaQuery.of(context).size.width,
                      child: (cartController.isCartLoading)
                           // const CategoryDetailShimmer()
                           ? Center(child: CircularProgressIndicator())
                          : (cartController.cartList.isEmpty)
                              ? Column(
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
                                        title: StringRes.emptyCartMessage,
                                        style: Themes.light.textTheme.bodyLarge!
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    TextButtonWidget(
                                        text: StringRes.viewProducts,
                                        onPressed: () {
                                          Get.to(() =>
                                              DashboardScreen(pageIndex: 0));
                                        }),
                                  ],
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              cartController.cartList.length,
                                          itemBuilder: (context, index) {
                                            return MyCartComponent(
                                              cartData: cartController
                                                  .cartList[index],
                                              onRemove: () {
                                                cartController.cartList
                                                    .removeAt(index);
                                                // homeController.getDashboardData(homeController.customerModel!.value.customerId);
                                                // cartController.getCartTotal(cartController.customerModel!.value.customerId!);
                                                // homeController.getDashboardData(homeController.customerModel!.value.customerId);
                                                // _controller.update();
                                                cartController.update();
                                                if (removeCart != null) {
                                                  removeCart!();
                                                }
                                              },
                                            );
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      PriceDetailsWidget(),
                                      SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ))),
        ),
        bottomSheet: GetBuilder<CartController>(
          builder: (cartController) {
            return cartController.cartList.isNotEmpty
                ? Container(
                    color: Color(0xffffedfe).withOpacity(0.2),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              StringRes.cartTotal,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: COLOR.appBaseColor),
                            ),
                            Text(
                              "Total Rs. ${cartController.cartTotal.value?.totalInteger.toString() ?? 0}",
                              // "Total : ${cartController.cartList.length}", // ✅ Observable value inside Obx
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        ButtonWidgets(
                            style: Themes.light.textTheme.displayLarge!
                                .copyWith(color: Colors.white),
                            // text: StringRes.addtoCart,
                            // onPressed: () {
                            //   if (widget.products!.packInfo![0].isCart ??
                            //       false) {
                            //     Fluttertoast.showToast(
                            //         msg: StringRes.alreadyInCart);
                            //   } else {
                            //     controller.addToCart(widget.products!);
                            //     widget.products!.packInfo![0].isCart = true;
                            //     Get.find<CartController>().getCartDetails(
                            //       Get.find<CartController>()
                            //           .customerModel!
                            //           .value
                            //           .customerId!,
                            //     );
                            //   }
                            title: "Continue",
                            voidCallback: () {
                              Get.to(Checkoutscreen());

                              // if (widget.products!.packInfo![0].isCart ??
                              //     false) {
                              //   Fluttertoast.showToast(
                              //       msg: StringRes.alreadyInCart);
                              // } else {
                              //   controller.addToCart(widget.products!);
                              //   widget.products!.packInfo![0].isCart = true;
                              //   Get.find<CartController>().getCartDetails(
                              //     Get.find<CartController>()
                              //         .customerModel!
                              //         .value
                              //         .customerId!,
                              //   );
                              // }
                            },
                            color: COLOR.appBaseColor
                            // widget.products!.packInfo![0].isCart ?? false
                            //     ? COLOR.grey
                            //     : COLOR.appBaseColor,
                            ),

                        // ElevatedButton(
                        //   onPressed: () {
                        //     Get.to(Checkoutscreen());
                        //   },
                        //   child: Text("Continue"),
                        // ),
                      ],
                    ),
                  )
                : SizedBox();
          },
        ),

        // bottomSheet: Obx(
        //   () {
        //     return cartController.cartList.isNotEmpty
        //         ? Container(
        //             color: Colors.grey[200],
        //             width: MediaQuery.of(context).size.width,
        //             padding: EdgeInsets.all(16),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(StringRes.cartTotal),
        //                   ],
        //                 ),
        //                 ElevatedButton(
        //                     onPressed: () {
        //                       Get.to(Checkoutscreen());
        //                     },
        //                     child: Text("Continue"))
        //               ],
        //             ),
        //           )
        //         : SizedBox();
        //   },
        // ),
      ),
    );
  }
}

//
// class PriceController extends GetxController {
//   var totalPrice = 923.0.obs;
//   var totalDiscount = 13.0.obs;
//
//   double get orderTotal => totalPrice.value - totalDiscount.value;
//
//   void updatePrice(double price) {
//     totalPrice.value = price;
//   }
//
//   void updateDiscount(double discount) {
//     totalDiscount.value = discount;
//   }
// }

class PriceDetailsWidget extends StatelessWidget {
  // final PriceController controller = Get.put(PriceController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.2),
          borderRadius: BorderRadius.circular(12)),
      child: Transform.scale(
        scale: 1.028,
        child: Card(
          elevation: 1,
          color: COLOR.background,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent)),
            collapsedShape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent)),
            backgroundColor: Colors.transparent,
            collapsedBackgroundColor: Colors.transparent,
            childrenPadding: EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 12,
            ),
            tilePadding: EdgeInsets.symmetric(horizontal: 12),
            visualDensity: VisualDensity(horizontal: 0, vertical: 0),
            dense: true,
            minTileHeight: 20,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price Details (${cartController.cartList.length} Items)",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                    "₹${cartController.cartTotal.value?.totalInteger.toString() ?? 0}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Price Details (${cartController.cartList.length} Items)",
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Divider(),
              _priceRow("Sub Total",
                  (cartController.cartTotal.value?.total ?? 0).toString().obs,
                  isDiscount: false),
              _priceRow("Save",
                  (cartController.cartTotal.value?.save ?? 0).toString().obs,

                  // cartController.cartTotal.value!.save!.toString().obs ?? "0".obs,
                  isDiscount: true),
              Divider(),
              // Obx(() =>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Total",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                      "₹${cartController.cartTotal.value?.totalInteger.toString() ?? 0}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                ],
              ),
              // ),
              // SizedBox(height: 12),
              // Container(
              //   padding: EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: Colors.green.shade100,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(Icons.check_circle, color: Colors.green),
              //       SizedBox(width: 8),
              //       // Obx(() =>
              //           Text("${cartController.cartTotal.value!.description ?? ""}",
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 2,
              //           style: TextStyle(color: Colors.green,overflow: TextOverflow.ellipsis,
              //           ))
              // // ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String title, RxString value, {bool isDiscount = false}) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: Colors.grey[700])),
            Text(
              "${isDiscount ? ' ' : ' '} ${value.value}",
              style: TextStyle(color: isDiscount ? Colors.green : Colors.black),
            ),
          ],
        ));
  }
}

