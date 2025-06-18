  import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:keep_app/constant/api_endpoints.dart';
import 'package:keep_app/constant/app_constant.dart';
  import 'package:keep_app/models/customerModel.dart';
  import 'package:keep_app/view/dashboard/dashboardScreen.dart';
  import 'package:keep_app/controller/otpController.dart';
  import '../utils/services/api_services.dart';
  import '../utils/sharedPrefs.dart';
  import 'package:keep_app/utils/services/firebase_authenticate.dart';
  import 'package:keep_app/view/otp/otp_screen.dart';
  import 'package:sms_autofill/sms_autofill.dart';
  
  import '../view/otp/phone_auth.dart';
  
  class RegistrationController extends GetxController {
    final name = ''.obs;
    final email = ''.obs;
  
    var phoneNumber = ''.obs;
    final isNameValid = false.obs;
    final isEmailValid = false.obs;
    final isPhoneNumberValid = false.obs;
    SharedHelper helper = SharedHelper();
    FirebaseAuthenticate firebaseAuthenticate = FirebaseAuthenticate();
    var otpCode = "".obs;
    final phoneController = "".obs;
    var isLoading = false.obs;
  
    @override
    void onInit() {
      // TODO: implement onInit
      super.onInit();
      // getHintNumber();
    }
  
    /// Fetch mobile number hint with error handling
    Future<void> getHintNumber() async {
      try {
        String? phone = await SmsAutoFill().hint;
        if (phone != null) {
          phone = phone.replaceAll("+91", "").trim();
          phoneController.value = phone;
          print("============ ${phone}");
          phoneNumber.value = phone;
  
          update();
        }
      } catch (e) {
        print("Error : Failed to fetch mobile number: $e");
        // Get.snackbar("Error", "Failed to fetch mobile number: $e");
      }
    }
  
    /// Navigate to OTP Screen
    void sendOTP() {
      try {
        if (phoneNumber.value.length < 10) {
          throw "Invalid phone number";
        }
        // Get.to(OTPVerificationScreen(
        //   registerPhoneNumber: phoneNumber.value,
        // ));
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
  
    void setName(String value) {
      name.value = value;
      isNameValid.value = value.isNotEmpty && value.length >= 3;
    }
  
    void setEmail(String value) {
      email.value = value;
      isEmailValid.value =
          RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
              .hasMatch(value);
    }
  
    void setPhoneNumber(String value) {
      phoneNumber.value = value;
      isPhoneNumberValid.value = value.length == 10;
    }
  
    void submitRegistration() {
      if (isNameValid.value && isEmailValid.value && isPhoneNumberValid.value) {
        getToken();
      } else {
        Get.snackbar('Error', 'Please fill in all fields correctly.');
      }
    }
  
    void getToken() async {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      isLoading.value = true; // 🔵 API call start hone se pehle loading true
  
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
        // registerUser(context,token!);
        print('FCM Token: $token');
      } else {
        print('User declined or has not accepted permission');
      }
      isLoading.value = false; // 🔴 API call complete hone ke baad loading false
    }
  
    registerUser(BuildContext context,String token) async {
      try {
        final Map<String, dynamic> body = {
          'CustomerName': name.value.toString(),
          'CustomerEmailId': email.value.toString(),
          'CustomerPhoneNo': phoneNumber.value.toString(),
          'CustomerFCMToken': token,
          'FirmId':firmId

        };
  
        print("Request Body: $body"); // Debugging ke liye
  
        var response =
            await ApiService.post(endpoint: newAddCustomer, body: body);
        print(
            "Response Data: ${response.data}"); // Response print karna zaroori hai
            print("Response Data message: ${response.data['Message']}"); // Response print karna zaroori hai
  
        if (response.data['IsSuccess'] == true) {
          var data = response.data["Data"];
  
          if (data  is List && data.isNotEmpty) {
            CustomerModel customerModel = CustomerModel.fromJson(data[0]);
            print("Customer Name: ${customerModel.customerName}");

            helper.setCustomer(customerModel);
            Get.snackbar('Success', 'OTP sent to your mobile.');
            sendOTPPhone(context,phoneNumber.value);
             Get.to(() => OTPVerificationScreen(registerPhoneNumber: phoneNumber.value));
          }  else if (data == 0) {
            Get.snackbar('Info', 'You already have an account. Please sign in.');
            Get.offAll(() => LoginScreen());
          }
          else {
            Get.snackbar('Error', 'Registration successful, but no data received.');
          }
          // CustomerModel customerModel =
          //     CustomerModel.fromJson(response.data["Data"][0]);
          //
          // print("Customer Name: ${customerModel.customerName}");
          //
          // // Get.snackbar('Success', response.data['Message']);
          // helper.setCustomer(customerModel);
          // Get.snackbar('Success', 'OTP sent to your mobile.');
          // Get.to(() =>
          //     OTPVerificationScreen(registerPhoneNumber: phoneNumber.value));
  
          // Get.offAll(() => DashboardScreen(pageIndex: 0));
          update();
        }
        // else if (response.data['Message'] == "Customer Already Register") {
        //   Get.snackbar('Info', 'You already have an account. Please sign in.');
        //   Get.offAll(() => LoginScreen());
        // }
        else {
          Get.snackbar(response.data['Message'], 'Please try SignIn');
        }
      } catch (e) {
        print("Error in register: $e");
        Get.snackbar('Error', 'Failed to register. Please try again.');
        throw Exception("Failed to register");
      }
    }

    Future<void> sendOTPPhone(BuildContext context,String phoneNumber) async {
      try {
        isLoading.value = true; // Loader start

        if (phoneNumber.isEmpty || phoneNumber.length < 10) {
          snackBarMessengers(context,
              message: "Please enter a valid phone number.");
          return;
        }
        // Request body
        final Map<String, dynamic> body = {
          "dial_code": "91",
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

    // Future<void> verifyPhoneOtp(BuildContext context, String otp, String phoneNumber) async {
    //   try {
    //     isLoading.value = true;
    //     if (otp.length != 6) {
    //       throw "Enter a valid 6-digit OTP";
    //     }
    //     print(otp);
    //     final Map<String, dynamic> body = {
    //       'otp': otp.trim(),
    //       'phone': phoneNumber.toString(),
    //     };
    //     var response = await ApiService.post(endpoint: VerifyOtp, body: body);
    //
    //     if (response.data['IsSuccess'] == true) {
    //       print("Responces Data ${response.data}");
    //
    //       // var data = response.data["Data"];
    //       var data = response.data['Data'];
    //       var userData = data['userData'];
    //
    //       if (userData is List && userData.isNotEmpty) {
    //         Get.snackbar('Success', response.data['Message']);
    //         CustomerModel customerModel = CustomerModel.fromJson(userData[0]);
    //         helper.setCustomer(customerModel);
    //         Get.snackbar('Success', 'Login Successfully');
    //         Get.offAll(() => DashboardScreen(pageIndex: 0));
    //         homeController.getPrefs();
    //         homeController.getDashboardData(customerModel.customerId);
    //         update();
    //       }
    //       // if (data is List && data.isNotEmpty) {
    //       //   Get.snackbar('Success', response.data['Message']);
    //       //   CustomerModel customerModel = CustomerModel.fromJson(data[0]);
    //       //   helper.setCustomer(customerModel);
    //       //   if (isLoading.value) {
    //       //     Get.snackbar('Success', 'Login SuccessFully');
    //       //   } else {
    //       //     Get.snackbar('Success', 'Register SuccessFully');
    //       //   }
    //       //   Get.offAll(() => DashboardScreen(pageIndex: 0));
    //       //   isLoading.value = false;
    //       //
    //       //   update();
    //       // }
    //     } else {
    //       print(" OTP Verification Failed: ${response.data['Message']}");
    //       Get.snackbar('Error', response.data['Message'], backgroundColor: Colors.red);
    //     }
    //   } catch (e) {
    //     isLoading.value = false;
    //     print(" CATCH verifyOtp: $e");
    //     Get.snackbar('Error', 'Failed to verify OTP. Please try again.', backgroundColor: Colors.red);
    //   }
    // }

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

  }

