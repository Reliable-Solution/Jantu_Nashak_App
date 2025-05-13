import 'package:animate_do/animate_do.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/constant/imagesConst.dart';
// import '../../../../config.dart';
import '../../controller/splashController.dart';
// import 'splash_controller.dart';

class RotationAnimationLayout extends StatelessWidget {
  const RotationAnimationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final splash = Get.find<SplashController>();

    return GetBuilder<SplashController>(builder: (splash) => Roulette(
      animate: false,
      spins: 2,
      duration: const Duration(seconds: 5),
      child: AnimatedContainer(
        alignment: Alignment.center,
        height: splash.controller.isCompleted
            ? 200
            : splash.size.value,
        width: splash.controller.isCompleted
            ? 200
            : splash.size.value,
        duration: const Duration(seconds: 1),
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius:
              splash.controller.isCompleted ? 8 : 14,
              cornerSmoothing: 1,
            ),
          ),
        ),
        child: Image.asset(
        'assets/images/logo.png',
          // IMAGE.logo,
          height: MediaQuery.sizeOf(context).height * 0.8,
          width: MediaQuery.sizeOf(context).width * 0.8,
        ),
      ),
    ));
  }
}
