import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keep_app/utils/binding/networkBinding.dart';
import 'package:keep_app/utils/services/languageServices.dart';
import 'package:keep_app/view/splash/splashScreen.dart';

import 'controller/languageController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() async => LanguageController());

  await LocalizationService.loadTranslations(); // ✅ Translations Load Karega

  Firebase.initializeApp();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocalizationService(),
      locale: Get.locale ?? Locale('en', 'US'),
      // 👈 Default locale
      fallbackLocale: Locale('en', 'US'),
      // 👈 Fallback Language
      home: SplashScreen(),
      initialBinding: NetworkBinding(),
    ),
  );
}


// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get_navigation/src/root/get_material_app.dart';
// // import 'package:get_storage/get_storage.dart';
// // import 'package:keep_app/utils/binding/networkBinding.dart';
// // import 'package:keep_app/utils/services/languageServices.dart';
// // import 'package:keep_app/view/splash/splashScreen.dart';
// //
// // import 'controller/languageController.dart';
// //
// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Get.putAsync(() async => LanguageController());
// //
// //   await LocalizationService.loadTranslations(); // ✅ Translations Load Karega
// //
// //   Firebase.initializeApp();
// //   await GetStorage.init();
// //   runApp(
// //     GetMaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       translations: LocalizationService(),
// //       locale: Get.locale ?? Locale('en', 'US'),
// //       // 👈 Default locale
// //       fallbackLocale: Locale('en', 'US'),
// //       // 👈 Fallback Language
// //       home: SplashScreen(),
// //       initialBinding: NetworkBinding(),
// //     ),
// //   );
// // }
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// // =============== MODELS ===============
//
// class CartItem {
//   final int id;
//   final String name;
//   final double price;
//   final String size;
//   final String color;
//   final String image;
//
//   CartItem({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.size,
//     required this.color,
//     required this.image,
//   });
// }
//
// class Address {
//   final int id;
//   final String type;
//   final String name;
//   final String phone;
//   final String address;
//   final bool isDefault;
//
//   Address({
//     required this.id,
//     required this.type,
//     required this.name,
//     required this.phone,
//     required this.address,
//     required this.isDefault,
//   });
// }
//
// // =============== CONTROLLERS ===============
//
// class CartController extends GetxController {
//   var cartItems = <CartItem>[].obs;
//   var subtotal = 0.0.obs;
//   var vat = 0.0.obs;
//   var discount = 0.0.obs;
//   var deliveryCharge = 0.0.obs;
//   var total = 0.0.obs;
//   var currentStep = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Add sample items
//     cartItems.add(
//       CartItem(
//         id: 1,
//         name: 'T-Shirt for man',
//         price: 60.0,
//         size: 'L',
//         color: 'Black',
//         image: 'assets/images/tshirt1.png',
//       ),
//     );
//     cartItems.add(
//       CartItem(
//         id: 2,
//         name: 'T-Shirt for man',
//         price: 50.0,
//         size: 'L',
//         color: 'Black',
//         image: 'assets/images/tshirt2.png',
//       ),
//     );
//     calculateTotal();
//   }
//
//   void calculateTotal() {
//     total.value = 0;
//     for (var item in cartItems) {
//       total.value += item.price;
//     }
//
//     vat.value = total.value * 0.03;
//     discount.value = total.value * 0.03;
//     deliveryCharge.value = 0.0; // Free delivery
//
//     subtotal.value = total.value + vat.value - discount.value;
//   }
//
//   void removeItem(int id) {
//     cartItems.removeWhere((item) => item.id == id);
//     calculateTotal();
//   }
//
//   void nextStep() {
//     if (currentStep.value < 2) {
//       currentStep.value++;
//     }
//   }
//
//   void previousStep() {
//     if (currentStep.value > 0) {
//       currentStep.value--;
//     }
//   }
// }
//
// class AddressController extends GetxController {
//   var addresses = <Address>[].obs;
//   var selectedAddressId = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Add sample addresses
//     addresses.add(
//       Address(
//         id: 1,
//         type: 'Home',
//         name: 'Sunamganj',
//         phone: '+971-50-1234567',
//         address: 'Room #1 - Ground Floor, Al Najoun Bulding, 24 B Street, Dubai - United Arab Emirates',
//         isDefault: true,
//       ),
//     );
//     addresses.add(
//       Address(
//         id: 2,
//         type: 'Work',
//         name: 'Sylhet',
//         phone: '+971-50-1234567',
//         address: 'Abu Dhabi Mall - 10th St - Al Zahiyah, Abu Dhabi - United Arab Emirates',
//         isDefault: false,
//       ),
//     );
//
//     // Set default selected address
//     if (addresses.isNotEmpty) {
//       selectedAddressId.value = addresses.first.id;
//     }
//   }
//
//   void selectAddress(int id) {
//     selectedAddressId.value = id;
//   }
//
//   void addAddress(Address address) {
//     addresses.add(address);
//   }
//
//   void updateAddress(Address updatedAddress) {
//     final index = addresses.indexWhere((address) => address.id == updatedAddress.id);
//     if (index != -1) {
//       addresses[index] = updatedAddress;
//     }
//   }
//
//   void deleteAddress(int id) {
//     addresses.removeWhere((address) => address.id == id);
//     if (selectedAddressId.value == id && addresses.isNotEmpty) {
//       selectedAddressId.value = addresses.first.id;
//     }
//   }
// }
//
// // =============== WIDGETS ===============
//
// class StepperWidget extends StatelessWidget {
//   final int currentStep;
//
//   StepperWidget({required this.currentStep});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         _buildStepItem('Cart', 0, currentStep >= 0),
//         _buildStepConnector(currentStep >= 1),
//         _buildStepItem('Address', 1, currentStep >= 1),
//         _buildStepConnector(currentStep >= 2),
//         _buildStepItem('Payment', 2, currentStep >= 2),
//       ],
//     );
//   }
//
//   Widget _buildStepItem(String label, int step, bool isActive) {
//     Color circleColor;
//     Color textColor;
//
//     if (step < currentStep) {
//       // Completed step
//       circleColor = Color(0xff900C3F);
//       textColor = Color(0xff900C3F);
//     } else if (step == currentStep) {
//       // Current step
//       circleColor = Color(0xff900C3F);
//       textColor = Color(0xff900C3F);
//     } else {
//       // Future step
//       circleColor = Color(0xFF1A237E);
//       textColor = Color(0xFF1A237E);
//     }
//
//     return Expanded(
//       child: Column(
//         children: [
//           Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               color: isActive ? circleColor : Colors.white,
//               border: Border.all(
//                 color: circleColor,
//                 width: 2,
//               ),
//               shape: BoxShape.circle,
//             ),
//             child: isActive && step < currentStep
//                 ? Icon(
//               Icons.check,
//               size: 14,
//               color: Colors.white,
//             )
//                 : null,
//           ),
//           SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               color: textColor,
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStepConnector(bool isActive) {
//     return Expanded(
//       child: Container(
//         height: 2,
//         color: isActive ? Color(0xFF26A69A) : Color(0xFFE0E0E0),
//       ),
//     );
//   }
// }
//
// // =============== SCREENS ===============
//
// class CartScreen extends StatelessWidget {
//   final CartController cartController = Get.find<CartController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildCartHeader(),
//                       SizedBox(height: 16),
//                       _buildCartItems(),
//                       SizedBox(height: 16),
//                       _buildOrderSummary(),
//                       SizedBox(height: 24),
//                       _buildContinueButton(),
//                       SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       color: Colors.white,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () {
//                   // Handle back navigation
//                 },
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(),
//               ),
//               Text(
//                 'Cart',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '(1/2)',
//                 style: TextStyle(
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           StepperWidget(currentStep: 0),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCartHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Your Cart',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF2C3E50),
//           ),
//         ),
//         Row(
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Color(0xff900C3F),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Obx(() => Text(
//                 '${cartController.cartItems.length} items',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                 ),
//               )),
//             ),
//             SizedBox(width: 8),
//             Icon(Icons.more_vert),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCartItems() {
//     return Obx(() => Column(
//       children: cartController.cartItems.map((item) {
//         return Container(
//           margin: EdgeInsets.only(bottom: 16),
//           padding: EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF0F4C3),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Center(
//                   child: Image.network(
//                     'https://via.placeholder.com/80',
//                     width: 60,
//                     height: 60,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item.name,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF2C3E50),
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       '\$${item.price.toStringAsFixed(0)} - Size : ${item.size} - Color : ${item.color}',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF7F8C8D),
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             // Handle edit
//                           },
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.edit_outlined,
//                                 size: 16,
//                                 color: Color(0xFF7F8C8D),
//                               ),
//                               SizedBox(width: 4),
//                               Text(
//                                 'Edit',
//                                 style: TextStyle(
//                                   color: Color(0xFF7F8C8D),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 16),
//                         InkWell(
//                           onTap: () {
//                             cartController.removeItem(item.id);
//                           },
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.delete_outline,
//                                 size: 16,
//                                 color: Colors.red,
//                               ),
//                               SizedBox(width: 4),
//                               Text(
//                                 'Remove',
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     ));
//   }
//
//   Widget _buildOrderSummary() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: [
//           _buildSummaryRow('Total (${cartController.cartItems.length} items)', '\$${cartController.total.value.toStringAsFixed(0)}'),
//           SizedBox(height: 12),
//           _buildSummaryRow('Value added tax (VAT)', '\$${cartController.vat.value.toStringAsFixed(2)}'),
//           SizedBox(height: 12),
//           _buildSummaryRow('Delivery Charge', 'Free', valueColor: Color(0xFF4DB6AC)),
//           SizedBox(height: 12),
//           _buildSummaryRow('Discount', '-3%', valueColor: Color(0xFF4DB6AC)),
//           SizedBox(height: 16),
//           Divider(),
//           SizedBox(height: 16),
//           _buildSummaryRow('Subtotal', '\$${cartController.subtotal.value.toStringAsFixed(2)}', isBold: true),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSummaryRow(String label, String value, {Color? valueColor, bool isBold = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             color: Color(0xFF2C3E50),
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             color: valueColor ?? Color(0xFF2C3E50),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContinueButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           cartController.nextStep();
//           Get.to(() => AddressScreen());
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xff900C3F),
//           padding: EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: Text(
//           'Continue',
//           style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.white
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AddressScreen extends StatelessWidget {
//   final CartController cartController = Get.find<CartController>();
//   final AddressController addressController = Get.find<AddressController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildAddressHeader(),
//                       SizedBox(height: 16),
//                       _buildAddressList(),
//                       SizedBox(height: 24),
//                       _buildContinueButton(),
//                       SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       color: Colors.white,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () {
//                   Get.back();
//                 },
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(),
//               ),
//               Text(
//                 'Address',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '(2/1)',
//                 style: TextStyle(
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           StepperWidget(currentStep: 1),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAddressHeader() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Color(0xffffedfe).withOpacity(0.8),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Select Your Address',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF2C3E50),
//             ),
//           ),
//           ElevatedButton.icon(
//             onPressed: () {
//               // Handle add address
//             },
//             icon: Icon(Icons.add, size: 18),
//             label: Text('Add Address'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               foregroundColor: Color(0xFF2C3E50),
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAddressList() {
//     return Obx(() => Column(
//       children: addressController.addresses.map((address) {
//         return Container(
//           margin: EdgeInsets.only(bottom: 16),
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//               color: addressController.selectedAddressId.value == address.id
//                   ? Color(0xff900C3F)
//                   : Colors.transparent,
//               width: 1,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         address.type == 'Home' ? Icons.home : Icons.work,
//                         color: Color(0xFF2C3E50),
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         address.type,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF2C3E50),
//                         ),
//                       ),
//                     ],
//                   ),
//                   TextButton.icon(
//                     onPressed: () {
//                       // Handle edit address
//                     },
//                     icon: Icon(
//                       Icons.edit_outlined,
//                       size: 16,
//                       color: Color(0xff900C3F),
//                     ),
//                     label: Text(
//                       'Edit',
//                       style: TextStyle(
//                         color: Color(0xff900C3F),
//                       ),
//                     ),
//                     style: TextButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       minimumSize: Size(0, 0),
//                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 address.name,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Color(0xFF7F8C8D),
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 address.phone,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Color(0xFF7F8C8D),
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 address.address,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Color(0xFF7F8C8D),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     ));
//   }
//
//   Widget _buildContinueButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           cartController.nextStep();
//           Get.to(() => PaymentScreen());
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xff900C3F),
//           padding: EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: Text(
//           'Continue',
//           style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.white
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class PaymentScreen extends StatelessWidget {
//   final CartController cartController = Get.find<CartController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: Center(
//                 child: Text(
//                   'Payment Screen',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       color: Colors.white,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () {
//                   Get.back();
//                 },
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(),
//               ),
//               Text(
//                 'Payment',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '(3/3)',
//                 style: TextStyle(
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           StepperWidget(currentStep: 2),
//         ],
//       ),
//     );
//   }
// }
//
// // =============== MAIN APP ===============
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Initialize controllers
//     Get.put(CartController());
//     Get.put(AddressController());
//
//     return GetMaterialApp(
//       title: 'E-commerce App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Color(0xFF1A237E),
//         scaffoldBackgroundColor: Color(0xFFF0F4F7),
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           iconTheme: IconThemeData(color: Colors.black),
//           titleTextStyle: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       home: CartScreen(),
//     );
//   }
// }
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // // =============== MODELS ===============
// //
// // class CartItem {
// //   final int id;
// //   final String name;
// //   final double price;
// //   final String size;
// //   final String color;
// //   final String image;
// //
// //   CartItem({
// //     required this.id,
// //     required this.name,
// //     required this.price,
// //     required this.size,
// //     required this.color,
// //     required this.image,
// //   });
// // }
// //
// // class Address {
// //   final int id;
// //   final String type;
// //   final String name;
// //   final String phone;
// //   final String address;
// //   final bool isDefault;
// //
// //   Address({
// //     required this.id,
// //     required this.type,
// //     required this.name,
// //     required this.phone,
// //     required this.address,
// //     required this.isDefault,
// //   });
// // }
// //
// // // =============== CONTROLLERS ===============
// //
// // class CartController extends GetxController {
// //   var cartItems = <CartItem>[].obs;
// //   var subtotal = 0.0.obs;
// //   var vat = 0.0.obs;
// //   var discount = 0.0.obs;
// //   var deliveryCharge = 0.0.obs;
// //   var total = 0.0.obs;
// //   var currentStep = 0.obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     // Add sample items
// //     cartItems.add(
// //       CartItem(
// //         id: 1,
// //         name: 'T-Shirt for man',
// //         price: 60.0,
// //         size: 'L',
// //         color: 'Black',
// //         image: 'assets/images/tshirt1.png',
// //       ),
// //     );
// //     cartItems.add(
// //       CartItem(
// //         id: 2,
// //         name: 'T-Shirt for man',
// //         price: 50.0,
// //         size: 'L',
// //         color: 'Black',
// //         image: 'assets/images/tshirt2.png',
// //       ),
// //     );
// //     calculateTotal();
// //   }
// //
// //   void calculateTotal() {
// //     total.value = 0;
// //     for (var item in cartItems) {
// //       total.value += item.price;
// //     }
// //
// //     vat.value = total.value * 0.03;
// //     discount.value = total.value * 0.03;
// //     deliveryCharge.value = 0.0; // Free delivery
// //
// //     subtotal.value = total.value + vat.value - discount.value;
// //   }
// //
// //   void removeItem(int id) {
// //     cartItems.removeWhere((item) => item.id == id);
// //     calculateTotal();
// //   }
// //
// //   void nextStep() {
// //     if (currentStep.value < 2) {
// //       currentStep.value++;
// //     }
// //   }
// //
// //   void previousStep() {
// //     if (currentStep.value > 0) {
// //       currentStep.value--;
// //     }
// //   }
// // }
// //
// // class AddressController extends GetxController {
// //   var addresses = <Address>[].obs;
// //   var selectedAddressId = 0.obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     // Add sample addresses
// //     addresses.add(
// //       Address(
// //         id: 1,
// //         type: 'Home',
// //         name: 'Sunamganj',
// //         phone: '+971-50-1234567',
// //         address: 'Room #1 - Ground Floor, Al Najoun Bulding, 24 B Street, Dubai - United Arab Emirates',
// //         isDefault: true,
// //       ),
// //     );
// //     addresses.add(
// //       Address(
// //         id: 2,
// //         type: 'Work',
// //         name: 'Sylhet',
// //         phone: '+971-50-1234567',
// //         address: 'Abu Dhabi Mall - 10th St - Al Zahiyah, Abu Dhabi - United Arab Emirates',
// //         isDefault: false,
// //       ),
// //     );
// //
// //     // Set default selected address
// //     if (addresses.isNotEmpty) {
// //       selectedAddressId.value = addresses.first.id;
// //     }
// //   }
// //
// //   void selectAddress(int id) {
// //     selectedAddressId.value = id;
// //   }
// //
// //   void addAddress(Address address) {
// //     addresses.add(address);
// //   }
// //
// //   void updateAddress(Address updatedAddress) {
// //     final index = addresses.indexWhere((address) => address.id == updatedAddress.id);
// //     if (index != -1) {
// //       addresses[index] = updatedAddress;
// //     }
// //   }
// //
// //   void deleteAddress(int id) {
// //     addresses.removeWhere((address) => address.id == id);
// //     if (selectedAddressId.value == id && addresses.isNotEmpty) {
// //       selectedAddressId.value = addresses.first.id;
// //     }
// //   }
// // }
// //
// // // =============== WIDGETS ===============
// //
// // class StepperWidget extends StatelessWidget {
// //   final int currentStep;
// //
// //   StepperWidget({required this.currentStep});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       children: [
// //         _buildStepItem('Cart', 0, currentStep >= 0),
// //         _buildStepConnector(currentStep >= 1),
// //         _buildStepItem('Address', 1, currentStep >= 1),
// //         _buildStepConnector(currentStep >= 2),
// //         _buildStepItem('Payment', 2, currentStep >= 2),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildStepItem(String label, int step, bool isActive) {
// //     Color circleColor;
// //     Color textColor;
// //
// //     if (step < currentStep) {
// //       // Completed step
// //       circleColor = Color(0xFF4CAF50);
// //       textColor = Color(0xFF4CAF50);
// //     } else if (step == currentStep) {
// //       // Current step
// //       circleColor = Color(0xFF26A69A);
// //       textColor = Color(0xFF26A69A);
// //     } else {
// //       // Future step
// //       circleColor = Color(0xFF1A237E);
// //       textColor = Color(0xFF1A237E);
// //     }
// //
// //     return Expanded(
// //       child: Column(
// //         children: [
// //           Container(
// //             width: 24,
// //             height: 24,
// //             decoration: BoxDecoration(
// //               color: isActive ? circleColor : Colors.white,
// //               border: Border.all(
// //                 color: circleColor,
// //                 width: 2,
// //               ),
// //               shape: BoxShape.circle,
// //             ),
// //             child: isActive && step < currentStep
// //                 ? Icon(
// //               Icons.check,
// //               size: 14,
// //               color: Colors.white,
// //             )
// //                 : null,
// //           ),
// //           SizedBox(height: 4),
// //           Text(
// //             label,
// //             style: TextStyle(
// //               color: textColor,
// //               fontSize: 12,
// //               fontWeight: FontWeight.w500,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildStepConnector(bool isActive) {
// //     return Expanded(
// //       child: Container(
// //         height: 2,
// //         color: isActive ? Color(0xFF26A69A) : Color(0xFFE0E0E0),
// //       ),
// //     );
// //   }
// // }
// //
// // // =============== SCREENS ===============
// //
// // class CartScreen extends StatelessWidget {
// //   final CartController cartController = Get.find<CartController>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             _buildHeader(),
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       _buildCartHeader(),
// //                       SizedBox(height: 16),
// //                       _buildCartItems(),
// //                       SizedBox(height: 16),
// //                       _buildOrderSummary(),
// //                       SizedBox(height: 24),
// //                       _buildContinueButton(),
// //                       SizedBox(height: 16),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildHeader() {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       color: Colors.white,
// //       child: Column(
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               IconButton(
// //                 icon: Icon(Icons.arrow_back),
// //                 onPressed: () {
// //                   // Handle back navigation
// //                 },
// //                 padding: EdgeInsets.zero,
// //                 constraints: BoxConstraints(),
// //               ),
// //               Text(
// //                 'Cart',
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               Text(
// //                 '(1/2)',
// //                 style: TextStyle(
// //                   color: Colors.grey,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           SizedBox(height: 16),
// //           StepperWidget(currentStep: 0),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildCartHeader() {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(
// //           'Your Cart',
// //           style: TextStyle(
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //             color: Color(0xFF2C3E50),
// //           ),
// //         ),
// //         Row(
// //           children: [
// //             Container(
// //               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //               decoration: BoxDecoration(
// //                 color: Color(0xFF4DB6AC),
// //                 borderRadius: BorderRadius.circular(4),
// //               ),
// //               child: Obx(() => Text(
// //                 '${cartController.cartItems.length} items',
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 14,
// //                 ),
// //               )),
// //             ),
// //             SizedBox(width: 8),
// //             Icon(Icons.more_vert),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildCartItems() {
// //     return Obx(() => Column(
// //       children: cartController.cartItems.map((item) {
// //         return Container(
// //           margin: EdgeInsets.only(bottom: 16),
// //           padding: EdgeInsets.all(12),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Container(
// //                 width: 80,
// //                 height: 80,
// //                 decoration: BoxDecoration(
// //                   color: Color(0xFFF0F4C3),
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: Center(
// //                   child: Image.network(
// //                     'https://via.placeholder.com/80',
// //                     width: 60,
// //                     height: 60,
// //                     fit: BoxFit.contain,
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(width: 12),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       item.name,
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                         color: Color(0xFF2C3E50),
// //                       ),
// //                     ),
// //                     SizedBox(height: 4),
// //                     Text(
// //                       '\$${item.price.toStringAsFixed(0)} - Size : ${item.size} - Color : ${item.color}',
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         color: Color(0xFF7F8C8D),
// //                       ),
// //                     ),
// //                     SizedBox(height: 12),
// //                     Row(
// //                       children: [
// //                         InkWell(
// //                           onTap: () {
// //                             // Handle edit
// //                           },
// //                           child: Row(
// //                             children: [
// //                               Icon(
// //                                 Icons.edit_outlined,
// //                                 size: 16,
// //                                 color: Color(0xFF7F8C8D),
// //                               ),
// //                               SizedBox(width: 4),
// //                               Text(
// //                                 'Edit',
// //                                 style: TextStyle(
// //                                   color: Color(0xFF7F8C8D),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         SizedBox(width: 16),
// //                         InkWell(
// //                           onTap: () {
// //                             cartController.removeItem(item.id);
// //                           },
// //                           child: Row(
// //                             children: [
// //                               Icon(
// //                                 Icons.delete_outline,
// //                                 size: 16,
// //                                 color: Colors.red,
// //                               ),
// //                               SizedBox(width: 4),
// //                               Text(
// //                                 'Remove',
// //                                 style: TextStyle(
// //                                   color: Colors.red,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       }).toList(),
// //     ));
// //   }
// //
// //   Widget _buildOrderSummary() {
// //     return Container(
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Column(
// //         children: [
// //           _buildSummaryRow('Total (${cartController.cartItems.length} items)', '\$${cartController.total.value.toStringAsFixed(0)}'),
// //           SizedBox(height: 12),
// //           _buildSummaryRow('Value added tax (VAT)', '\$${cartController.vat.value.toStringAsFixed(2)}'),
// //           SizedBox(height: 12),
// //           _buildSummaryRow('Delivery Charge', 'Free', valueColor: Color(0xFF4DB6AC)),
// //           SizedBox(height: 12),
// //           _buildSummaryRow('Discount', '-3%', valueColor: Color(0xFF4DB6AC)),
// //           SizedBox(height: 16),
// //           Divider(),
// //           SizedBox(height: 16),
// //           _buildSummaryRow('Subtotal', '\$${cartController.subtotal.value.toStringAsFixed(2)}', isBold: true),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildSummaryRow(String label, String value, {Color? valueColor, bool isBold = false}) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(
// //           label,
// //           style: TextStyle(
// //             fontSize: 14,
// //             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// //             color: Color(0xFF2C3E50),
// //           ),
// //         ),
// //         Text(
// //           value,
// //           style: TextStyle(
// //             fontSize: 14,
// //             fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// //             color: valueColor ?? Color(0xFF2C3E50),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildContinueButton() {
// //     return SizedBox(
// //       width: double.infinity,
// //       child: ElevatedButton(
// //         onPressed: () {
// //           cartController.nextStep();
// //           Get.to(() => AddressScreen());
// //         },
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: Color(0xFF1A237E),
// //           padding: EdgeInsets.symmetric(vertical: 16),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //         ),
// //         child: Text(
// //           'Continue',
// //           style: TextStyle(
// //             fontSize: 16,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class AddressScreen extends StatelessWidget {
// //   final CartController cartController = Get.find<CartController>();
// //   final AddressController addressController = Get.find<AddressController>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             _buildHeader(),
// //             Expanded(
// //               child: SingleChildScrollView(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       _buildAddressHeader(),
// //                       SizedBox(height: 16),
// //                       _buildAddressList(),
// //                       SizedBox(height: 24),
// //                       _buildContinueButton(),
// //                       SizedBox(height: 16),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildHeader() {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       color: Colors.white,
// //       child: Column(
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               IconButton(
// //                 icon: Icon(Icons.arrow_back),
// //                 onPressed: () {
// //                   Get.back();
// //                 },
// //                 padding: EdgeInsets.zero,
// //                 constraints: BoxConstraints(),
// //               ),
// //               Text(
// //                 'Address',
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               Text(
// //                 '(2/1)',
// //                 style: TextStyle(
// //                   color: Colors.grey,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           SizedBox(height: 16),
// //           StepperWidget(currentStep: 1),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildAddressHeader() {
// //     return Container(
// //       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// //       decoration: BoxDecoration(
// //         color: Color(0xFFE0F7FA),
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(
// //             'Select Your Address',
// //             style: TextStyle(
// //               fontSize: 16,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF2C3E50),
// //             ),
// //           ),
// //           ElevatedButton.icon(
// //             onPressed: () {
// //               // Handle add address
// //             },
// //             icon: Icon(Icons.add, size: 18),
// //             label: Text('Add Address'),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.white,
// //               foregroundColor: Color(0xFF2C3E50),
// //               elevation: 0,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildAddressList() {
// //     return Obx(() => Column(
// //       children: addressController.addresses.map((address) {
// //         return Container(
// //           margin: EdgeInsets.only(bottom: 16),
// //           padding: EdgeInsets.all(16),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(8),
// //             border: Border.all(
// //               color: addressController.selectedAddressId.value == address.id
// //                   ? Color(0xFF4DB6AC)
// //                   : Colors.transparent,
// //               width: 1,
// //             ),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Icon(
// //                         address.type == 'Home' ? Icons.home : Icons.work,
// //                         color: Color(0xFF2C3E50),
// //                       ),
// //                       SizedBox(width: 8),
// //                       Text(
// //                         address.type,
// //                         style: TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                           color: Color(0xFF2C3E50),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   TextButton.icon(
// //                     onPressed: () {
// //                       // Handle edit address
// //                     },
// //                     icon: Icon(
// //                       Icons.edit_outlined,
// //                       size: 16,
// //                       color: Color(0xFF4DB6AC),
// //                     ),
// //                     label: Text(
// //                       'Edit',
// //                       style: TextStyle(
// //                         color: Color(0xFF4DB6AC),
// //                       ),
// //                     ),
// //                     style: TextButton.styleFrom(
// //                       padding: EdgeInsets.zero,
// //                       minimumSize: Size(0, 0),
// //                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: 8),
// //               Text(
// //                 address.name,
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   color: Color(0xFF7F8C8D),
// //                 ),
// //               ),
// //               SizedBox(height: 4),
// //               Text(
// //                 address.phone,
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   color: Color(0xFF7F8C8D),
// //                 ),
// //               ),
// //               SizedBox(height: 8),
// //               Text(
// //                 address.address,
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   color: Color(0xFF7F8C8D),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       }).toList(),
// //     ));
// //   }
// //
// //   Widget _buildContinueButton() {
// //     return SizedBox(
// //       width: double.infinity,
// //       child: ElevatedButton(
// //         onPressed: () {
// //           cartController.nextStep();
// //           Get.to(() => PaymentScreen());
// //         },
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: Color(0xFF1A237E),
// //           padding: EdgeInsets.symmetric(vertical: 16),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //         ),
// //         child: Text(
// //           'Continue',
// //           style: TextStyle(
// //             fontSize: 16,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class PaymentScreen extends StatelessWidget {
// //   final CartController cartController = Get.find<CartController>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             _buildHeader(),
// //             Expanded(
// //               child: Center(
// //                 child: Text(
// //                   'Payment Screen',
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildHeader() {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       color: Colors.white,
// //       child: Column(
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               IconButton(
// //                 icon: Icon(Icons.arrow_back),
// //                 onPressed: () {
// //                   Get.back();
// //                 },
// //                 padding: EdgeInsets.zero,
// //                 constraints: BoxConstraints(),
// //               ),
// //               Text(
// //                 'Payment',
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               Text(
// //                 '(3/3)',
// //                 style: TextStyle(
// //                   color: Colors.grey,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           SizedBox(height: 16),
// //           StepperWidget(currentStep: 2),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // // =============== MAIN APP ===============
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     // Initialize controllers
// //     Get.put(CartController());
// //     Get.put(AddressController());
// //
// //     return GetMaterialApp(
// //       title: 'E-commerce App',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primaryColor: Color(0xFF1A237E),
// //         scaffoldBackgroundColor: Color(0xFFF0F4F7),
// //         appBarTheme: AppBarTheme(
// //           backgroundColor: Colors.white,
// //           elevation: 0,
// //           iconTheme: IconThemeData(color: Colors.black),
// //           titleTextStyle: TextStyle(
// //             color: Colors.black,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //       home: CartScreen(),
// //     );
// //   }
// // }
