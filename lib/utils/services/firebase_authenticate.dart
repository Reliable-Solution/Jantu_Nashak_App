import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../view/dashboard/dashboardScreen.dart';
import '../../controller/accountController.dart';

class FirebaseAuthenticate {
  FirebaseAuth authenticates = FirebaseAuth.instance;
  AccountController controller = AccountController();
  String verification = "";
  void onVerifyCode(String number) async {
    try {
      if (number.length != 10) {
        throw "Enter a valid 10-digit phone number";
      }
      print("====== phone number $number");
      authenticates.verifyPhoneNumber(
        timeout:  Duration(seconds: 60),
        phoneNumber: "+91${number}",
        verificationCompleted: (phoneAuthCredential) async {
          await authenticates.signInWithCredential(phoneAuthCredential);
          Get.back();
        },
        verificationFailed: (error) async {
          print('Verification failed: ${error.message}');
          Fluttertoast.showToast(
              msg: "Verification failed: ${error.message}");
        },
        codeSent: (verificationId, forceResendingToken) async {
          print("$number");
          verification = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.message}");
      Fluttertoast.showToast(msg: e.message ?? "Unknown error occurred");
    } catch (error) {
      print(error.toString());
    }
  }

  void onFormSubmited(String message) {
    // message = "1111";
    try {
      if (message.length != 6) {
        throw "Enter a valid 6-digit OTP";
      }
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verification, smsCode: message);
      authenticates
          .signInWithCredential(authCredential)
          .then((UserCredential value) {
        if (value.user != null) {
          Get.offAll(() => DashboardScreen(pageIndex: 0));

          print(value.user);
        } else {
          Fluttertoast.showToast(msg: "Invalid OTP");
        }
      }).catchError((error) {
        log(error.toString());
        Fluttertoast.showToast(msg: "$error Something went wrong");
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
