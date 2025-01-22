import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/accountController.dart';

class FirebaseAuthenticate {
  FirebaseAuth authenticates = FirebaseAuth.instance;
  AccountController controller = AccountController();

  void onVerifyCode(String number) async {
    try {
      print("================= number ${number}");
      authenticates.verifyPhoneNumber(
        phoneNumber: "+91${number}",
        verificationCompleted: (phoneAuthCredential) async {
          Get.back();
        },
        verificationFailed: (error) async {
          print('Verification failed: ${error.message}');
          Fluttertoast.showToast(
              msg: "Verification failed: ${error.message}");
        },
        codeSent: (verificationId, forceResendingToken) async {
          print("$number");
          controller.verification.value = verificationId;
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
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: controller.verification.value!, smsCode: message);
    authenticates
        .signInWithCredential(authCredential)
        .then((UserCredential value) {
      if (value.user != null) {
        print(value.user);
      } else {
        Fluttertoast.showToast(msg: "Invalid OTP");
      }
    }).catchError((error) {
      log(error.toString());
      Fluttertoast.showToast(msg: "$error Something went wrong");
    });
    // authenticates.signInWithCredential(authCredential).then((value) {
    //   if(value.user != null)
    //     {
    //       print(value.user);
    //     }
    //   else
    //     {
    //       Fluttertoast.showToast(msg: "Invalid OTP");
    //     }
    //
    // },).catchError( );
  }
}
