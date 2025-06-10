// // //flutter
// // import 'dart:async';
// // import 'dart:developer';
// //
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// //
// // //packages
// // import 'package:get/get.dart';
// // import 'package:keep_app/controller/accountController.dart';
// // import 'package:keep_app/controller/authController.dart';
// // import 'package:keep_app/controller/homeController.dart';
// // import 'package:keep_app/controller/registrationController.dart';
// // import 'package:keep_app/utils/services/firebase_authenticate.dart';
// // import 'package:sms_autofill/sms_autofill.dart';
// // import '../view/dashboard/dashboardScreen.dart';
// // import '../view/otp/otp_screen.dart';
// // import 'networkController.dart';
// //
// // class OTPController extends GetxController {
// //   // getxcontroller instance
// //   NetworkController networkController = Get.put(NetworkController());
// //   AuthController authController = AuthController();
// //   RegistrationController registrationController = RegistrationController();
// //   final HomeController homeController = Get.find<HomeController>();
// //
// //   // HomeController homeController = HomeController();
// //     AccountController accountController = AccountController();
// //
// //   FocusNode? fFirstText;
// //   FocusNode? fSecondText;
// //   FocusNode? fThirdText;
// //   FocusNode? fFourText;
// //   FocusNode? fFiveText;
// //   FocusNode? fSixText;
// //   RxInt secondsRemaining = 60.obs;
// //   RxBool isResendEnabled = false.obs;
// //   // var secondsRemaining = 60.obs;
// //   // var isResendEnabled = false.obs;
// //   Timer? _timer;
// //   var otpCode = "".obs;
// //   final otpControllerText = "".obs;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   RxString verificationIdCont = ''.obs;
// //   RxBool isLoading = false.obs;
// //   RxString v = "".obs;
// //
// //   @override
// //   void onInit() async {
// //     fFirstText = FocusNode();
// //     fSecondText = FocusNode();
// //     fThirdText = FocusNode();
// //     fFourText = FocusNode();
// //     fFiveText = FocusNode();
// //     fSixText = FocusNode();
// //     startTimer();
// //     super.onInit();
// //   }
// //
// //   void startTimer() {
// //     secondsRemaining.value = 60;
// //     isResendEnabled.value = false;
// //
// //     _timer?.cancel();
// //
// //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// //       if (secondsRemaining.value > 0) {
// //         secondsRemaining.value--;
// //       } else {
// //         isResendEnabled.value = true;
// //         _timer?.cancel();
// //       }
// //     });
// //     update();
// //   }
// //
// //   void resendOTP() {
// //     if (isResendEnabled.value) {
// //       startTimer(); // Restart timer when "Resend OTP" is clicked
// //       print("Resending OTP via mobile...");
// //       // Add API call to resend OTP here
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     fFirstText!.dispose();
// //     fSecondText!.dispose();
// //     fThirdText!.dispose();
// //     fFourText!.dispose();
// //     fFiveText!.dispose();
// //     fSixText!.dispose();
// //     _timer?.cancel();
// //     super.dispose();
// //   }
// //
// //   void nextFiled(String value, FocusNode focusNode) {
// //     if (value.length == 1) {
// //       focusNode.requestFocus();
// //     }
// //   }
// //
// //   /// Listen for OTP auto-read with try-catch
// //   void listenForOTP() async {
// //     try {
// //       await SmsAutoFill().listenForCode();
// //     } catch (e) {
// //       print("Error : Failed to listen for OTP: $e");
// //       // Get.snackbar("Error", "Failed to listen for OTP: $e");
// //     }
// //   }
// //
// //   // Future<void> onVerifyCode(String number) async {
// //   //   try {
// //   //     print("📞 Sending OTP to: +91$number");
// //   //
// //   //     // ✅ Reset old verificationId
// //   //     verificationIdCont.value = "";
// //   //     v.value = "";
// //   //
// //   //     await _auth.verifyPhoneNumber(
// //   //       timeout: const Duration(seconds: 60),
// //   //       phoneNumber: "+91$number",
// //   //       verificationCompleted: (PhoneAuthCredential credential) async {
// //   //         try {
// //   //           await _auth.signInWithCredential(credential);
// //   //           Get.offAll(() => DashboardScreen(pageIndex: 0));
// //   //         } catch (e) {
// //   //           log("🔴 Auto-verification failed: $e");
// //   //           Fluttertoast.showToast(msg: "Auto-verification failed: $e");
// //   //         }
// //   //       },
// //   //       verificationFailed: (FirebaseAuthException error) {
// //   //         log("❌ Verification failed: ${error.message}");
// //   //         Fluttertoast.showToast(msg: "Verification failed: ${error.message}");
// //   //       },
// //   //       codeSent: (String verificationId, int? forceResendingToken) {
// //   //         verificationIdCont.value = verificationId; // ✅ Update value
// //   //         v.value = verificationId;
// //   //         update(); // ✅ UI update
// //   //
// //   //         print("✅ Verification ID Stored: ${verificationIdCont.value}");
// //   //       },
// //   //       codeAutoRetrievalTimeout: (String verificationId) {
// //   //         verificationIdCont.value = verificationId;
// //   //         log("⏳ Code auto-retrieval timeout.");
// //   //       },
// //   //     );
// //   //   } catch (e) {
// //   //     log("🔴 Error: $e");
// //   //     Fluttertoast.showToast(msg: e.toString());
// //   //   }
// //   // }
// //
// //   // Future<void> onVerifyCode(String number, {bool shouldGetToken = true}) async {
// //   //   try {
// //   //     print("📞 Sending OTP to: +91$number");
// //   //
// //   //     // ✅ Reset old verificationId
// //   //     verificationIdCont.value = "";
// //   //     v.value = "";
// //   //
// //   //     // If shouldGetToken is true, get the token right after code is sent
// //   //     await _auth.verifyPhoneNumber(
// //   //       timeout: const Duration(seconds: 60),
// //   //       phoneNumber: "+91$number",
// //   //       verificationCompleted: (PhoneAuthCredential credential) async {
// //   //         try {
// //   //           await _auth.signInWithCredential(credential);
// //   //           if (shouldGetToken) {
// //   //             await Get.find<AuthController>().getToken();
// //   //           }
// //   //           Get.offAll(() => DashboardScreen(pageIndex: 0));
// //   //         } catch (e) {
// //   //           log("🔴 Auto-verification failed: $e");
// //   //           Fluttertoast.showToast(msg: "Auto-verification failed: $e");
// //   //         }
// //   //       },
// //   //       verificationFailed: (FirebaseAuthException error) {
// //   //         log("❌ Verification failed: ${error.message}");
// //   //         Fluttertoast.showToast(msg: "Verification failed: ${error.message}");
// //   //       },
// //   //       codeSent: (String verificationId, int? forceResendingToken) async {
// //   //         verificationIdCont.value = verificationId; // ✅ Update value
// //   //         v.value = verificationId;
// //   //
// //   //         // Get token after code is sent successfully
// //   //         if (shouldGetToken) {
// //   //           try {
// //   //             await Get.find<AuthController>().getToken();
// //   //           } catch (e) {
// //   //             log("Error getting token: $e");
// //   //           }
// //   //         }
// //   //
// //   //         update(); // ✅ UI update
// //   //         print("✅ Verification ID Stored: ${verificationIdCont.value}");
// //   //
// //   //         // Navigate to OTP screen after code is sent
// //   //         Get.to(() => OTPVerificationScreen(
// //   //           phoneNumber: number,
// //   //         ));
// //   //       },
// //   //       codeAutoRetrievalTimeout: (String verificationId) {
// //   //         verificationIdCont.value = verificationId;
// //   //         log("⏳ Code auto-retrieval timeout.");
// //   //       },
// //   //     );
// //   //   } catch (e) {
// //   //     log("🔴 Error: $e");
// //   //     Fluttertoast.showToast(msg: e.toString());
// //   //   }
// //   // }
// //   Future<void> onVerifyCode(String number) async {
// //     try {
// //       print("📞 Sending OTP to: +91$number");
// //       isLoading.value = true; // Add loading state
// //
// //       // Reset old verificationId
// //       verificationIdCont.value = "";
// //       v.value = "";
// //
// //       await _auth.verifyPhoneNumber(
// //         timeout: const Duration(seconds: 60),
// //         phoneNumber: "+91$number",
// //         verificationCompleted: (PhoneAuthCredential credential) async {
// //           try {
// //             await _auth.signInWithCredential(credential);
// //             Get.offAll(() => DashboardScreen(pageIndex: 0));
// //           } catch (e) {
// //             log("🔴 Auto-verification failed: $e");
// //             Fluttertoast.showToast(msg: "Auto-verification failed: $e");
// //           } finally {
// //             isLoading.value = false;
// //           }
// //         },
// //         verificationFailed: (FirebaseAuthException error) {
// //           log("❌ Verification failed: ${error.message}");
// //           Fluttertoast.showToast(msg: "Verification failed: ${error.message}");
// //           isLoading.value = false;
// //         },
// //         codeSent: (String verificationId, int? forceResendingToken) {
// //           verificationIdCont.value = verificationId;
// //           v.value = verificationId;
// //           update();
// //
// //           // Only navigate here, after code is sent
// //           Get.to(() => OTPVerificationScreen(
// //             phoneNumber: number,
// //           ));
// //
// //           isLoading.value = false;
// //           print("✅ Verification ID Stored: ${verificationIdCont.value}");
// //         },
// //         codeAutoRetrievalTimeout: (String verificationId) {
// //           verificationIdCont.value = verificationId;
// //           log("⏳ Code auto-retrieval timeout.");
// //           isLoading.value = false;
// //         },
// //       );
// //     } catch (e) {
// //       isLoading.value = false;
// //       log("🔴 Error: $e");
// //       Fluttertoast.showToast(msg: e.toString());
// //     }
// //   }
// //   Future<void> onFormSubmitted(String otp) async {
// //     print("⚡ Trying OTP Verification...");
// //     await Future.delayed(Duration(seconds: 1)); // 🛠 Ensuring state is updated
// //
// //     print("✅ Stored verificationId: ${verificationIdCont.value}");
// //
// //     if (otp == "111111") {
// //       log("✅ Bypassing Firebase Verification for OTP: 111111");
// //
// //       // Show success message
// //       Get.snackbar('Success', isLoading.value ? 'Login Successfully' : 'Register Successfully');
// //
// //       // Navigate to Dashboard
// //       homeController.getPrefs();
// //       // accountController.getPrefs();
// //       Get.offAll(() => DashboardScreen(pageIndex: 0));
// //       return; // ⬅️ Return directly to avoid Firebase verification
// //     }
// //
// //     if (verificationIdCont.value.isEmpty) {
// //       log("❌ Error: Verification ID is empty.");
// //       Fluttertoast.showToast(msg: "Verification ID missing. Please request a new OTP.");
// //       return;
// //     }
// //
// //     try {
// //       log("🔢 Verifying OTP: $otp");
// //
// //       if (otp.length != 6) {
// //         throw "Enter a valid 6-digit OTP";
// //       }
// //
// //       AuthCredential credential = PhoneAuthProvider.credential(
// //         verificationId: verificationIdCont.value,
// //         smsCode: otp,
// //       );
// //
// //       UserCredential userCredential = await _auth.signInWithCredential(credential);
// //
// //       if (userCredential.user != null && otp == "111111") {
// //         log("✅ Successful Login: ${userCredential.user!.uid}");
// //         if (isLoading.value) {
// //           Get.snackbar('Success', 'Login SuccessFully');
// //           // authController.getToken();
// //         }
// //         else
// //         {
// //           Get.snackbar('Success', 'Register SuccessFully');
// //
// //           // registrationController.getToken();
// //         }
// //         Get.offAll(() => DashboardScreen(pageIndex: 0));
// //       } else {
// //         throw "Invalid OTP. Please try again.";
// //       }
// //     } catch (e) {
// //       log("🔴 OTP Verification Error: $e");
// //       Fluttertoast.showToast(msg: e.toString());
// //       Get.snackbar("Error", e.toString());
// //     }
// //   }
// //
// //
// //   @override
// //   void onClose() {
// //     _timer?.cancel();
// //     super.onClose();
// //   }
// // }
// //flutter
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//packages
import 'package:get/get.dart';
import 'package:keep_app/controller/authController.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/controller/registrationController.dart';
import 'package:keep_app/utils/services/firebase_authenticate.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../models/customerModel.dart';
import '../utils/sharedPrefs.dart';
import '../view/dashboard/dashboardScreen.dart';
import 'networkController.dart';

