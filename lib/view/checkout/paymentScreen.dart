import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keep_app/constant/app_constant.dart';
import 'package:keep_app/controller/addressController.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/checkoutController.dart';
import 'package:keep_app/Theme/nativeTheme.dart';
import 'package:keep_app/constant/colorConst.dart';
import 'package:keep_app/utils/string_res.dart';
import 'package:keep_app/view/checkout/summaryScreen.dart';
import 'package:keep_app/widget/buttonWidget.dart';
import 'package:keep_app/widget/appBarWidget.dart';
import 'package:keep_app/widget/textWidget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final AddressController addressController = Get.find();
  final CartController cartController = Get.find();
  final CheckoutController checkoutController = Get.find();
  final AddressController controller = Get.find();

  // String selectedPayment = 'Razorpay';

  @override
  void initState() {
    checkoutController.getPaymentMethod();
    super.initState();
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
            title: StringRes.paymentMethod,
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
        body: Column(
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
                  _buildProgressStep(1, StringRes.cart, false, true),
                  _buildProgressLine(true),
                  _buildProgressStep(2, StringRes.address, false, true),
                  _buildProgressLine(true),
                  _buildProgressStep(3, StringRes.payment, true, false),
                  _buildProgressLine(false),
                  _buildProgressStep(4, StringRes.summary, false, false),
                ],
              ),
            ),

            Container(
              color: Colors.white,
              width:  MediaQuery.sizeOf(context).width * 0.99,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringRes.selectPaymentMethod,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 12),
                  Obx(() {
                    if (checkoutController.isLoading.value) {
                      return Center(child: CircularProgressIndicator(color: COLOR.appBaseColor,));
                    } else if (checkoutController.paymentMethodList.isEmpty) {
                      return  Center(child: Text(StringRes.noPaymentMethodsFound,
                      ));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: checkoutController.paymentMethodList.length,
                        itemBuilder: (context, index) {
                          final gateway = checkoutController.paymentMethodList[index];
                          return GestureDetector(
                            onTap: () {
                              checkoutController.selectPaymentMethod(gateway.gatewayName ?? '');
                              checkoutController.selectPaymentGateWay(gateway);
                            },
                            child: ListTile(
                              trailing: Obx(() => Radio<String>(
                                value: gateway.gatewayName ?? '',
                                groupValue: checkoutController.selectedPaymentMethod.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    checkoutController.selectPaymentMethod(value);
                                    checkoutController.selectPaymentGateWay(gateway);
                                  }
                                },
                                activeColor: COLOR.appBaseColor,
                              )),
                              leading: gateway.gatewayLogo != null
                                  ? Image.network('$IMAGE_URL${gateway.gatewayLogo}')
                                  : const Icon(Icons.image_not_supported),
                              title: Text(gateway.gatewayName ?? 'Unknown'),
                            ),
                          );
                        },
                      );
                    }
                  }),

                  SizedBox(height: 30),
                ],
              ),
            ),

            const SizedBox(height: 8),

            const SizedBox(height: 8),

            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Price Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                    StringRes.totalProductPrice,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Obx(() => Text(
                            "+ ₹${cartController.cartTotal.value?.totalInteger ?? 0}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                    StringRes.totalDiscounts,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "- ₹${cartController.cartTotal.value?.save ?? 0}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                ],
              ),
            ),
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
          child: Obx(
            () => ButtonWidgets(
              title: "Continue",
              style: Themes.light.textTheme.displayLarge!.copyWith(
                color: Colors.white,
              ),
              voidCallback: () {
                if (checkoutController.selectedPaymentMethod.value.isNotEmpty) {
                  cartController.getCartDetails(cartController.customerModel!.value.customerId!);
                  Get.to(() => const SummaryScreen());
                }
                if (checkoutController.selectedPaymentMethod.value.isEmpty) {
                  Fluttertoast.showToast(
                    msg: StringRes.pleaseSelectPaymentMethod,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    timeInSecForIosWeb: 1,
                  );

                  // Get.to(() => const SummaryScreen());
                }
              },
              color: checkoutController.selectedPaymentMethod.value.isNotEmpty
                  ? COLOR.appBaseColor
                  : Colors.grey,
            ),
          ),
        ),
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
                  StringRes.offerAvailable,
                  checkoutController.paymentMethodList[index].gatewayName!);
            },
          ),
        )
      ],
    );
  }



  Widget buildPaymentOption2(String title, String subText, String value) {
    return Obx(() => Column(
          children: [
            ListTile(
              onTap: () {
                checkoutController.selectedPayment.value = value;
              },
              leading: Radio<String>(
                value: value,
                groupValue: checkoutController.selectedPayment.value,
                onChanged: (String? newValue) {
                  checkoutController.selectedPayment.value = newValue!;
                },
              ),
              title: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              subtitle: subText.isNotEmpty
                  ? Text(subText, style: TextStyle(color: Colors.green))
                  : null,
            ),
            Divider(),
          ],
        ));
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
              color:
                  isActive || isCompleted ? COLOR.appBaseColor : Colors.grey.shade400,
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
            color: isActive || isCompleted ? COLOR.appBaseColor: Colors.grey.shade600,
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
