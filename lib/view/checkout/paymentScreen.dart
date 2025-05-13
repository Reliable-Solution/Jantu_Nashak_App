import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
// import 'package:keep_app/view/checkout/summary_screen.dart';

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
  String selectedPayment = 'Razorpay';



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
            title: "PAYMENT METHOD",
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
                  _buildProgressStep(1, "Cart", false, true),
                  _buildProgressLine(true),
                  _buildProgressStep(2, "Address", false, true),
                  _buildProgressLine(true),
                  _buildProgressStep(3, "Payment", true, false),
                  _buildProgressLine(false),
                  _buildProgressStep(4, "Summary", false, false),
                ],
              ),
            ),

            // Payment method header with security badge
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   color: Colors.white,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text(
            //         "Select Payment Method",
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       Container(
            //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //         decoration: BoxDecoration(
            //           color: Colors.grey.shade100,
            //           borderRadius: BorderRadius.circular(4),
            //         ),
            //         child: Row(
            //           children: [
            //             Icon(
            //               Icons.verified,
            //               size: 16,
            //               color: Colors.blue.shade300,
            //             ),
            //             const SizedBox(width: 4),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 const Text(
            //                   "100% SAFE",
            //                   style: TextStyle(
            //                     fontSize: 10,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //                 const Text(
            //                   "PAYMENTS",
            //                   style: TextStyle(
            //                     fontSize: 10,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select payment method",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 12),

                  Obx(() => buildPaymentOption(
                    image: "money.png",
                    title: "Cash on Delivery",
                    price:
                    "₹${cartController.cartTotal.value?.totalInteger.toString() ?? 0}",
                    icon: Icons.money,
                    method: "cod",
                    controller: controller,
                  )),

                  SizedBox(height: 12),

                  // Pay Online
                  Obx(() => buildPaymentOption(
                    image: "payment-online.png",

                    title: "Pay Online",
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

            const SizedBox(height: 8),

            // // Pay in cash section
            // Container(
            //   width: double.infinity,
            //   color: Colors.white,
            //   padding: const EdgeInsets.all(16),
            //   child: const Text(
            //     "PAY IN CASH",
            //     style: TextStyle(
            //       fontSize: 14,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),

            // Cash on delivery option
            // Container(
            //   color: Colors.white,
            //   child: Column(
            //     children: [
            //       ListTile(
            //         leading: const Icon(
            //           Icons.attach_money,
            //           color: Colors.blue,
            //         ),
            //         title: const Text(
            //           "Cash on Delivery",
            //           style: TextStyle(
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //         trailing: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Obx(() => Icon(
            //               checkoutController.selectedPaymentMethod.value == "cod"
            //                   ? Icons.check_circle
            //                   : Icons.circle_outlined,
            //               color: checkoutController.selectedPaymentMethod.value == "cod"
            //                   ? Colors.green
            //                   : Colors.grey,
            //             )),
            //             const Icon(Icons.keyboard_arrow_down),
            //           ],
            //         ),
            //         onTap: () {
            //           checkoutController.selectPaymentMethod("cod");
            //         },
            //       ),
            //
            //       // Expanded cash on delivery option
            //       // Obx(() => checkoutController.selectedPaymentMethod.value == "cod"
            //       //     ? Container(
            //       //   color: Colors.green.shade50,
            //       //   padding: const EdgeInsets.all(16),
            //       //   child: Row(
            //       //     children: [
            //       //       const Icon(
            //       //         Icons.account_balance_wallet,
            //       //         color: Colors.green,
            //       //       ),
            //       //       const SizedBox(width: 16),
            //       //       const Text(
            //       //         "Pay cash on delivery",
            //       //         style: TextStyle(
            //       //           fontWeight: FontWeight.w500,
            //       //         ),
            //       //       ),
            //       //       const Spacer(),
            //       //       Container(
            //       //         width: 20,
            //       //         height: 20,
            //       //         decoration: BoxDecoration(
            //       //           shape: BoxShape.circle,
            //       //           border: Border.all(
            //       //             color: COLOR.appBaseColor,
            //       //             width: 2,
            //       //           ),
            //       //         ),
            //       //         child: Center(
            //       //           child: Container(
            //       //             width: 10,
            //       //             height: 10,
            //       //             decoration: BoxDecoration(
            //       //               shape: BoxShape.circle,
            //       //               color: COLOR.appBaseColor,
            //       //             ),
            //       //           ),
            //       //         ),
            //       //       ),
            //       //     ],
            //       //   ),
            //       // )
            //       //     : const SizedBox(),
            //       // ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 8),

            // Reselling order section
            // Container(
            //   color: Colors.white,
            //   padding: const EdgeInsets.all(16),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         "Reselling the Order?",
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //       const SizedBox(height: 4),
            //       Row(
            //         children: [
            //           const Text(
            //             "Click on 'Yes' to add Final Price",
            //             style: TextStyle(
            //               fontSize: 12,
            //               color: Colors.grey,
            //             ),
            //           ),
            //           const Spacer(),
            //           Container(
            //             decoration: BoxDecoration(
            //               border: Border.all(
            //                 color: COLOR.appBaseColor,
            //               ),
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            //             child: const Text(
            //               "No",
            //               style: TextStyle(
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ),
            //           const SizedBox(width: 8),
            //           Container(
            //             decoration: BoxDecoration(
            //               color: Colors.grey.shade200,
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            //             child: const Text(
            //               "Yes",
            //               style: TextStyle(
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            //
            // const SizedBox(height: 8),

            // Price details
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
                      const Text(
                        "Total Product Price",
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
                      const Text(
                        "Total Discounts",
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
            () =>  ButtonWidgets(
              title: "Continue",
              style: Themes.light.textTheme.displayLarge!.copyWith(
                color: Colors.white,
              ),
              voidCallback: () {
                if (checkoutController.selectedPaymentMethod.value.isNotEmpty) {
                  Get.to(() => const SummaryScreen());
                }
                if (checkoutController.selectedPaymentMethod.value.isEmpty) {
                  Fluttertoast.showToast(
                    msg:
                    "Please Select Payment Method",
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
        buildPaymentOption2("PhonePe", "Offers Available", 'PhonePe'),
        buildPaymentOption2("Razorpay", "Offers Available", 'Razorpay'),
        buildPaymentOption2("Cashfree", "Offers Available", 'Cashfree'),
        // buildExpandableTile("Pay by any UPI App", "Offers Available"),
        // buildExpandableTile("Wallet", "Offers Available"),
        // buildExpandableTile("Debit/Credit Cards", "Offers Available"),
        // buildExpandableTile("Net Banking", ""),
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


  Widget _buildProgressStep(int step, String label, bool isActive, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.blue : (isCompleted ? Colors.blue : Colors.grey.shade300),
            border: Border.all(
              color: isActive || isCompleted ? Colors.blue : Colors.grey.shade400,
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
            fontWeight: isActive || isCompleted ? FontWeight.bold : FontWeight.normal,
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
