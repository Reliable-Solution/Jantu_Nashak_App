import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keep_app/constant/api_endpoints.dart';
import 'package:keep_app/view/dashboard/dashboardScreen.dart';

import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final phoneNumber = ''.obs;
  final verificationId = ''.obs;
  final otp = ''.obs;
  final isOtpValid = false.obs;
  SharedHelper helper = SharedHelper();
  RxString tokenGet = "".obs;
  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }

  void setOtp(String value) {
    otp.value = value;
    isOtpValid.value = value.length == 6; // Validate OTP length
  }

  Future<void> submitPhoneNumber(String token) async {
    try {
      try {


        final Map<String, dynamic> body = {
          'CustomerPhoneNo': phoneNumber.value.toString(),
          'CustomerFCMToken': token,
        };
        print('Request Body: $body');

        var response = await ApiService.post(endpoint: login, body: body);




        if (response.data['IsSuccess'] == true) {

          CustomerModel customerModel = CustomerModel.fromJson(response.data["Data"][0]);
          Get.snackbar('Success', response.data['Message']);
          helper.setCustomer(customerModel);

          // Get.offAll(() => DashboardScreen(pageIndex: 0));
          update();
        } else {
          print("Error: ${response.data['Message']}");
          Get.snackbar(response.data['Message'],'Please try Sign Up');

        }
      } catch (e) {
        // Handle exceptions and network errors
        print("Error in register: $e");
        Get.snackbar('Error', 'Failed to register. Please try again.');
        throw Exception("Failed to register");
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Future<void> verifyOtp() async {
  //   if (isOtpValid.value) {
  //     try {
  //       final credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId.value,
  //         smsCode: otp.value,
  //       );
  //       await _auth.signInWithCredential(credential);
  //
  //       Get.offAll(() => DashboardScreen(pageIndex: 0),);
  //       Get.snackbar('Success', 'OTP Verified!');
  //     } catch (e) {
  //       Get.snackbar('Error', 'Invalid OTP');
  //     }
  //   } else {
  //     Get.snackbar('Error', 'Enter a valid 6-digit OTP');
  //   }
  // }
  void getToken() async {
    if (phoneNumber.value.length == 10) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

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
        submitPhoneNumber(token!);
        print('FCM Token: $token');
      } else {
        print('User declined or has not accepted permission');
      }
    } else {
      Get.snackbar('Error', 'Enter a valid 10-digit mobile number');
    }
  }
}
