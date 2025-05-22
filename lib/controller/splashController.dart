// //flutter
// import 'dart:async';
// //packages
// import 'package:get/get.dart';
// //controllers
// //views
// import 'package:keep_app/view/otp/phone_auth.dart';
// import 'package:keep_app/controller/networkController.dart';
// import 'package:keep_app/models/customerModel.dart';
// import 'package:keep_app/view/dashboard/dashboardScreen.dart';
// import 'package:keep_app/view/otp/registrationScreen.dart';
//
// import '../utils/sharedPrefs.dart';
//
// class SplashController extends GetxController {
//   NetworkController networkController = Get.put(NetworkController());
//   SharedHelper helper = SharedHelper();
//
//   @override
//   void onInit() async {
//     _init();
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//
//   _init() async {
//     CustomerModel? customerModel = await helper.getCustomer();
//     Timer(Duration(seconds: 3), () {
//       Get.off(
//         () =>
//         customerModel == null
//             ? LoginScreen()
//             : DashboardScreen(pageIndex: 0),
//             // // customerModel == null
//             //      RegistrationScreen()
//       );
//     });
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/customerModel.dart';
import '../utils/sharedPrefs.dart';
import 'networkController.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController? popUpAnimationController;
  late Animation<double>? animation2;
    NetworkController networkController = Get.put(NetworkController());
  SharedHelper helper = SharedHelper();




  RxDouble size = 50.0.obs;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    popUpAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    animation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    Future.delayed(const Duration(milliseconds: 150), onChangeSize);
  }

  void onChangeSize() {
    size.value = 200;
    popUpAnimationController?.forward();
  }

  @override
  void onClose() {
    controller.dispose();
    popUpAnimationController?.dispose();
    super.onClose();
  }
}
