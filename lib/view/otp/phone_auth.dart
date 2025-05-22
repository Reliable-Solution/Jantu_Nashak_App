

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:keep_app/controller/otpController.dart';
import 'package:keep_app/view/otp/otp_screen.dart';
import 'package:keep_app/view/otp/registrationScreen.dart';
import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../controller/authController.dart';
import '../../utils/string_res.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());
  final OTPController otpController = Get.put(OTPController());
  TextEditingController txtNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // txtNumber.text = "+91";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringRes.signIn,
          style: TextStyle(color: COLOR.background,fontWeight: FontWeight.w500),
        ),
        backgroundColor: COLOR.appBaseColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction, // Auto validate on interaction
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringRes.enterYourPhoneNumber, style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              TextFormField(
                controller: txtNumber,
                decoration: InputDecoration(
                  labelText: StringRes.mobileNumber,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (phone) {
                  controller.setPhoneNumber(txtNumber.text);
                  controller.update();

                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringRes.mobileRequired;
                  }
                  if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                    return "Enter a valid 10-digit number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: Obx(() => controller.isLoading.value
                    ? CircularProgressIndicator(color: COLOR.appBaseColor)  // 🔵 Loader dikhana
                    : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      txtNumber.text = controller.phoneNumber.value;
                      otpController.onVerifyCode(txtNumber.text);
                      otpController.startTimer();
                      controller.getToken();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: COLOR.appBaseColor),
                  child: Text(
                    StringRes.continueString,
                    style: Themes.light.textTheme.displaySmall!.copyWith(
                      color: COLOR.background,
                    ),
                  ),
                )),
              ),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       if (_formKey.currentState!.validate()) {
              //         txtNumber.text = controller.phoneNumber.value;
              //         otpController.onVerifyCode(txtNumber.text);
              //         controller.getToken();
              //         Get.to(OTPVerificationScreen(
              //           phoneNumber: txtNumber.text.toString(),
              //         ));
              //         controller.update();
              //       }
              //     },
              //     style: ElevatedButton.styleFrom(
              //         backgroundColor: COLOR.appBaseColor),
              //     child: Text(
              //       StringRes.continueString,
              //       style: Themes.light.textTheme.displaySmall!.copyWith(
              //         color: COLOR.background,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: RichText(
                  text: TextSpan(
                    text:
                    'By continuing, you agree to the Terms & Conditions and Privacy Policy.',
                    style: TextStyle(
                      color: COLOR.black,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: COLOR.appBaseColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAll(() => RegistrationScreen());
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
