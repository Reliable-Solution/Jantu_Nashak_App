import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/checkoutController.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/utils/sharedPrefs.dart';
import 'package:keep_app/view/checkout/priceDetailsScreen.dart';
import 'package:keep_app/view/home/home_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../controller/addressController.dart';
import '../../models/customerModel.dart';
import '../../utils/string_res.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/buttonWidget.dart';
import '../../widget/selectAddress.dart';
import '../../widget/textWidget.dart';
import '../AddtoCard/cartScreen.dart';

class Checkoutscreen extends StatefulWidget {
  const Checkoutscreen({super.key});

  @override
  State<Checkoutscreen> createState() => _CheckoutscreenState();
}

class _CheckoutscreenState extends State<Checkoutscreen> {
  final AddressController controller = Get.find();
  final CartController cartController = Get.find();
  final CheckoutController checkoutController = Get.find();
  final HomeController homeController = Get.find();

  String selectedPayment = 'Razorpay';

  Razorpay? _razorpay;

  @override
  void initState() {
    //getAddressData();
    // _getAddress();
    // showShowCase();
    // _getCartData();
    // getLocalData();
    //beforPlaceOrder();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    checkoutController.getPaymentMethod();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // _placeOrder(transactionId: response.paymentId!);'
    SharedHelper helper = SharedHelper();
    CustomerModel? customerModel = await helper.getCustomer();
    if (customerModel != null) {
      homeController.customerModel!.value = customerModel;
    }
    checkoutController.placeOrderCheckout(
      customerId: "${controller.customerModel!.value.customerId}",
      addressId: "${controller.selectedAddressId}",
      orderPaymentMethod: "${checkoutController.selectedPaymentMethod}",
      orderTransactionNo: "",
    );
    cartController.cartCount.value = 0;
    cartController.cartList.clear();
    cartController.update();
    Fluttertoast.showToast(msg: "Payment Successfully ", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment process cancelled by user", timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName!}", timeInSecForIosWeb: 4);
  }

