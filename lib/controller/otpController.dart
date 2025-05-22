// //flutter
// import 'dart:async';
// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// //packages
// import 'package:get/get.dart';
// import 'package:keep_app/controller/accountController.dart';
// import 'package:keep_app/controller/authController.dart';
// import 'package:keep_app/controller/homeController.dart';
// import 'package:keep_app/controller/registrationController.dart';
// import 'package:keep_app/utils/services/firebase_authenticate.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import '../view/dashboard/dashboardScreen.dart';
// import '../view/otp/otp_screen.dart';
// import 'networkController.dart';
//
// class OTPController extends GetxController {
//   // getxcontroller instance
//   NetworkController networkController = Get.put(NetworkController());
//   AuthController authController = AuthController();
//   RegistrationController registrationController = RegistrationController();
//   final HomeController homeController = Get.find<HomeController>();
//
//   // HomeController homeController = HomeController();
//     AccountController accountController = AccountController();
//
//   FocusNode? fFirstText;
//   FocusNode? fSecondText;
//   FocusNode? fThirdText;
//   FocusNode? fFourText;
//   FocusNode? fFiveText;
//   FocusNode? fSixText;
//   RxInt secondsRemaining = 60.obs;
//   RxBool isResendEnabled = false.obs;
//   // var secondsRemaining = 60.obs;
//   // var isResendEnabled = false.obs;
//   Timer? _timer;
//   var otpCode = "".obs;
//   final otpControllerText = "".obs;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   RxString verificationIdCont = ''.obs;
//   RxBool isLoading = false.obs;
//   RxString v = "".obs;
//
//   @override
//   void onInit() async {
//     fFirstText = FocusNode();
//     fSecondText = FocusNode();
//     fThirdText = FocusNode();
//     fFourText = FocusNode();
//     fFiveText = FocusNode();
//     fSixText = FocusNode();
//     startTimer();
//     super.onInit();
//   }
//
//   void startTimer() {
//     secondsRemaining.value = 60;
//     isResendEnabled.value = false;
//
//     _timer?.cancel();
//
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (secondsRemaining.value > 0) {
//         secondsRemaining.value--;
//       } else {
//         isResendEnabled.value = true;
//         _timer?.cancel();
//       }
//     });
//     update();
//   }
//
//   void resendOTP() {
//     if (isResendEnabled.value) {
//       startTimer(); // Restart timer when "Resend OTP" is clicked
//       print("Resending OTP via mobile...");
//       // Add API call to resend OTP here
//     }
//   }
//
//   @override
//   void dispose() {
//     fFirstText!.dispose();
//     fSecondText!.dispose();
//     fThirdText!.dispose();
//     fFourText!.dispose();
//     fFiveText!.dispose();
//     fSixText!.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   void nextFiled(String value, FocusNode focusNode) {
//     if (value.length == 1) {
//       focusNode.requestFocus();
//     }
//   }
//
//   /// Listen for OTP auto-read with try-catch
//   void listenForOTP() async {
//     try {
//       await SmsAutoFill().listenForCode();
//     } catch (e) {
//       print("Error : Failed to listen for OTP: $e");
//       // Get.snackbar("Error", "Failed to listen for OTP: $e");
//     }
//   }
//
//   // Future<void> onVerifyCode(String number) async {
//   //   try {
//   //     print("📞 Sending OTP to: +91$number");
//   //
//   //     // ✅ Reset old verificationId
//   //     verificationIdCont.value = "";
//   //     v.value = "";
//   //
//   //     await _auth.verifyPhoneNumber(
//   //       timeout: const Duration(seconds: 60),
//   //       phoneNumber: "+91$number",
//   //       verificationCompleted: (PhoneAuthCredential credential) async {
//   //         try {
//   //           await _auth.signInWithCredential(credential);
//   //           Get.offAll(() => DashboardScreen(pageIndex: 0));
//   //         } catch (e) {
//   //           log("🔴 Auto-verification failed: $e");
//   //           Fluttertoast.showToast(msg: "Auto-verification failed: $e");
//   //         }
//   //       },
//   //       verificationFailed: (FirebaseAuthException error) {
//   //         log("❌ Verification failed: ${error.message}");
//   //         Fluttertoast.showToast(msg: "Verification failed: ${error.message}");
//   //       },
//   //       codeSent: (String verificationId, int? forceResendingToken) {
//   //         verificationIdCont.value = verificationId; // ✅ Update value
//   //         v.value = verificationId;
//   //         update(); // ✅ UI update
//   //
//   //         print("✅ Verification ID Stored: ${verificationIdCont.value}");
//   //       },
//   //       codeAutoRetrievalTimeout: (String verificationId) {
//   //         verificationIdCont.value = verificationId;
//   //         log("⏳ Code auto-retrieval timeout.");
//   //       },
//   //     );
//   //   } catch (e) {
//   //     log("🔴 Error: $e");
//   //     Fluttertoast.showToast(msg: e.toString());
//   //   }
//   // }
//
//   // Future<void> onVerifyCode(String number, {bool shouldGetToken = true}) async {
//   //   try {
//   //     print("📞 Sending OTP to: +91$number");
//   //
//   //     // ✅ Reset old verificationId
//   //     verificationIdCont.value = "";
//   //     v.value = "";
//   //
//   //     // If shouldGetToken is true, get the token right after code is sent
//   //     await _auth.verifyPhoneNumber(
//   //       timeout: const Duration(seconds: 60),
//   //       phoneNumber: "+91$number",
//   //       verificationCompleted: (PhoneAuthCredential credential) async {
//   //         try {
//   //           await _auth.signInWithCredential(credential);
//   //           if (shouldGetToken) {
//   //             await Get.find<AuthController>().getToken();
//   //           }
//   //           Get.offAll(() => DashboardScreen(pageIndex: 0));
//   //         } catch (e) {
//   //           log("🔴 Auto-verification failed: $e");
//   //           Fluttertoast.showToast(msg: "Auto-verification failed: $e");
//   //         }
//   //       },
//   //       verificationFailed: (FirebaseAuthException error) {
//   //         log("❌ Verification failed: ${error.message}");
//   //         Fluttertoast.showToast(msg: "Verification failed: ${error.message}");
//   //       },
//   //       codeSent: (String verificationId, int? forceResendingToken) async {
//   //         verificationIdCont.value = verificationId; // ✅ Update value
//   //         v.value = verificationId;
//   //
//   //         // Get token after code is sent successfully
//   //         if (shouldGetToken) {
//   //           try {
//   //             await Get.find<AuthController>().getToken();
//   //           } catch (e) {
//   //             log("Error getting token: $e");
//   //           }
//   //         }
//   //
//   //         update(); // ✅ UI update
//   //         print("✅ Verification ID Stored: ${verificationIdCont.value}");
//   //
//   //         // Navigate to OTP screen after code is sent
//   //         Get.to(() => OTPVerificationScreen(
//   //           phoneNumber: number,
//   //         ));
//   //       },
//   //       codeAutoRetrievalTimeout: (String verificationId) {
//   //         verificationIdCont.value = verificationId;
//   //         log("⏳ Code auto-retrieval timeout.");
//   //       },
//   //     );
//   //   } catch (e) {
//   //     log("🔴 Error: $e");
//   //     Fluttertoast.showToast(msg: e.toString());
//   //   }
//   // }
//   Future<void> onVerifyCode(String number) async {
//     try {
//       print("📞 Sending OTP to: +91$number");
//       isLoading.value = true; // Add loading state
//
//       // Reset old verificationId
//       verificationIdCont.value = "";
//       v.value = "";
//
//       await _auth.verifyPhoneNumber(
//         timeout: const Duration(seconds: 60),
//         phoneNumber: "+91$number",
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           try {
//             await _auth.signInWithCredential(credential);
//             Get.offAll(() => DashboardScreen(pageIndex: 0));
//           } catch (e) {
//             log("🔴 Auto-verification failed: $e");
//             Fluttertoast.showToast(msg: "Auto-verification failed: $e");
//           } finally {
//             isLoading.value = false;
//           }
//         },
//         verificationFailed: (FirebaseAuthException error) {
//           log("❌ Verification failed: ${error.message}");
//           Fluttertoast.showToast(msg: "Verification failed: ${error.message}");
//           isLoading.value = false;
//         },
//         codeSent: (String verificationId, int? forceResendingToken) {
//           verificationIdCont.value = verificationId;
//           v.value = verificationId;
//           update();
//
//           // Only navigate here, after code is sent
//           Get.to(() => OTPVerificationScreen(
//             phoneNumber: number,
//           ));
//
//           isLoading.value = false;
//           print("✅ Verification ID Stored: ${verificationIdCont.value}");
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           verificationIdCont.value = verificationId;
//           log("⏳ Code auto-retrieval timeout.");
//           isLoading.value = false;
//         },
//       );
//     } catch (e) {
//       isLoading.value = false;
//       log("🔴 Error: $e");
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//   Future<void> onFormSubmitted(String otp) async {
//     print("⚡ Trying OTP Verification...");
//     await Future.delayed(Duration(seconds: 1)); // 🛠 Ensuring state is updated
//
//     print("✅ Stored verificationId: ${verificationIdCont.value}");
//
//     if (otp == "111111") {
//       log("✅ Bypassing Firebase Verification for OTP: 111111");
//
//       // Show success message
//       Get.snackbar('Success', isLoading.value ? 'Login Successfully' : 'Register Successfully');
//
//       // Navigate to Dashboard
//       homeController.getPrefs();
//       // accountController.getPrefs();
//       Get.offAll(() => DashboardScreen(pageIndex: 0));
//       return; // ⬅️ Return directly to avoid Firebase verification
//     }
//
//     if (verificationIdCont.value.isEmpty) {
//       log("❌ Error: Verification ID is empty.");
//       Fluttertoast.showToast(msg: "Verification ID missing. Please request a new OTP.");
//       return;
//     }
//
//     try {
//       log("🔢 Verifying OTP: $otp");
//
//       if (otp.length != 6) {
//         throw "Enter a valid 6-digit OTP";
//       }
//
//       AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationIdCont.value,
//         smsCode: otp,
//       );
//
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//
//       if (userCredential.user != null && otp == "111111") {
//         log("✅ Successful Login: ${userCredential.user!.uid}");
//         if (isLoading.value) {
//           Get.snackbar('Success', 'Login SuccessFully');
//           // authController.getToken();
//         }
//         else
//         {
//           Get.snackbar('Success', 'Register SuccessFully');
//
//           // registrationController.getToken();
//         }
//         Get.offAll(() => DashboardScreen(pageIndex: 0));
//       } else {
//         throw "Invalid OTP. Please try again.";
//       }
//     } catch (e) {
//       log("🔴 OTP Verification Error: $e");
//       Fluttertoast.showToast(msg: e.toString());
//       Get.snackbar("Error", e.toString());
//     }
//   }
//
//
//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }
// }
//flutter
import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//packages
import 'package:get/get.dart';
import 'package:keep_app/controller/authController.dart';
import 'package:keep_app/controller/registrationController.dart';
import 'package:keep_app/utils/services/firebase_authenticate.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../view/dashboard/dashboardScreen.dart';
import 'networkController.dart';

class OTPController extends GetxController {
  // getxcontroller instance
  NetworkController networkController = Get.put(NetworkController());
  AuthController authController = AuthController();
  RegistrationController registrationController = RegistrationController();

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

  /// Listen for OTP auto-read with try-catch
  void listenForOTP() async {
    try {
      await SmsAutoFill().listenForCode();
    } catch (e) {
      Get.snackbar("Error", "Failed to listen for OTP: $e");
    }
  }

  Future<void> onVerifyCode(String number) async {
    try {
      print("📞 Sending OTP to: +91$number");

      // ✅ Reset old verificationId
      verificationIdCont.value = "";
      v.value = "";

      await _auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: "+91$number",
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _auth.signInWithCredential(credential);
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
    print("⚡ Trying OTP Verification...");
    await Future.delayed(Duration(seconds: 1)); // 🛠 Ensuring state is updated

    print("✅ Stored verificationId: ${verificationIdCont.value}");

    if (otp == "111111") {
      log("✅ Bypassing Firebase Verification for OTP: 111111");

      // Show success message
      Get.snackbar('Success', isLoading.value ? 'Login Successfully' : 'Register Successfully');

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