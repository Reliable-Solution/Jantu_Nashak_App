import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/controller/addressController.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/checkoutController.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/Theme/nativeTheme.dart';
import 'package:keep_app/constant/colorConst.dart';
import 'package:keep_app/models/cartDetailModel.dart';
import 'package:keep_app/utils/string_res.dart';
import 'package:keep_app/view/checkout/paymentScreen.dart';
import 'package:keep_app/view/dashboard/dashboardScreen.dart';
import 'package:keep_app/widget/buttonWidget.dart';
import 'package:keep_app/widget/appBarWidget.dart';
import 'package:keep_app/widget/textWidget.dart';
import 'package:keep_app/view/home/home_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constant/app_constant.dart';
import '../AddtoCard/cartScreen.dart';
import 'addressScreen.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final AddressController addressController = Get.find();
  final CartController cartController = Get.find();
  final CheckoutController checkoutController = Get.find();
  final HomeController homeController = Get.find();

  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay!.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    checkoutController.placeOrderCheckout(
      customerId: "${addressController.customerModel!.value.customerId}",
      addressId: "${addressController.selectedAddressId}",
      orderPaymentMethod: "${checkoutController.selectedPaymentMethod}",
      orderTransactionNo: response.paymentId ?? "",
    );
    cartController.cartCount.value = 0;
    cartController.cartList.clear();
    cartController.update();
    Fluttertoast.showToast(msg: "Payment Successfully ", timeInSecForIosWeb: 4);
    Get.offAll(() => DashboardScreen(pageIndex: 0));
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
    int finalAmount = amount * 100;
    var options = {
      'key': 'rzp_test_Ws2848j1kpbpJH',
      'amount': finalAmount,
      'name': '${addressController.customerModel!.value.customerName}',
      'description': '-Shopping',
      'prefill': {'contact': '1234567890', 'email': 'demo@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: MyCustomAppBar(
          actionPadding: 10,
          height: 100,
          appbarPadding: 0,
          elevation: 1,
          title: TextWiget(
            title: "SUMMARY",
            style: Themes.light.textTheme.displayLarge,
          ),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Checkout progress indicator
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProgressStep(1, "Cart", false, true),
                    _buildProgressLine(true),
                    _buildProgressStep(2, "Address", false, true),
                    _buildProgressLine(true),
                    _buildProgressStep(3, "Payment", false, true),
                    _buildProgressLine(true),
                    _buildProgressStep(4, "Summary", true, false),
                  ],
                ),
              ),

              // Estimated delivery
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Estimated Delivery by Wednesday, 26th Jul",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Product summary
              Container(
                color: Colors.white,
                child: Obx(
                  () => cartController.cartList.isEmpty
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("No items in cart"),
                        ))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartController.cartList.length,
                          itemBuilder: (context, index) {
                            CartDetailModel item =
                                cartController.cartList[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Product image
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Image.network(
                                          // item.productdetailImages
                                          "${IMAGE_URL + item.productdetailImages!}" ??
                                              'http://surti.idnmserver.com/resources/product_no_image.png',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                "assets/images/noInternet.jpg");
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),

                                      // Product details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.productName ??
                                                  "Product Name",
                                              style:
                                                  const TextStyle(fontSize: 14),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "₹${item.productdetailSrp ?? 0}",
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
                                              "Only wrong/defect item returns allowed",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Text(
                                                  "Size: Free Size'}",
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
                                          ],
                                        ),
                                      ),

                                      // Arrow icon

                                      InkWell(
                                        onTap: () {
                                          Get.off(() => CartScreen());
                                        },
                                        child: Icon(
                                          Icons.chevron_right,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sold by : ${item.productName ?? 'Seller'}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      const Text(
                                        "Free Delivery",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        ),
                ),
              ),

              const SizedBox(height: 8),

              // Delivery address
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Delivery Address",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            addressController.getAllAddress();
                            Get.to(() => const AddressScreen());
                          },
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Obx(() {
                      var selectedAddress = addressController.allAddressList
                          .firstWhereOrNull((address) =>
                              address.addressId.toString() ==
                              addressController.selectedAddressId.value);

                      return selectedAddress == null
                          ? const Text("No address selected")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedAddress.addressFullName ?? "Name",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${selectedAddress.addressColony ?? ''}, ${selectedAddress.cityName ?? ''}, ${selectedAddress.stateName ?? ''}, ${selectedAddress.addressPincode ?? ''}\n"
                                  "Ney york ${selectedAddress.addressPincode ?? ''}\n"
                                  "${selectedAddress.addressMobileNo ?? ''}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "EDIT",
                                  style: TextStyle(
                                    color: COLOR.appBaseColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Payment mode
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Payment Mode",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => const PaymentScreen());
                          },
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Text(
                          checkoutController.selectedPaymentMethod.value ==
                                  "cod"
                              ? "Cash on Delivery"
                              : "Online Payment",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 100), // Space for bottom button
            ],
          ),
        ),
        bottomSheet: Container(
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
          child: ButtonWidgets(
            title: "Place Order",
            style: Themes.light.textTheme.displayLarge!.copyWith(
              color: Colors.white,
            ),
            voidCallback: () {
              if (checkoutController.selectedPaymentMethod.value == "online") {
                openPaymentGateway(
                    cartController.cartTotal.value!.totalInteger);
              } else if (checkoutController.selectedPaymentMethod.value ==
                  "cod") {
                checkoutController.placeOrderCheckout(
                  customerId:
                      "${addressController.customerModel!.value.customerId}",
                  addressId: "${addressController.selectedAddressId}",
                  orderPaymentMethod:
                      "${checkoutController.selectedPaymentMethod}",
                  orderTransactionNo: "",
                );
                cartController.cartCount.value = 0;
                cartController.cartList.clear();
              cartController.update();
                homeController.getDashboardData(
                    addressController.customerModel!.value.customerId);
                // Get.offAll(() =>  DashboardScreen(pageIndex: 0));
              }
            },
            color: COLOR.appBaseColor,
          ),
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
            color: isActive
                ? Colors.blue
                : (isCompleted ? Colors.blue : Colors.grey.shade300),
            border: Border.all(
              color:
                  isActive || isCompleted ? Colors.blue : Colors.grey.shade400,
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
            color: isActive || isCompleted ? Colors.blue : Colors.grey.shade600,
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
      color: isActive ? Colors.blue : Colors.grey.shade300,
    );
  }
}