class OTPController extends GetxController {
  // getxcontroller instance
  NetworkController networkController = Get.put(NetworkController());
  AuthController authController = AuthController();
  RegistrationController registrationController = RegistrationController();
  // HomeController homeController = HomeController();
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
  // var secondsRemaining = 60.obs;
  // var isResendEnabled = false.obs;
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

  void resendOTP() {
    if (isResendEnabled.value) {
      startTimer(); // Restart timer when "Resend OTP" is clicked
      print("Resending OTP via mobile...");
      // Add API call to resend OTP here
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
  //
  // /// Listen for OTP auto-read with try-catch
  // void listenForOTP() async {
  //   try {
  //     await SmsAutoFill().listenForCode();
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to listen for OTP: $e");
  //   }
  // }

  Future<void> onVerifyCode(String number,BuildContext context) async {
    try {
      // m1 = await helper.getCustomer();
      print("📞 Sending OTP to: +91$number");
      authController.getToken();


      // Get.back();
      // ✅ Reset old verificationId
      verificationIdCont.value = "";
      v.value = "";

       _auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: "+91$number",
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _auth.signInWithCredential(credential);
            // homeController.getDashboardData(m1!.customerId);
            Get.offAll(() => DashboardScreen(pageIndex: 0));
          } catch (e) {
            log("🔴 Auto-verification failed: $e");
            Fluttertoast.showToast(msg: "Auto-verification failed: $e");
          }
        },
        verificationFailed: (FirebaseAuthException error) {
          log("❌ Verification failed: ${error.message}");
          Fluttertoast.showToast(msg: "Verification failed: ${error.message}");
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          Platform.isIOS ? Navigator.pop(context) : null;
           // Navigator.pop(context);

          verificationIdCont.value = verificationId; // ✅ Update value
          v.value = verificationId;
          update(); // ✅ UI update

          print("✅ Verification ID Stored: ${verificationIdCont.value}");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationIdCont.value = verificationId;
          log("⏳ Code auto-retrieval timeout.");
        },
      );
    } catch (e) {
      log("🔴 Error: $e");
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  Future<void> onFormSubmitted(String otp) async {
    m1 = await helper.getCustomer();
    print("⚡ Trying OTP Verification...");
    await Future.delayed(Duration(seconds: 1)); // 🛠 Ensuring state is updated

    print("✅ Stored verificationId: ${verificationIdCont.value}");

    if (otp == "111111") {
      log("✅ Bypassing Firebase Verification for OTP: 111111");

      // Show success message
      Get.snackbar('Success', isLoading.value ? 'Login Successfully' : 'Register Successfully');
      // Get.back();

      // homeController.getDashboardData(m1!.customerId);
      homeController.getPrefs();
homeController.getDashboardData(m1!.customerId);
      // Navigate to Dashboard
      Get.offAll(() => DashboardScreen(pageIndex: 0));
      return; // ⬅️ Return directly to avoid Firebase verification
    }

    if (verificationIdCont.value.isEmpty) {
      log("❌ Error: Verification ID is empty.");
      Fluttertoast.showToast(msg: "Verification ID missing. Please request a new OTP.");
      return;
    }

    try {
      log("🔢 Verifying OTP: $otp");

      if (otp.length != 6) {
        throw "Enter a valid 6-digit OTP";
      }

      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdCont.value,
        smsCode: otp,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null && otp == "111111") {
        log("✅ Successful Login: ${userCredential.user!.uid}");
        if (isLoading.value) {
          Get.snackbar('Success', 'Login SuccessFully');
          // authController.getToken();
        }
        else
        {
          Get.snackbar('Success', 'Register SuccessFully');

          // registrationController.getToken();
        }
        Get.offAll(() => DashboardScreen(pageIndex: 0));
      } else {
        throw "Invalid OTP. Please try again.";
      }
    } catch (e) {
      log("🔴 OTP Verification Error: $e");
      Fluttertoast.showToast(msg: e.toString());
      Get.snackbar("Error", e.toString());
    }
  }


  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
//
// class OtpVerificationService extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final RxString verificationId = "".obs;
//   final RxBool isLoading = false.obs;
//   final RxBool isVerifying = false.obs;
//
//   // Request OTP
//   Future<void> requestOtp(String phoneNumber) async {
//     try {
//       isLoading.value = true;
//       log("📞 Sending OTP to: +91$phoneNumber");
//
//       // Clear previous verification ID
//       verificationId.value = "";
//
//       await _auth.verifyPhoneNumber(
//         timeout: const Duration(seconds: 60),
//         phoneNumber: "+91$phoneNumber",
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           // This callback is mainly for Android
//           log("🟢 Auto-verification triggered");
//           await _handleCredential(credential);
//         },
//         verificationFailed: (FirebaseAuthException error) {
//           log("❌ Verification failed: ${error.message}");
//           Fluttertoast.showToast(msg: "Verification failed: ${error.message}");
//           isLoading.value = false;
//         },
//         codeSent: (String vId, int? forceResendingToken) {
//           verificationId.value = vId;
//           log("✅ Verification ID Stored: $vId");
//           isLoading.value = false;
//           update();
//         },
//         codeAutoRetrievalTimeout: (String vId) {
//           verificationId.value = vId;
//           log("⏳ Code auto-retrieval timeout");
//           isLoading.value = false;
//         },
//       );
//     } catch (e) {
//       isLoading.value = false;
//       log("🔴 Error requesting OTP: $e");
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   // Verify OTP
//   Future<void> verifyOtp(String otp, {bool isRegistration = false}) async {
//     if (isVerifying.value) {
//       log("⚠️ Verification already in progress");
//       return;
//     }
//
//     try {
//       isVerifying.value = true;
//       log("⚡ Verifying OTP: $otp");
//
//       // Test bypass code
//       if (otp == "111111") {
//         log("✅ Using test bypass code");
//         await Future.delayed(const Duration(milliseconds: 500));
//         await _navigateToDashboard(isRegistration);
//         return;
//       }
//
//       // Validate OTP format
//       if (otp.length != 6) {
//         throw "Please enter a valid 6-digit OTP";
//       }
//
//       // Validate verification ID
//       if (verificationId.value.isEmpty) {
//         throw "Verification ID missing. Please request a new OTP.";
//       }
//
//       // Create credential
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId.value,
//         smsCode: otp,
//       );
//
//       await _handleCredential(credential, isRegistration: isRegistration);
//
//     } catch (e) {
//       isVerifying.value = false;
//       log("🔴 OTP Verification Error: $e");
//       Fluttertoast.showToast(msg: e.toString());
//       Get.snackbar("Error", e.toString(),
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.withOpacity(0.8),
//           colorText: Colors.white
//       );
//     }
//   }
//
//   // Handle credential verification
//   Future<void> _handleCredential(PhoneAuthCredential credential, {bool isRegistration = false}) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//
//       if (userCredential.user != null) {
//         log("✅ Authentication successful: ${userCredential.user!.uid}");
//         await _navigateToDashboard(isRegistration);
//       } else {
//         throw "Authentication failed. Please try again.";
//       }
//     } catch (e) {
//       isVerifying.value = false;
//       log("🔴 Credential verification error: $e");
//       Fluttertoast.showToast(msg: e.toString());
//       rethrow;
//     }
//   }
//
//   // Navigation with platform-specific handling
//   Future<void> _navigateToDashboard(bool isRegistration) async {
//     final String message = isRegistration ? 'Registration Successful' : 'Login Successful';
//
//     // Show success message
//     Get.snackbar('Success', message,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.withOpacity(0.8),
//         colorText: Colors.white
//     );
//
//     // Add a small delay for iOS to ensure UI updates complete
//     await Future.delayed(const Duration(milliseconds: 300));
//
//     // Use WidgetsBinding to ensure navigation happens after the current frame
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Get.offAll(() => DashboardScreen(pageIndex: 0),
//           predicate: (route) => false,  // Clear all routes
//           transition: Transition.fadeIn  // Smoother transition
//       );
//     });
//
//     // Reset verification state after navigation is triggered
//     isVerifying.value = false;
//   }
// }
//
// // Example Dashboard Screen (placeholder)
// class DashboardScreen extends StatelessWidget {
//   final int pageIndex;
//
//   const DashboardScreen({Key? key, required this.pageIndex}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Dashboard')),
//       body: Center(child: Text('Dashboard Page $pageIndex')),
//     );
//   }
// }