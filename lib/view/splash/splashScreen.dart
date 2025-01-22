// flutter
import 'package:flutter/material.dart';
// packages
import 'package:get/get.dart';
// utils
// constants
// controllers
// theme
// widget
import 'package:keep_app/controller/splashController.dart';
import 'package:keep_app/widget/baseRoute.dart';

class SplashScreen extends BaseRoute {
  SplashScreen() : super(r: 'SplashScreen2');

  final SplashController customerController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
      child:  ClipRect(
        child: Image.asset(
        "assets/images/logo.png",
        height: MediaQuery.sizeOf(context).height * 0.20,
    width: MediaQuery.sizeOf(context).width * 0.5,
    fit: BoxFit.fill,
    )
      // TextWiget(
      //     // title: global.appname,
      //     style: Themes.dark.textTheme.bodyMedium!.copyWith(
      //       color: COLOR.pink,
      //     )),
    )));
  }
}
