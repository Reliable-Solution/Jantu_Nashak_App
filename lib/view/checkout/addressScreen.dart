// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:keep_app/controller/addressController.dart';
// // import 'package:keep_app/Theme/nativeTheme.dart';
// // import 'package:keep_app/constant/colorConst.dart';
// // import 'package:keep_app/utils/string_res.dart';
// // import 'package:keep_app/view/checkout/paymentScreen.dart';
// // import 'package:keep_app/widget/buttonWidget.dart';
// // import 'package:keep_app/widget/appBarWidget.dart';
// // import 'package:keep_app/widget/textWidget.dart';
// //
// // import '../../widget/selectAddress.dart';
// // import '../address/pickupAddressScreen.dart';
// // // import 'package:keep_app/view/checkout/payment_screen.dart';
// //
// // class AddressScreen extends StatefulWidget {
// //   const AddressScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<AddressScreen> createState() => _AddressScreenState();
// // }
// //
// // class _AddressScreenState extends State<AddressScreen> {
// //   final AddressController controller = Get.find();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // controller.getAllAddress(controller.customerModel!.value.customerId!);x
// //     controller.getAllAddress();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       top: false,
// //       bottom: true,
// //       child: Scaffold(
// //         backgroundColor: Colors.grey.shade100,
// //         appBar: MyCustomAppBar(
// //           actionPadding: 10,
// //           height: 100,
// //           appbarPadding: 0,
// //           elevation: 1,
// //           title: TextWiget(
// //             title: "SELECT DELIVERY ADDRESS",
// //             style: Themes.light.textTheme.displayLarge,
// //           ),
// //           leading: InkWell(
// //             onTap: () {
// //               Get.back();
// //             },
// //             child: Icon(
// //               Icons.arrow_back,
// //               color: Colors.black,
// //               size: 24,
// //             ),
// //           ),
// //         ),
// //         body: Column(
// //           children: [
// //             // Checkout progress indicator
// //             Container(
// //               padding: const EdgeInsets.symmetric(vertical: 16),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 border: Border(
// //                   bottom: BorderSide(color: Colors.grey.shade300, width: 1),
// //                 ),
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   _buildProgressStep(1, "Cart", false, true),
// //                   _buildProgressLine(true),
// //                   _buildProgressStep(2, "Address", true, false),
// //                   _buildProgressLine(false),
// //                   _buildProgressStep(3, "Payment", false, false),
// //                   _buildProgressLine(false),
// //                   _buildProgressStep(4, "Summary", false, false),
// //                 ],
// //               ),
// //             ),
// //
// //             // Add new address button
// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //               color: Colors.white,
// //               child: GestureDetector(
// //                 onTap: () {
// //                   clearTextFields(controller);
// //                   Get.to(() => PickupAddressScreen())?.then((_) {
// //                     controller.getAllAddress();
// //                   });
// //                   // Navigate to add address screen
// //                 },
// //                 child: Text(
// //                   "* ADD NEW ADDRESS",
// //                   style: TextStyle(
// //                     color: COLOR.appBaseColor,
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //
// //             const SizedBox(height: 8),
// //
// //             // Address list
// //             Expanded(
// //               child: Obx(() => controller.allAddressList.isEmpty
// //                   ? Center(child: Text("No addresses found"))
// //                   : ListView.builder(
// //                 itemCount: controller.allAddressList.length,
// //                 itemBuilder: (context, index) {
// //                   final address = controller.allAddressList[index];
// //                   final isSelected = controller.selectedAddressId.value == address.addressId.toString();
// //
// //                   return Container(
// //                     margin: const EdgeInsets.only(bottom: 8),
// //                     color: Colors.white,
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         ListTile(
// //                           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                           title: Text(
// //                             address.addressFullName ?? "Name",
// //                             style: const TextStyle(
// //                               fontWeight: FontWeight.w500,
// //                               fontSize: 16,
// //                             ),
// //                           ),
// //                           subtitle: Padding(
// //                             padding: const EdgeInsets.only(top: 8),
// //                             child: Text(
// //                               "${address.addressColony ?? ''}, ${address.cityName ?? ''}, ${address.stateName ?? ''}, ${address.addressPincode ?? ''}\n"
// //                                   "Ney york ${address.addressPincode ?? ''}\n"
// //                                   "${address.addressMobileNo ?? ''}",
// //                               style: const TextStyle(
// //                                 fontSize: 14,
// //                                 height: 1.4,
// //                               ),
// //                             ),
// //                           ),
// //                           trailing: Radio<bool>(
// //                             value: true,
// //                             groupValue: isSelected,
// //                             activeColor: COLOR.appBaseColor,
// //                             onChanged: (value) {
// //                               print("========== Address id print ${value}");
// //
// //                               controller.selectedAddressId.value = address.addressId.toString();
// //                               print("========== Address id print 1 == ${controller.selectedAddressId.value}");
// //
// //
// //                             },
// //                           ),
// //                         ),
// //                         Padding(
// //                           padding: const EdgeInsets.only(left: 16, bottom: 8),
// //                           child: Text(
// //                             "EDIT",
// //                             style: TextStyle(
// //                               color: COLOR.appBaseColor,
// //                               fontWeight: FontWeight.w500,
// //                               fontSize: 14,
// //                             ),
// //                           ),
// //                         ),
// //                         Container(
// //                           width: double.infinity,
// //                           padding: const EdgeInsets.symmetric(vertical: 16),
// //                           child: ButtonWidgets(
// //                             title: "Deliver to this Address",
// //                             style: Themes.light.textTheme.displayLarge!.copyWith(
// //                               color: Colors.white,
// //                             ),
// //                             voidCallback: () {
// //                               controller.selectedAddressId.value = address.addressId.toString();
// //                                Get.to(() => const PaymentScreen());
// //                             },
// //                             color: COLOR.appBaseColor,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildProgressStep(int step, String label, bool isActive, bool isCompleted) {
// //     return Column(
// //       children: [
// //         Container(
// //           width: 30,
// //           height: 30,
// //           decoration: BoxDecoration(
// //             shape: BoxShape.circle,
// //             color: isActive ? Colors.blue : (isCompleted ? Colors.blue : Colors.grey.shade300),
// //             border: Border.all(
// //               color: isActive || isCompleted ? Colors.blue : Colors.grey.shade400,
// //               width: 1,
// //             ),
// //           ),
// //           child: Center(
// //             child: isCompleted
// //                 ? const Icon(Icons.check, color: Colors.white, size: 16)
// //                 : Text(
// //               step.toString(),
// //               style: TextStyle(
// //                 color: isActive ? Colors.white : Colors.grey.shade600,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 4),
// //         Text(
// //           label,
// //           style: TextStyle(
// //             fontSize: 12,
// //             color: isActive || isCompleted ? Colors.blue : Colors.grey.shade600,
// //             fontWeight: isActive || isCompleted ? FontWeight.bold : FontWeight.normal,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildProgressLine(bool isActive) {
// //     return Container(
// //       width: 40,
// //       height: 1,
// //       color: isActive ? Colors.blue : Colors.grey.shade300,
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:keep_app/controller/addressController.dart';
// import 'package:keep_app/Theme/nativeTheme.dart';
// import 'package:keep_app/constant/colorConst.dart';
// import 'package:keep_app/utils/string_res.dart';
// import 'package:keep_app/view/checkout/paymentScreen.dart';
// import 'package:keep_app/widget/buttonWidget.dart';
// import 'package:keep_app/widget/appBarWidget.dart';
// import 'package:keep_app/widget/textWidget.dart';
// import '../../widget/selectAddress.dart';
// import '../address/pickupAddressScreen.dart';
//
// class AddressScreen extends StatefulWidget {
//   const AddressScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }
//
// class _AddressScreenState extends State<AddressScreen> {
//   final AddressController controller = Get.find();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.getAllAddress();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       bottom: true,
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade100,
//         appBar: MyCustomAppBar(
//           actionPadding: 10,
//           height: 100,
//           appbarPadding: 0,
//           elevation: 1,
//           title: TextWiget(
//             title: "SELECT DELIVERY ADDRESS",
//             style: Themes.light.textTheme.displayLarge,
//           ),
//           leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: const Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//               size: 24,
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             // Checkout progress indicator
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border(
//                   bottom: BorderSide(color: Colors.grey.shade300, width: 1),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildProgressStep(1, "Cart", false, true),
//                   _buildProgressLine(true),
//                   _buildProgressStep(2, "Address", true, false),
//                   _buildProgressLine(false),
//                   _buildProgressStep(3, "Payment", false, false),
//                   _buildProgressLine(false),
//                   _buildProgressStep(4, "Summary", false, false),
//                 ],
//               ),
//             ),
//
//             // Add new address button
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               color: Colors.white,
//               child: GestureDetector(
//                 onTap: () {
//                   clearTextFields(controller);
//                   Get.to(() => PickupAddressScreen())?.then((_) {
//                     controller.getAllAddress();
//                   });
//                 },
//                 child: Text(
//                   "* ADD NEW ADDRESS",
//                   style: TextStyle(
//                     color: COLOR.appBaseColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 8),
//
//             // Address list
//             Expanded(
//               child: Obx(() => controller.allAddressList.isEmpty
//                   ? const Center(child: Text("No addresses found"))
//                   : ListView.builder(
//                 itemCount: controller.allAddressList.length,
//                 itemBuilder: (context, index) {
//                   final address = controller.allAddressList[index];
//                   final isSelected =
//                       controller.selectedAddressId.value == address.addressId.toString();
//
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
//                     decoration: BoxDecoration(
//                       color: isSelected ? const Color(0xFF8B5CF6) : Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ListTile(
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           title: Text(
//                             address.addressFullName ?? "Name",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: isSelected ? Colors.white : Colors.black,
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.only(top: 8),
//                             child: Text(
//                               "${address.addressColony ?? ''}, ${address.cityName ?? ''}, ${address.stateName ?? ''}, ${address.addressPincode ?? ''}\n"
//                                   "New York ${address.addressPincode ?? ''}\n"
//                                   "${address.addressMobileNo ?? ''}",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 height: 1.4,
//                                 color: isSelected ? Colors.white70 : Colors.black87,
//                               ),
//                             ),
//                           ),
//                           trailing: Radio<bool>(
//                             value: true,
//                             groupValue: isSelected,
//                             activeColor: isSelected ? Colors.white : COLOR.appBaseColor,
//                             fillColor: MaterialStateProperty.resolveWith<Color>(
//                                   (Set<MaterialState> states) {
//                                 if (isSelected) return Colors.white;
//                                 return COLOR.appBaseColor;
//                               },
//                             ),
//                             onChanged: (value) {
//                               controller.selectedAddressId.value = address.addressId.toString();
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, bottom: 8),
//                           child: Text(
//                             "EDIT",
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : COLOR.appBaseColor,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                         if (isSelected)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                             child: SizedBox(
//                               width: double.infinity,
//                               child: ButtonWidgets(
//                                 title: "Deliver to this Address",
//                                 style: Themes.light.textTheme.displayLarge!.copyWith(
//                                   color: Colors.white,
//                                 ),
//                                 voidCallback: () {
//                                   controller.selectedAddressId.value =
//                                       address.addressId.toString();
//                                   Get.to(() => const PaymentScreen());
//                                 },
//                                 color: const Color(0xFF6D28D9),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   );
//                 },
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProgressStep(int step, String label, bool isActive, bool isCompleted) {
//     return Column(
//       children: [
//         Container(
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: isActive ? Colors.blue : (isCompleted ? Colors.blue : Colors.grey.shade300),
//             border: Border.all(
//               color: isActive || isCompleted ? Colors.blue : Colors.grey.shade400,
//               width: 1,
//             ),
//           ),
//           child: Center(
//             child: isCompleted
//                 ? const Icon(Icons.check, color: Colors.white, size: 16)
//                 : Text(
//               step.toString(),
//               style: TextStyle(
//                 color: isActive ? Colors.white : Colors.grey.shade600,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: isActive || isCompleted ? Colors.blue : Colors.grey.shade600,
//             fontWeight: isActive || isCompleted ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProgressLine(bool isActive) {
//     return Container(
//       width: 40,
//       height: 1,
//       color: isActive ? Colors.blue : Colors.grey.shade300,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/controller/addressController.dart';
import 'package:keep_app/Theme/nativeTheme.dart';
import 'package:keep_app/constant/colorConst.dart';
import 'package:keep_app/utils/string_res.dart';
import 'package:keep_app/view/checkout/paymentScreen.dart';
import 'package:keep_app/widget/buttonWidget.dart';
import 'package:keep_app/widget/appBarWidget.dart';
import 'package:keep_app/widget/textWidget.dart';
import '../../constant/colorConst.dart';
import '../../widget/selectAddress.dart';
import '../address/pickupAddressScreen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.getAllAddress();
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
            title: StringRes.selectDeliveryAddress,
            style: Themes.light.textTheme.displayLarge,
          ),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
        body: GetBuilder<AddressController>(
          builder: (controller) =>  Column(
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
                    _buildProgressStep(2, StringRes.address, true, false),
                    _buildProgressLine(false),
                    _buildProgressStep(3, StringRes.payment, false, false),
                    _buildProgressLine(false),
                    _buildProgressStep(4, StringRes.summary, false, false),
                  ],
                ),
              ),

              // Add new address button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    clearTextFields(controller);
                    Get.to(() => PickupAddressScreen())?.then((_) {
                      controller.getAllAddress();
                    });
                  },
                  child: Text(
                    "* ${StringRes.addAddress}",
                    style: TextStyle(
                      color: COLOR.appBaseColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Address list
              Expanded(
                child: Obx(() {
                  if (controller.allAddressList.isEmpty) {
                    return  Center(child: Text(StringRes.noAddressesFound));
                  }
                  return ListView.builder(
                    itemCount: controller.allAddressList.length,
                    itemBuilder: (context, index) {
                      final address = controller.allAddressList[index];
                      final isSelected =
                          controller.selectedAddressId.value == address.addressId.toString();

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                        decoration: BoxDecoration(
                          color: isSelected ?  Color(0xffe8eeff) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              title: Text(
                                address.addressFullName ?? StringRes.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  "${address.addressColony ?? ''}, ${address.cityName ?? ''}, ${address.stateName ?? ''}, ${address.addressPincode ?? ''}\n"
                                      "New York ${address.addressPincode ?? ''}\n"
                                      "${address.addressMobileNo ?? ''}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              trailing: Radio<bool>(
                                value: true,
                                groupValue: isSelected,
                                activeColor:  COLOR.appBaseColor,
                                fillColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    // if (isSelected) return Colors.white;
                                    return COLOR.appBaseColor;
                                  },
                                ),
                                onChanged: (value) {
                                  print("Selected Address ID: ${address.addressId}");
                                  controller.selectedAddressId.value = address.addressId.toString();
                                  print("Updated selectedAddressId: ${controller.selectedAddressId.value}");
                                  controller.update(); // Force GetX to update UI
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, bottom: 8),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to edit address screen with pre-filled data
                                  Get.to(() => PickupAddressScreen(address: address))?.then((_) {
                                    controller.getAllAddress();
                                  });
                                },
                                child: Text(
                                  StringRes.edit,
                                  style: TextStyle(
                                    color: COLOR.appBaseColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            if (isSelected)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ButtonWidgets(
                                    title: StringRes.deliverToThisAddress,
                                    style: Themes.light.textTheme.displayLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                                    voidCallback: () {
                                      controller.selectedAddressId.value =
                                          address.addressId.toString();
                                      Get.to(() => const PaymentScreen());
                                    },
                                    color:  COLOR.appBaseColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
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
}