import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//packages
import 'package:get/get.dart';
import 'package:keep_app/constant/api_endpoints.dart';
import 'package:keep_app/controller/authController.dart';
import 'package:keep_app/controller/editController.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/controller/registrationController.dart';
import 'package:keep_app/utils/services/firebase_authenticate.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';
import '../view/dashboard/dashboardScreen.dart';
import 'networkController.dart';

class OTPController extends GetxController {
  NetworkController networkController = Get.put(NetworkController());
  EditProfileController editProfileController = Get.put(EditProfileController());
  AuthController authController = AuthController();
  RegistrationController registrationController = RegistrationController();
  SharedHelper helper = SharedHelper();

  final HomeController homeController = Get.find<HomeController>();

  FocusNode? fFirstText;
  FocusNode? fSecondText;
  FocusNode? fThirdText;
  FocusNode? fFourText;
  FocusNode? fFiveText;
  FocusNode? fSixText;
  RxInt secondsRemaining = 60.obs;
  RxBool isResendEnabled = false.obs;
  Timer? _timer;
  var otpCode = "".obs;
  final otpControllerText = "".obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxString verificationIdCont = ''.obs;
  RxBool isLoading = false.obs;
  RxString v = "".obs;
  CustomerModel? m1 = CustomerModel();

  @override
  void onInit() async {
    fFirstText = FocusNode();
    fSecondText = FocusNode();
    fThirdText = FocusNode();
    fFourText = FocusNode();
    fFiveText = FocusNode();
    fSixText = FocusNode();
    startTimer();
    super.onInit();
  }

  void startTimer() {
    secondsRemaining.value = 60;
    isResendEnabled.value = false;

    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isResendEnabled.value = true;
        _timer?.cancel();
      }
    });
    update();
  }

  void resendOTP(BuildContext context, String phoneNumber) {
    if (isResendEnabled.value) {
      startTimer();
      authController.sendOTP(context, phoneNumber);
      print("Resending OTP via mobile...");
    }
  }

  @override
  void dispose() {
    fFirstText!.dispose();
    fSecondText!.dispose();
    fThirdText!.dispose();
    fFourText!.dispose();
    fFiveText!.dispose();
    fSixText!.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void nextFiled(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }


  Future<void> verifyPhoneOtp(
      BuildContext context, String otp, String phoneNumber) async {
    try {
      isLoading.value = true;
      if (otp.length != 6) {
        throw "Enter a valid 6-digit OTP";
      }
      print(otp);
      final Map<String, dynamic> body = {
        'otp': otp.trim(),
        'phone': phoneNumber.toString(),
      };
      var response = await ApiService.post(endpoint: VerifyOtp, body: body);

      if (response.data['IsSuccess'] == true) {
        print("Responces Data ${response.data}");

        // var data = response.data["Data"];
        var data = response.data['Data'];
        var userData = data['userData'];

        if (userData is List && userData.isNotEmpty) {
          // Get.snackbar('Success', response.data['Message']);
          CustomerModel customerModel = CustomerModel.fromJson(userData[0]);
          helper.setCustomer(customerModel);
          editProfileController.GetProfile(customerId: customerModel.customerId!);

          print("======= Customer Data Point ${customerModel.points}");
          Get.snackbar('Success', 'Login Successfully',backgroundColor: Colors.white);
          Future.delayed(Duration(seconds: 1),() {
            Get.offAll(() => DashboardScreen(pageIndex: 0));
          },);
          // Get.offAll(() => DashboardScreen(pageIndex: 0));
          homeController.getPrefs();
          homeController.getDashboardData(customerModel.customerId);
          update();
        }
      } else {
        print(" OTP Verification Failed: ${response.data['Message']}");
        print(" OTP Verification Failed: ${response.data}");
        Get.snackbar('Error', response.data['Message'],
            backgroundColor: Colors.red);
      }
    } catch (e) {
      isLoading.value = false;
      print(" CATCH verifyOtp: $e");
      Get.snackbar('Error', 'Failed to verify OTP. Please try again.',
          backgroundColor: Colors.red);
    }
  }


  Future<void> onFormSubmitted(
      BuildContext context, String otp, String phoneNumber) async {
    m1 = await helper.getCustomer();
    print("Trying OTP Verification...");
    await Future.delayed(Duration(seconds: 1));

    if (otp.length != 6) {
      throw "Enter a valid 6-digit OTP";
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
