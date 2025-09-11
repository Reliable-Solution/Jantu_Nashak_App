import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/controller/addressController.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/checkoutController.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/Theme/nativeTheme.dart';
import 'package:keep_app/constant/colorConst.dart';
import 'package:keep_app/models/PaymenntModel.dart';
import 'package:keep_app/models/cartDetailModel.dart';
import 'package:keep_app/view/checkout/paymentScreen.dart';
import 'package:keep_app/view/dashboard/dashboardScreen.dart';
import 'package:keep_app/widget/buttonWidget.dart';
import 'package:keep_app/widget/appBarWidget.dart';
import 'package:keep_app/widget/textWidget.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constant/app_constant.dart';
import '../../utils/string_res.dart';
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
  String environmentValue = "SANDBOX";
  String appId = "com.keepapp.phonepe";
  String merchantId = "PGTESTPAYUAT86"; // Updated Merchant ID
  bool enableLogging = true;
  String saltKey = "96434309-7796-489d-8924-ab56988a6076"; // Updated Salt Key
  String saltIndex = "1";
  String callback = "https://webhook.site/ba843c01-f6a6-4076-8fba-24b5719b3f66";
  String apiEndPoint = "/pg/v1/pay";
  Object? result;
  String checksum = "";

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    initiatePhonePePayment();
  }

  @override
  void dispose() {
    _razorpay!.clear();
    super.dispose();
  }

  void initiatePhonePePayment() async {
    try {
      bool? val = await PhonePePaymentSdk.init(
        environmentValue,
        appId,
        merchantId,
        enableLogging,
      );
      setState(() {
        result = 'PhonePe SDK Initialized - $val';
        print(
            "PhonePe Init: $val, environment: $environmentValue, merchantId: $merchantId, appId: $appId");
      });
    } catch (error) {
      handlePhonePeError(error);
    }
  }

  void handlePhonePeError(error) {
    setState(() {
      result = error?.toString() ?? "Unknown PhonePe Error";
      print("PhonePe Error: ${error?.toString() ?? 'Unknown error'}");
      print(
          "StackTrace: ${error is Error ? error.stackTrace : 'No stack trace'}");
      Fluttertoast.showToast(
        msg: "PhonePe Error: ${error?.toString() ?? 'Unknown error'}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  String generateBase64Body(int amount) {
    Map<String, dynamic> payload = {
      "merchantId": merchantId,
      "merchantTransactionId": "MT${DateTime.now().millisecondsSinceEpoch}",
      "merchantUserId": "${addressController.customerModel!.value.customerId}",
      "amount": amount * 100, // Convert to paisa
      "callbackUrl": callback,
      "mobileNumber":
          "${addressController.customerModel!.value.customerPhoneNo ?? '9999999999'}",
      "paymentInstrument": {"type": "PAY_PAGE"},
      "deviceContext": {"deviceOS": "ANDROID"},
    };
    return base64Encode(utf8.encode(jsonEncode(payload)));
  }

  String generateChecksum(String base64Body) {
    String raw = base64Body + apiEndPoint + saltKey;
    String sha256Hash = sha256.convert(utf8.encode(raw)).toString();
    return "$sha256Hash###$saltIndex";
  }

  void startPhonePeTransaction(int amount) async {
    try {
      String base64Body = generateBase64Body(amount);
      String checksum = generateChecksum(base64Body);

      PhonePePaymentSdk.startTransaction(base64Body, callback, checksum, null)
          .then((response) {
        setState(() {
          if (response != null) {
            String status = response['status']?.toString() ?? 'UNKNOWN';
            String error = response['error']?.toString() ?? '';
            print("PhonePe Transaction Response: $response");
            if (status == 'SUCCESS') {
              result = "PhonePe Flow Completed - Status: Success!";
              checkoutController.placeOrderCheckout(
                customerId:
                    "${addressController.customerModel!.value.customerId}",
                addressId: "${addressController.selectedAddressId}",
                orderPaymentMethod: "online",
                orderTransactionNo: response['merchantTransactionId'] ?? "",
              );
              cartController.cartCount.value = 0;
              cartController.cartList.clear();
              cartController.update();
              homeController.getDashboardData(
                  addressController.customerModel!.value.customerId);
              Fluttertoast.showToast(
                msg: "PhonePe Payment Successful",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 4,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Get.offAll(() => DashboardScreen(pageIndex: 0));
            } else {
              result =
                  "PhonePe Flow Completed - Status: $status, Error: $error";
              Fluttertoast.showToast(
                msg: "PhonePe Payment Failed: $error",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 4,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          } else {
            result = "PhonePe Flow Incomplete";
            Fluttertoast.showToast(
              msg: "PhonePe Payment Incomplete",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        });
      }).catchError((error) {
        handlePhonePeError(error);
      });
    } catch (e) {
      handlePhonePeError(e);
    }
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
    Fluttertoast.showToast(
      msg: "Payment Successful",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Get.offAll(() => DashboardScreen(pageIndex: 0));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment process cancelled by user",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: ${response.walletName!}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void openPaymentGateway(int amount, PaymentGateway gateWay) async {
    int finalAmount = amount * 100;
    print("RazorPay key ${gateWay.gatewayCredentialsJson!['key_id']}");
    var options = {
      'key': gateWay.gatewayCredentialsJson!['key_id'],
      'amount': finalAmount,
      'name': addressController.customerModel!.value.customerName,
      'description': '-Shopping',
      'prefill': {
        'contact':
            '${addressController.customerModel!.value.customerPhoneNo}' ??
                '1234567890',
        'email': '${addressController.customerModel!.value.customerEmailId}' ??
            'demo@gmail.com'
      },
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
            title: StringRes.summary,
            style: Themes.light.textTheme.headlineLarge,
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
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade300, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProgressStep(1, StringRes.cart, false, true),
                    _buildProgressLine(true),
                    _buildProgressStep(2, StringRes.address, false, true),
                    _buildProgressLine(true),
                    _buildProgressStep(3, StringRes.payment, false, true),
                    _buildProgressLine(true),
                    _buildProgressStep(4, StringRes.summary, true, false),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 8)),
            Obx(
              () => cartController.isCartLoading.value
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: COLOR.appBaseColor,
                        ),
                      ),
                    )
                  : cartController.cartList.isEmpty
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(StringRes.noItemsInCart),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
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
                                            "${IMAGE_URL + item.packInfo![0].productdetailImages![0]!}" ??
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
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.productName ??
                                                    StringRes.productName,
                                                style: const TextStyle(
                                                    fontSize: 14),
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
                                                StringRes
                                                    .onlyWrongDefectItemReturnsAllowed,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Quantity: ${item.productQty}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Text(
                                                    "${StringRes.qty}: ${item.cartQuantity ?? 1}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Text(
                                              //   "${StringRes.color}: ${item.productColor}",
                                              //   style: TextStyle(
                                              //     fontSize: 12,
                                              //     color: Colors.grey.shade700,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
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
                                          "${StringRes.soldBy} : ${item.productName ?? '${StringRes.seller}'}",
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
                                  const Divider(),
                                ],
                              );
                            },
                            childCount: cartController.cartList.length,
                          ),
                        ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringRes.deleiveryAddress,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            addressController.getAllAddress();
                            Get.to(() => const AddressScreen());
                          },
                          child: Icon(Icons.chevron_right,
                              color: Colors.grey.shade400),
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
                          ? Text(StringRes.noAddressSelected)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedAddress.addressFullName ??
                                      StringRes.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${selectedAddress.addressColony ?? ''}, ${selectedAddress.cityName ?? ''}, ${selectedAddress.stateName ?? ''}, ${selectedAddress.addressPincode ?? ''}\n"
                                  // "New York ${selectedAddress.addressPincode ?? ''}\n"
                                  "${selectedAddress.addressMobileNo ?? ''}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  StringRes.edit,
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
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringRes.paymentMode,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => const PaymentScreen());
                          },
                          child: Icon(Icons.chevron_right,
                              color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Text(
                          checkoutController.selectedPaymentMethod.value ==
                                  StringRes.cashOnDelivery
                              ? StringRes.cashOnDelivery
                              : checkoutController
                                          .selectedPaymentMethod.value ==
                                      StringRes.razorPay
                                  ? StringRes.razorPay
                                  : StringRes.phonePe,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 100)),
          ],
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
            title: StringRes.placeOrder,
            style: Themes.light.textTheme.displayLarge!.copyWith(
              color: Colors.white,
            ),
            voidCallback: () {
              print(
                  "Selected Payment Method: ${checkoutController.selectedPaymentMethod.value}");
              print(
                  "Selected Payment: ${checkoutController.selectedPayment.value}");
              if (checkoutController.selectedPaymentMethod.value == "COD") {
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
                Get.offAll(() => DashboardScreen(pageIndex: 0));
              } else if (checkoutController.selectedPaymentMethod.value ==
                  "RazorPay") {
                print(
                    "Summary Screen RazorPay ${cartController.cartTotal.value!.totalInteger}");
                print(
                    "Summary Screen RazorPay ${checkoutController!.paymentGateway!.gatewayCredentialsJson!['key_id']}");
                print(
                    "Payment Method ${checkoutController.selectedPaymentMethod.value} ${checkoutController.paymentGateway!.gatewayCredentialsJson!['key_id']}");
                openPaymentGateway(
                    cartController.cartTotal.value!.totalInteger!,
                    checkoutController.paymentGateway!);
              } else if (checkoutController.selectedPayment.value ==
                  "PhonePe") {
                startPhonePeTransaction(
                    cartController.cartTotal.value!.totalInteger!);
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
                ? COLOR.appBaseColor
                : (isCompleted ? COLOR.appBaseColor : Colors.grey.shade300),
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
}
