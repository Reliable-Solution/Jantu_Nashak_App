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

  void resendOTP(BuildContext context,String phoneNumber) {
    if (isResendEnabled.value) {
      startTimer();
      authController.sendOTP(context,phoneNumber);
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

  // Future<void> onVerifyCode(String number, BuildContext context) async {
  //   try {
  //     // m1 = await helper.getCustomer();
  //     print(" Sending OTP to: +91$number");
  //     authController.getToken(context);
  //
  //     verificationIdCont.value = "";
  //     v.value = "";
  //
  //     _auth.verifyPhoneNumber(
  //       timeout: const Duration(seconds: 60),
  //       phoneNumber: "+91$number",
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         try {
  //           await _auth.signInWithCredential(credential);
  //           Get.offAll(() => DashboardScreen(pageIndex: 0));
  //         } catch (e) {
  //           log(" Auto-verification failed: $e");
  //           Fluttertoast.showToast(msg: "Auto-verification failed: $e");
  //         }
  //       },
  //       verificationFailed: (FirebaseAuthException error) {
  //         log(" Verification failed: ${error.message}");
  //         Fluttertoast.showToast(msg: "Verification failed: ${error.message}");
  //       },
  //       codeSent: (String verificationId, int? forceResendingToken) {
  //         Platform.isIOS ? Navigator.pop(context) : null;
  //         // Navigator.pop(context);
  //
  //         verificationIdCont.value = verificationId; //  Update value
  //         v.value = verificationId;
  //         update(); //  UI update
  //
  //         print(" Verification ID Stored: ${verificationIdCont.value}");
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         verificationIdCont.value = verificationId;
  //         log("⏳ Code auto-retrieval timeout.");
  //       },
  //     );
  //   } catch (e) {
  //     log(" Error: $e");
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  Future<void> verifyPhoneOtp(BuildContext context, String otp, String phoneNumber) async {
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
          Get.snackbar('Success', response.data['Message']);
          CustomerModel customerModel = CustomerModel.fromJson(userData[0]);
          helper.setCustomer(customerModel);
          Get.snackbar('Success', 'Login Successfully');
          Get.offAll(() => DashboardScreen(pageIndex: 0));
          homeController.getPrefs();
          homeController.getDashboardData(customerModel.customerId);
          update();
        }
        // if (data is List && data.isNotEmpty) {
        //   Get.snackbar('Success', response.data['Message']);
        //   CustomerModel customerModel = CustomerModel.fromJson(data[0]);
        //   helper.setCustomer(customerModel);
        //   if (isLoading.value) {
        //     Get.snackbar('Success', 'Login SuccessFully');
        //   } else {
        //     Get.snackbar('Success', 'Register SuccessFully');
        //   }
        //   Get.offAll(() => DashboardScreen(pageIndex: 0));
        //   isLoading.value = false;
        //
        //   update();
        // }
      } else {
        print(" OTP Verification Failed: ${response.data['Message']}");
        print(" OTP Verification Failed: ${response.data}");
        Get.snackbar('Error', response.data['Message'], backgroundColor: Colors.red);
      }
    } catch (e) {
      isLoading.value = false;
      print(" CATCH verifyOtp: $e");
      Get.snackbar('Error', 'Failed to verify OTP. Please try again.', backgroundColor: Colors.red);
    }
  }

  // Future<void> verifyPhoneOtp1(BuildContext context, String otp, String phoneNumber) async {
  //   try {
  //     isLoading.value = true; // Start loading
  //
  //     final Map<String, dynamic> body = {
  //       "otp": otp.trim(),
  //       "phone": phoneNumber.toString(),
  //     };
  //     print(" Verify OTP Body: $body");
  //
  //     var response = await Dio().post(
  //       "https://acman.reliablesolution.in/api/verifySendOtp",
  //       data: body,
  //       options: Options(
  //         headers: {
  //           "Content-Type": "application/json",
  //         },
  //       ),
  //     );
  //
  //     isLoading.value = false;
  //
  //     if (response.data['success'] == true) {
  //       print(" OTP Verified: ${response.data['message']}");
  //
  //       Get.snackbar('Success', response.data['message']);
  //
  //       Get.offAll(() => DashboardScreen(pageIndex: 0));
  //
  //       // Call login or move to next screen
  //       // login(context); // <-- Make sure `login(context)` is defined
  //     } else {
  //       print(" OTP Verification Failed: ${response.data['message']}");
  //       Get.snackbar('Error', response.data['message'], backgroundColor: Colors.red);
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     print(" CATCH verifyOtp: $e");
  //     Get.snackbar('Error', 'Failed to verify OTP. Please try again.', backgroundColor: Colors.red);
  //   }
  // }

  Future<void> onFormSubmitted(BuildContext context,String otp,String phoneNumber) async {
    m1 = await helper.getCustomer();
    print("Trying OTP Verification...");
    await Future.delayed(Duration(seconds: 1));
    //  Ensuring state is updated
    //
    // if (otp == "111111") {
    //   log(" Bypassing Firebase Verification for OTP: 111111");
    //
    //   Get.snackbar('Success', isLoading.value ? 'Login Successfully' : 'Register Successfully');
    //
    //   homeController.getPrefs();
    //   homeController.getDashboardData(m1!.customerId);
    //   Get.offAll(() => DashboardScreen(pageIndex: 0));
    //   return;
    // }
    //
    // if (verificationIdCont.value.isEmpty) {
    //   log(" Error: Verification ID is empty.");
    //   Fluttertoast.showToast(
    //       msg: "Verification ID missing. Please request a new OTP.");
    //   return;
    // }
    //
    // try {
    //   log(" Verifying OTP: $otp");

      if (otp.length != 6) {
        throw "Enter a valid 6-digit OTP";
      }
      // verifyPhoneOtp1(context, otp, phoneNumber);

      // AuthCredential credential = PhoneAuthProvider.credential(
      //   verificationId: verificationIdCont.value,
      //   smsCode: otp,
      // );
      //
      // UserCredential userCredential =
      //     await _auth.signInWithCredential(credential);
      //
      // if (userCredential.user != null && otp == "111111") {
      //   log(" Successful Login: ${userCredential.user!.uid}");
      //   if (isLoading.value) {
      //     Get.snackbar('Success', 'Login SuccessFully');
      //   } else {
      //     Get.snackbar('Success', 'Register SuccessFully');
      //   }
      //   Get.offAll(() => DashboardScreen(pageIndex: 0));
      // } else {
      //   throw "Invalid OTP. Please try again.";
      // }
    // } catch (e) {
    //   log(" OTP Verification Error: $e");
    //   Fluttertoast.showToast(msg: e.toString());
    //   Get.snackbar("Error", e.toString());
    // }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
