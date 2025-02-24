//flutter
import 'dart:async';
//packages
import 'package:get/get.dart';
//controllers
//views
import 'package:keep_app/view/otp/phone_auth.dart';
import 'package:keep_app/controller/networkController.dart';
import 'package:keep_app/models/customerModel.dart';
import 'package:keep_app/view/dashboard/dashboardScreen.dart';
import 'package:keep_app/view/otp/registrationScreen.dart';

import '../utils/sharedPrefs.dart';

class SplashController extends GetxController {
  NetworkController networkController = Get.put(NetworkController());
  SharedHelper helper = SharedHelper();

  @override
  void onInit() async {
    _init();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }


  _init() async {
    CustomerModel? customerModel = await helper.getCustomer();
    Timer(Duration(seconds: 3), () {
      Get.off(
        () =>
            // customerModel == null
                 RegistrationScreen()
      );
    });
  }
}
