import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keep_app/constant/api_endpoints.dart';
import 'package:keep_app/view/dashboard/dashboardScreen.dart';

import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';
import '../view/otp/otp_screen.dart';
import '../view/otp/registrationScreen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final phoneNumber = ''.obs;
  final verificationId = ''.obs;
  final otp = ''.obs;
  final isOtpValid = false.obs;
  SharedHelper helper = SharedHelper();
  RxString tokenGet = "".obs;
  final isLoading = false.obs;
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
        isLoading.value = true; // 🔵 Loading Start

        final Map<String, dynamic> body = {
          'CustomerPhoneNo': phoneNumber.value.toString(),
          'CustomerFCMToken': token,
        };
        print('Request Body: $body');

        var response = await ApiService.post(endpoint: login, body: body);
        isLoading.value = false; // 🔴 Loading Complete


        if (response.data['IsSuccess'] == true) {
          var data = response.data["Data"];

          if (data is List && data.isNotEmpty) {
            // ✅ User exists, login successful
            CustomerModel customerModel = CustomerModel.fromJson(data[0]);
            helper.setCustomer(customerModel);
            Get.snackbar('Success', 'OTP sent to your mobile.');
             Get.to(() => OTPVerificationScreen(phoneNumber: phoneNumber.value));
            // Get.snackbar('Success', 'Login successful.');
            // Get.offAll(() => DashboardScreen(pageIndex: 0));
          }
          else if (data is List && data.isEmpty) {
            // ✅ User doesn't exist, redirect to registration
            Get.snackbar('Info', 'No account found. Please register.');
             Get.offAll(() => RegistrationScreen());
          }
          else {
            Get.snackbar('Error', 'Unexpected response received.');
          }
        } else {
          Get.snackbar('Error', response.data['Message']);
        }
        // if (response.data['IsSuccess'] == true) {
        //
        //   CustomerModel customerModel = CustomerModel.fromJson(response.data["Data"][0]);
        //   Get.snackbar('Success', response.data['Message']);
        //   helper.setCustomer(customerModel);
        //   Get.snackbar('Success', response.data['Message']);
        //   Get.offAll(() => DashboardScreen(pageIndex: 0));
        //
        //   // Get.offAll(() => DashboardScreen(pageIndex: 0));
        //   update();
        // } else {
        //   print("Error: ${response.data['Message']}");
        //   Get.snackbar(response.data['Message'],'Please try Sign Up');
        //
        // }
      } catch (e) {
        // Handle exceptions and network errors
        isLoading.value = false; // 🔴 Loading Complete (in case of error)

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
  // Future<void> getToken() async {
  //   if (phoneNumber.value.length == 10) {
  //     FirebaseMessaging messaging = FirebaseMessaging.instance;
  //     isLoading.value = true;  // 🔵 API call start hone se pehle loading true
  //
  //
  //     NotificationSettings settings = await messaging.requestPermission(
  //       alert: true,
  //       announcement: false,
  //       badge: true,
  //       carPlay: false,
  //       criticalAlert: false,
  //       provisional: false,
  //       sound: true,
  //     );
  //
  //     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //       print('User granted permission');
  //       String? token = await messaging.getToken();
  //       submitPhoneNumber(token!);
  //       print('FCM Token: $token');
  //
  //     } else {
  //       print('User declined or has not accepted permission');
  //     }
  //     isLoading.value = false;  // 🔴 API call complete hone ke baad loading false
  //
  //   } else {
  //     Get.snackbar('Error', 'Enter a valid 10-digit mobile number');
  //   }
  // }
// In your AuthController class, modify getToken method:

  Future<void> getToken() async {
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
            await submitPhoneNumber(token);
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
