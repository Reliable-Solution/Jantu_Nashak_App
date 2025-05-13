
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
