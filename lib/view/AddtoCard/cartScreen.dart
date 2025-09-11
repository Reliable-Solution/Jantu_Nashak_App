import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keep_app/controller/addressController.dart';
import 'package:keep_app/models/cartDetailModel.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/app_constant.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../controller/cartController.dart';
import '../../controller/homeController.dart';
import '../../utils/string_res.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/buttonWidget.dart';
import '../../widget/cartWidget.dart';
import '../../widget/productDetailView.dart';
import '../../widget/textButtonWidget.dart';
import '../../widget/textWidget.dart';
import '../checkout/addressScreen.dart';
import '../dashboard/dashboardScreen.dart';

class PriceDetailsWidget extends StatelessWidget {
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
                Text(
                    "${StringRes.cartTitle} (${cartController.cartList.length} Items)",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                    "₹${cartController.cartTotal.value?.totalInteger.toString() ?? 0}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              _priceRow(StringRes.subTotal,
                  (cartController.cartTotal.value?.total ?? 0).toString().obs,
                  isDiscount: false),
              _priceRow(StringRes.save,
                  (cartController.cartTotal.value?.save ?? 0).toString().obs,
                  isDiscount: true),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringRes.orderTotal,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                      "₹${cartController.cartTotal.value?.totalInteger.toString() ?? 0}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                ],
              ),
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

class CartScreen extends StatefulWidget {
  Function? removeCart;

//
  CartScreen({this.removeCart, super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController =
      Get.put(CartController()); // ✅ Add this line
  final AddressController addressController =
      Get.put(AddressController()); // ✅ Add this line

  // final CartController cartController = Get.find();

  final HomeController homeController = Get.find<HomeController>();

  // final TextEditingController redeemPointsController = TextEditingController();

  // HomeController homeController = Get.find();

  bool isUpdateLoading = false;

  bool isCartRemoveLoading = false;
  int Qty = 0;
  bool isInitialLoading = true; // ✅ New flag for initial loader

  double? productQty;

  void add(int index) {
    setState(() {
      Qty++;
    });
    cartController.updateCartQty(
        cartController.cartList[index].cartId!, Qty.toString());
  }

  void remove() {
    if (Qty != 0) {
      setState(() {
        Qty--;
      });
      cartController.updateCartQty(
          cartController.cartList[0].cartId!, Qty.toString());
    }
  }

  @override
  void initState() {
    setState(() {
      // Simulate a delay for loading cart data
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          cartController.redeemPointsController.clear();
          isInitialLoading = false; // Stop showing loader after delay
          if (cartController.cartList.isNotEmpty &&
              cartController.cartList[0].packInfo != null &&
              cartController.cartList[0].packInfo!.isNotEmpty) {
            productQty = double.parse(
                "${cartController.cartList[0].packInfo![0].productdetailQty}");
            Qty = int.parse("${cartController.cartList[0].cartQuantity}");
          } else {
            productQty = 0;
            Qty = 1;
          }
          // cartController.redeemPointsController.clear();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "CartScreen name: ${homeController.customerModel!.value?.customerName}");

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyCustomAppBar(
          actionPadding: 10,
          height: 100,
          appbarPadding: 0,
          elevation: 1,
          title: TextWiget(
            title: StringRes.cart,
            style: Themes.light.textTheme.headlineLarge,
          ),
        ),
        body: isInitialLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: COLOR.appBaseColor,
                ),
              )
            : Obx(
                () {
                  final availablePoints = int.tryParse(
                        homeController.customerModel?.value?.points ?? "0",
                      ) ??
                      0;
                  return cartController.cartList.isEmpty
                      ? Center(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
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
                                    Get.to(() => DashboardScreen(pageIndex: 0));
                                  }),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            // Checkout progress indicator
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.shade300, width: 1),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildProgressStep(
                                      1, StringRes.cart, true, true),
                                  _buildProgressLine(false),
                                  _buildProgressStep(
                                      2, StringRes.address, false, false),
                                  _buildProgressLine(false),
                                  _buildProgressStep(
                                      3, StringRes.payment, false, false),
                                  _buildProgressLine(false),
                                  _buildProgressStep(
                                      4, StringRes.summary, false, false),
                                ],
                              ),
                            ),

