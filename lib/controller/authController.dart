import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart' as dio;
import 'package:keep_app/constant/api_endpoints.dart';
import 'package:keep_app/controller/otpController.dart';
import 'package:keep_app/view/dashboard/dashboardScreen.dart';

import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';
import '../view/otp/otp_screen.dart';
import '../view/otp/registrationScreen.dart';
import 'homeController.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final phoneNumber = ''.obs;
  TextEditingController numberController = TextEditingController();
  final HomeController homeController = Get.find<HomeController>();


  final verificationId = ''.obs;
  final otp = ''.obs;
  final isOtpValid = false.obs;
  SharedHelper helper = SharedHelper();
  RxString tokenGet = "".obs;
  final isLoading = false.obs;
  String dialCode = "+91";

  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }

  void setOtp(String value) {
    otp.value = value;
    isOtpValid.value = value.length == 6; // Validate OTP length
  }

  Future<void> sendOTP(BuildContext context,String phoneNumber) async {
    try {
      isLoading.value = true; // Loader start

      if (phoneNumber.isEmpty || phoneNumber.length < 10) {
        snackBarMessengers(context,
            message: "Please enter a valid phone number.");
        return;
      }
      // Request body
      final Map<String, dynamic> body = {
        // "dial_code": "91",
        "phone": phoneNumber.toString(),
      };
      print('Request Body Phone Number : $body');

      // Dio POST call
      var response = await ApiService.post(endpoint: SendOtp, body: body);
      if (response.data['IsSuccess'] == true) {
        Get.snackbar('Success', 'OTP sent to your mobile.');
        Get.to(() => OTPVerificationScreen(phoneNumber: phoneNumber));
        isLoading.value = false;
        update();
      } else {
        Get.snackbar('Error', response.data['Message']);
      }
    } catch (e) {
      isLoading.value = false;
      print("Error in sendOtp: $e");
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

  Future<void> sendOTPPhone(BuildContext context) async {
    try {
      try {
        isLoading.value = true;

        final Map<String, dynamic> body = {
          'CustomerPhoneNo': phoneNumber.value.toString(),
        };
        print('Request Body: $body');

        var response = await ApiService.post(endpoint: login, body: body);
        isLoading.value = false;

        if (response.data['IsSuccess'] == true) {
          var data = response.data["Data"];

          if (data is List && data.isNotEmpty) {
             sendOTP(context,phoneNumber.value.toString());
             // CustomerModel customerModel = CustomerModel.fromJson(data[0]);
             // helper.setCustomer(customerModel);
             // Get.snackbar('Success', 'Login Successfully');
             // Get.offAll(() => DashboardScreen(pageIndex: 0));
             // homeController.getPrefs();
             // homeController.getDashboardData(customerModel.customerId);

          } else if (data is List && data.isEmpty) {
            Get.snackbar('Info', 'No account found. Please register.');
            Get.offAll(() => RegistrationScreen());
          } else {
            Get.snackbar('Error', 'Unexpected response received.');
          }
        } else {
          Get.snackbar('Error', response.data['Message']);
        }
      } catch (e) {
        isLoading.value = false;

        print("Error in register: $e");
        Get.snackbar('Error', 'Failed to register. Please try again.');
        throw Exception("Failed to register");
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> getToken(BuildContext context) async {
    if (phoneNumber.value.length == 10) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      isLoading.value = true;

      try {
        NotificationSettings settings = await messaging.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          print('User granted permission');
          String? token = await messaging.getToken();
          if (token != null) {
            // await submitPhoneNumber(token, context);
            print('FCM Token: $token');
          } else {
            print('Failed to get FCM token');
          }
        } else {
          print('User declined or has not accepted permission');
        }
      } catch (e) {
        print('Error getting token: $e');
        Get.snackbar('Error', 'Failed to get notification token');
      } finally {
        isLoading.value = false;
      }
    } else {
      print('Enter a valid 10-digit mobile number');
      // Get.snackbar('Error', 'Enter a valid 10-digit mobile number');
    }
  }
}

snackBarMessengers(context, {message, color, isDuration = false}) {
  ScaffoldMessenger.of(context).showSnackBar(isDuration
      ? SnackBar(
          duration: const Duration(milliseconds: 500),
          content: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: color ?? Colors.red,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                message.toString(),
                // style: appCss.dmDenseMedium16
                //     .textColor(appColor(context).whiteBg)
              )),
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          padding: EdgeInsets.zero)
      : SnackBar(
          content: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: color ?? Colors.red,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                message.toString(),
                // style: appCss.dmDenseMedium16
                //     .textColor(Colors.white)
              )),
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          padding: EdgeInsets.zero));
  /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(message.toString(),
          style: appCss.dmDenseMedium16.textColor(appColor(context).whiteBg)),
      backgroundColor: color ?? Colors.red.withOpacity(0.8)));*/
}
