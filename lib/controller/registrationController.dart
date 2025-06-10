  import 'package:firebase_messaging/firebase_messaging.dart';
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
        registerUser(token!);
        print('FCM Token: $token');
      } else {
        print('User declined or has not accepted permission');
      }
      isLoading.value = false; // 🔴 API call complete hone ke baad loading false
    }
  
    registerUser(String token) async {
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
             Get.to(() => OTPVerificationScreen(registerPhoneNumber: phoneNumber.value));
          }  else if (data == 0) {
            // ✅ Customer pehle se registered hai
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
  }