                            // Cart items list
                            Expanded(
                              child: Obx(
                                () => cartController.cartList.isEmpty
                                    ? Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 250,
                                            child: Image.asset(Images.cart),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextWiget(
                                              title: StringRes.emptyCartMessage,
                                              style: Themes
                                                  .light.textTheme.bodyLarge!
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          TextButtonWidget(
                                              text: StringRes.viewProducts,
                                              onPressed: () {
                                                Get.to(() => DashboardScreen(
                                                    pageIndex: 0));
                                              }),
                                        ],
                                      )
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.65,
                                                  child: TextField(
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      // 👇 Custom formatter to block > availablePoints
                                                      TextInputFormatter
                                                          .withFunction(
                                                              (oldValue,
                                                                  newValue) {
                                                        final entered =
                                                            int.tryParse(newValue
                                                                    .text) ??
                                                                0;
                                                        if (entered <=
                                                            availablePoints) {
                                                          return newValue;
                                                        }
                                                        return oldValue; // reject new value
                                                      }),
                                                    ],
                                                    controller: cartController
                                                        .redeemPointsController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          StringRes.enterYourPoint,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 16,
                                                              vertical: 12),
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (cartController
                                                        .redeemPointsController
                                                        .text
                                                        .isEmpty) {
                                                      cartController
                                                          .redeemPointsController
                                                          .text = "0";
                                                      cartController
                                                          .getCartTotal(
                                                              homeController.customerModel!.value
                                                                  ?.customerId);
                                                    }
                                                    final entered = int.tryParse(
                                                            cartController
                                                                .redeemPointsController
                                                                .text) ??
                                                        0;
                                                    if (
                                                    // entered <= 0 ||
                                                        entered > availablePoints) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Enter valid points (Max: $availablePoints)');
                                                      cartController
                                                          .redeemPointsController
                                                          .text = "0";
                                                      // cartController.getCartTotal(homeController.m1?.customerId);
                                                      return;
                                                    }
                                                    cartController.getCartTotal(
                                                        homeController
                                                            .customerModel!.value.customerId);
                                                    // if (cartController.isCartCheck.value == false) {
                                                    //   Fluttertoast.showToast(
                                                    //       msg: 'Applied $entered points!');
                                                    // }
                                                    // String points =
                                                    //     redeemPointsController
                                                    //         .text;
                                                    // if (points.isNotEmpty) {
                                                    //   Fluttertoast.showToast(
                                                    //       msg:
                                                    //           'Applied $points points!');
                                                    // }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        COLOR.appBaseColor,
                                                  ),
                                                  child:  Text(
                                                    StringRes.apply,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: cartController
                                                  .cartList.length,
                                              itemBuilder: (context, index) {
                                                CartDetailModel item =
                                                    cartController
                                                        .cartList[index];
                                                return InkWell(
                                                  onTap: () {
                                                    // Get.to(() => ProductDetailScreen(products: cartController.cartList[index],isExpanded: true,));
                                                  },
                                                  child: MyCartComponent(
                                                    cartData: item,
                                                    onRemove: () {
                                                      cartController.cartList
                                                          .removeAt(index);
                                                      cartController.update();
                                                      if (widget.removeCart !=
                                                          null) {
                                                        widget.removeCart!();
                                                      }
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          // SizedBox(height: 10,),
                                          //  Spacer(),
                                          PriceDetailsWidget(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        );
                },
              ),
        bottomSheet: isInitialLoading && cartController.cartList.isEmpty
            ? SizedBox()
            : GetBuilder<CartController>(
                builder: (cartController) => cartController.cartList.isEmpty &&
                        cartController.isCartLoading.value == false
                    ? SizedBox()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              StringRes.clickingOnContinueWillNotDeductAnyMoney,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "₹${cartController.cartTotal.value?.totalInteger ?? 0}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Show price details
                                      },
                                      child: Text(
                                        StringRes.viewPriceDetails,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: COLOR.appBaseColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GetBuilder<CartController>(
                                  builder: (cartController) => // child:
                                      SizedBox(
                                    width: 150,
                                    child: ButtonWidgets(
                                      title: StringRes.continueString,
                                      style: Themes
                                          .light.textTheme.displayLarge!
                                          .copyWith(
                                        color: Colors.white,
                                      ),
                                      voidCallback: () async {
                                       await cartController.getCartTotal(
                                            homeController.customerModel!.value.customerId);
                                        addressController.getAllAddress();
                                        if (cartController.isCartCheck.value ==
                                            true) {
                                          Get.to(() => const AddressScreen());
                                        }
                                      },
                                      color: COLOR.appBaseColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                // ?:SizedBox()
                ),
      ),
    );
  }

  Widget _buildProgressStep(
      int step, String label, bool isActive, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive || isCompleted
                ? COLOR.appBaseColor
                : Colors.grey.shade300,
            border: Border.all(
              color: isActive || isCompleted
                  ? COLOR.appBaseColor
                  : Colors.grey.shade400,
              width: 1,
            ),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    step.toString(),
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive || isCompleted
                ? COLOR.appBaseColor
                : Colors.grey.shade600,
            fontWeight:
                isActive || isCompleted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Container(
      width: 40,
      height: 1,
      color: isActive ? COLOR.appBaseColor : Colors.grey.shade300,
    );
  }

  Widget _buildCartItem(CartDetailModel item, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    "${IMAGE_URL + item.productdetailImages!}" ??
                        'http://surti.idnmserver.com/resources/product_no_image.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/images/noInternet.jpg");
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // Product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productName ?? "Product Name",
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹${item.packInfo![0].productdetailSrp ?? 0}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        // item.isEasyReturn == 1
                        //     ? "All issue easy returns allowed"
                        //     :
                        StringRes.returnsPolicy,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "Size: 'Free Size'}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Qty: ${item.categoryId ?? 1}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // remove();

                              // cartController.removeFromCart(item.cartId);
                            },
                            child:
                                // Row(
                                //   children: [
                                Row(
                              children: [
                                Icon(Icons.close,
                                    size: 16, color: Colors.grey.shade700),
                                const SizedBox(width: 4),
                                Text(
                                  StringRes.removeItem,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),

                            // ],
                            // ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Row(
                              children: [
                                Qty == 1
                                    ? GestureDetector(
                                        onTap: () {
                                          cartController.removeFromCart(
                                            cartID: item.cartId!,
                                          );
                                          homeController.getDashboardData(
                                              homeController.customerModel!
                                                  .value.customerId);
                                          cartController.getCartTotal(
                                              cartController.customerModel!
                                                  .value.customerId!);
                                          cartController.update();
                                        },
                                        child: isCartRemoveLoading == true
                                            ? Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: COLOR.appBaseColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Colors.grey[300]!,
                                                        blurRadius: 2.0,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: COLOR
                                                            .appBaseColor)),
                                                child: Center(
                                                  child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    child: const Center(
                                                        child: SpinKitRipple(
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: COLOR.appBaseColor,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey[300]!,
                                                      blurRadius: 2.0,
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          COLOR.appBaseColor),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                      Icons
                                                          .delete_outline_sharp,
                                                      color: Colors.white,
                                                      size: 20),
                                                ),
                                              ),
                                      )
                                    : InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: COLOR.appBaseColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[300]!,
                                                  blurRadius: 2.0,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              border: Border.all(
                                                  width: 1,
                                                  color: COLOR.appBaseColor)),
                                          width: 30,
                                          height: 30,
                                          child: const Center(
                                            child: Icon(Icons.remove,
                                                color: Colors.white, size: 20),
                                          ),
                                        ),
                                        onTap: () {
                                          remove();
                                        },
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        "$Qty",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      isUpdateLoading == true
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1.5,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        COLOR.appBaseColor),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                Qty.toDouble() <
                                        double.parse("${item.productdetailQty}")
                                    ? InkWell(
                                        onTap: () {
                                          add(index);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: COLOR.appBaseColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[300]!,
                                                  blurRadius: 2.0,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              border: Border.all(
                                                  width: 1,
                                                  color: COLOR.appBaseColor)),
                                          width: 30,
                                          height: 30,
                                          child: const Center(
                                            child: Icon(Icons.add,
                                                color: Colors.white, size: 20),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Fluttertoast.showToast(
                                            msg:
                                                "${StringRes.only} ${productQty!.toStringAsFixed(0)} ${StringRes.availableStock}",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.SNACKBAR,
                                            timeInSecForIosWeb: 1,
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: COLOR.appBaseColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[300]!,
                                                  blurRadius: 2.0,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              border: Border.all(
                                                  width: 1,
                                                  color: COLOR.appBaseColor)),
                                          width: 30,
                                          height: 30,
                                          child: const Center(
                                            child: Icon(Icons.add,
                                                color: Colors.white, size: 20),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow icon
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sold by : ${item.productName ?? 'Seller'}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  StringRes.freeDelivery,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