  void openPaymentGateway(var amount) async {
    print("---------------------*******-------${amount}");
    int finalAmount = amount * 100;
    var options = {
      'key': 'rzp_test_Ws2848j1kpbpJH',
      'amount': finalAmount,
      'name': '${controller.customerModel!.value.customerName}',
      'description': '-Shopping',
      'prefill': {'contact': '1234567890', 'email': 'demo@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      // } catch (e) {
      debugPrint(e as String?);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: MyCustomAppBar(
          actionPadding: 10,
          height: 100,
          appbarPadding: 0,
          elevation: 1,
          title: TextWiget(
            title: StringRes.checkout,
            style: Themes.light.textTheme.headlineLarge,
          ),
        ),
        backgroundColor: COLOR.background.withOpacity(0.96),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 05),

              Obx(() {
                var selectedAddress = controller.allAddressList
                    .firstWhereOrNull((address) =>
                        address.addressId.toString() ==
                        controller.selectedAddressId.value);
                return selectedAddress == null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(StringRes.noAddressSelected)),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            // margin: EdgeInsets.all(16.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${selectedAddress.addressFullName}",
                                  style: Themes.light.textTheme.displayMedium!
                                      .copyWith(fontSize: 20),
                                ),
                                Text(
                                  // "${selectedAddress.addressFullName}\n"
                                  "${selectedAddress.addressColony}\n${selectedAddress.cityName},${selectedAddress.stateName}, ${selectedAddress.addressPincode}\n"
                                  "${StringRes.landmark} : ${selectedAddress.addressLandmark}\n+91 ${selectedAddress.addressMobileNo}",
                                  style: Themes.light.textTheme.bodyMedium!
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
              }),
              SizedBox(height: 05),
              Center(
                child: ButtonWidgets(
                    style: Themes.light.textTheme.displayLarge!
                        .copyWith(color: Colors.white),
                    title: StringRes.selectAddress,
                    voidCallback: () {
                      showAddressBottomSheet(context);
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
              ),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () => showAddressBottomSheet(context),
              //     child: Text("Select Address"),
              //   ),
              // ),
              SizedBox(height: 08),
              // Divider(),

              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringRes.selectPaymentMethod,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 12),



                    SizedBox(height: 12),

                    // Pay Online
                    Obx(() => buildPaymentOption(
                          image: "payment-online.png",

                          title: StringRes.payOnline,
                          price:
                              "₹${cartController.cartTotal.value?.totalInteger.toString() ?? 0}",
                          discount:
                              "Save ${cartController.cartTotal.value?.save.toString() ?? 0}",
                          // extraText: "Extra discount with bank offers",
                          icon: Icons.credit_card,
                          method: "online",
                          controller: controller,
                        )),
                    Obx(() => checkoutController.isOnlineExpanded.value
                        ? buildOnlinePaymentOptions()
                        : SizedBox()),

                    SizedBox(height: 30),
                  ],
                ),
              ),

              // SizedBox(height: 05),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Get.snackbar("Payment Method",
              //           "Selected: ${controller.selectedPaymentMethod.value.toUpperCase()}");
              //     },
              //     child: Text("Proceed to Pay"),
              //   ),
              // ),
              // Divider(),
              // PriceDetailsWidget(),
              // Divider(),
              SizedBox(height: 75),
            ],
          ),
        ),
        bottomSheet: Obx(() {
          bool isAddressSelected =
              controller.selectedAddressId.value.isNotEmpty;
          bool isPaymentSelected =
              checkoutController.selectedPaymentMethod.value.isNotEmpty;
          bool isButtonEnabled = isAddressSelected && isPaymentSelected;
          return Container(
            decoration: BoxDecoration(
              color: Color(0xffffedfe).withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffffedfe).withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: -05,
                )
              ],
            ),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringRes.cartTotal,
                      style: Themes.dark.textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: COLOR.appBaseColor),
                    ),
                    Obx(
                      () => Text(
                        "Rs.${cartController.cartTotal.value?.totalInteger.toString() ?? 0}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                GetBuilder<CheckoutController>(
                    builder: (checkoutController) => ButtonWidgets(
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
                        title: StringRes.continueString,
                        voidCallback: isButtonEnabled
                            ? () {
                                print(
                                    "check out controller ${checkoutController.selectedPaymentMethod.value}");
                                if (checkoutController
                                        .selectedPaymentMethod.value ==
                                    "online") {
                                  openPaymentGateway(cartController
                                      .cartTotal.value!.totalInteger);
                                } else if (checkoutController
                                        .selectedPaymentMethod.value ==
                                    "cod") {
                                  print(
                                      "======================= Payment method ${checkoutController.selectedPaymentMethod}");
                                  checkoutController.placeOrderCheckout(
                                    customerId:
                                        "${controller.customerModel!.value.customerId}",
                                    addressId:
                                        "${controller.selectedAddressId}",
                                    orderPaymentMethod:
                                        "${checkoutController.selectedPaymentMethod}",
                                    orderTransactionNo: "",
                                  );
                                  cartController.cartCount.value =
                                      cartController.cartList.length;
                                  // cartController.cartList.clear();
                                  print(
                                      "Cart Count ${cartController.cartCount.value}");
                                  homeController.getDashboardData(controller
                                      .customerModel!.value.customerId);
                                  cartController.cartList.clear();
                                  cartController.update();
                                } else if (checkoutController
                                        .selectedPaymentMethod.value ==
                                    "") {
                                  Fluttertoast.showToast(
                                      msg: StringRes.pleaseSelectAddressMethod);
                                }
                              }
                            : () {
                                // checkoutController.selectedPaymentMethod.value == ""
                                //     ? Fluttertoast.showToast(
                                //     msg: "Please Select Payment Method")
                                //     : null;
                                controller.selectedAddressId.value.isEmpty
                                    ? Fluttertoast.showToast(
                                        msg:
                                            StringRes.pleaseSelectAddressMethod)
                                    : checkoutController
                                                .selectedPaymentMethod.value ==
                                            ""
                                        ? Fluttertoast.showToast(
                                            msg: StringRes
                                                .pleaseSelectPaymentMethod)
                                        : null;
                              },
                        //     () {
                        //   // if (widget.products!.packInfo![0].isCart ??
                        //   //     false) {
                        //   //   Fluttertoast.showToast(
                        //   //       msg: StringRes.alreadyInCart);
                        //   // } else {
                        //   //   controller.addToCart(widget.products!);
                        //   //   widget.products!.packInfo![0].isCart = true;
                        //   //   Get.find<CartController>().getCartDetails(
                        //   //     Get.find<CartController>()
                        //   //         .customerModel!
                        //   //         .value
                        //   //         .customerId!,
                        //   //   );
                        //   // }
                        // },
                        color: controller.selectedAddressId.value.isEmpty
                            ? Colors.grey
                            : checkoutController.selectedPaymentMethod.value ==
                                    ""
                                ? Colors.grey
                                : COLOR.appBaseColor
                        // widget.products!.packInfo![0].isCart ?? false
                        //     ? COLOR.grey
                        //     : COLOR.appBaseColor,
                        )
                    // ElevatedButton(
                    // onPressed:
                    // isButtonEnabled
                    //     ?
                    //     () {
                    //   if(checkoutController.selectedPaymentMethod.value == "online")
                    //   {
                    //     openPaymentGateway(cartController.cartTotal.value!.totalInteger);
                    //   }
                    //   else if(checkoutController.selectedPaymentMethod.value == "cod") {
                    //     print(
                    //         "======================= Payment method ${checkoutController
                    //             .selectedPaymentMethod}");
                    //     checkoutController.placeOrderCheckout(
                    //       customerId: "${controller.customerModel!.value
                    //           .customerId}",
                    //       addressId: "${controller.selectedAddressId}",
                    //       orderPaymentMethod: "${checkoutController
                    //           .selectedPaymentMethod}",
                    //       orderTransactionNo: "",
                    //     );
                    //      cartController.cartCount.value = cartController.cartList.length;
                    //     // cartController.cartList.clear();
                    //     print("Cart Count ${cartController.cartCount.value}");
                    //     homeController.getDashboardData(controller.customerModel!.value.customerId);
                    //      cartController.cartList.clear();
                    //     cartController.update();
                    //
                    //   }
                    //   // Get.to(HomeScreen());
                    // }
                    //     : null,
                    // child: Text("Continue")),
                    )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildOnlinePaymentOptions() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return buildPaymentOption2(
                  checkoutController.paymentMethodList[index].gatewayName!,
                  "Offers Available",
                  checkoutController.paymentMethodList[index].gatewayName!);
            },
          ),
        )
        // buildPaymentOption2("PhonePe", "Offers Available", 'PhonePe'),
        // buildPaymentOption2("Razorpay", "Offers Available", 'Razorpay'),
        // buildPaymentOption2("Cashfree", "Offers Available", 'Cashfree'),
        // buildExpandableTile("Pay by any UPI App", "Offers Available"),
        // buildExpandableTile("Wallet", "Offers Available"),
        // buildExpandableTile("Debit/Credit Cards", "Offers Available"),
        // buildExpandableTile("Net Banking", ""),
      ],
    );
  }

  Widget buildExpandableTile(String title, String subText) {
    return ExpansionTile(
      title: Row(
        children: [
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Spacer(),
          if (subText.isNotEmpty)
            Text(subText, style: TextStyle(color: Colors.green, fontSize: 12)),
        ],
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text("Details for $title"),
        ),
      ],
    );
  }

  Widget buildPaymentOption2(String title, String subText, String value) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() => selectedPayment = value);

            // String? newValue;
            // setState(() => selectedPayment = newValue!);
            // print("Payment");
          },
          leading: Radio<String>(
            value: value,
            groupValue: selectedPayment,
            onChanged: (String? newValue) {
              setState(() => selectedPayment = newValue!);
            },
          ),
          title: Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          subtitle: subText.isNotEmpty
              ? Text(subText, style: TextStyle(color: Colors.green))
              : null,
        ),
        Divider(),
      ],
    );
  }

  Widget buildPaymentOption({
    required String title,
    required String price,
    required String method,
    required IconData icon,
    required AddressController controller,
    required String image,
    String? discount,
    String? extraText,
  }) {
    bool isSelected = checkoutController.selectedPaymentMethod.value == method;

    return GestureDetector(
      onTap: () => checkoutController.selectPaymentMethod(method),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? Colors.purple : Colors.grey),
          color: isSelected ? Colors.purple.shade50 : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/${image}",
              width: 60,
              height: 80,
              errorBuilder: (context, exception, stackTrace) {
                return Image.asset("assets/images/noInternet.jpg",
                    height: 120, width: 100);
                // Image.network('http://surti.idnmserver.com/resources/product_no_image.png');
              },
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(price,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      if (discount != null) ...[
                        SizedBox(width: 8),
                        Text(
                          discount!,
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                      Spacer(),
                      Icon(icon, color: Colors.orange),
                      SizedBox(width: 8),
                      Icon(
                        isSelected
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: checkoutController.isSelected.value
                            ? Colors.purple
                            : Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  if (extraText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        extraText!,
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
