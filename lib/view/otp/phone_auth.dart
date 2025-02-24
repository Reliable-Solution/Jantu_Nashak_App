import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:keep_app/controller/otpController.dart';
import 'package:keep_app/view/otp/otp_screen.dart';
import 'package:keep_app/view/otp/registrationScreen.dart';
import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../controller/authController.dart';

class LoginScreen extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());
  final OTPController otpController = Get.put(OTPController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter your phone number', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                controller.setPhoneNumber(phone.number);
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {

                  // controller.onVerifyCode(controller.phoneNumber.value);
                  otpController.onVerifyCode(controller.phoneNumber.value);
                  controller.getToken();
                  Get.to(OTPVerificationScreen(phoneNumber: controller.phoneNumber.value.toString(),));
                },
                child: Text('Continue' ,
                    style: Themes.light.textTheme.displaySmall!.copyWith(color: COLOR.background)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: RichText(
                text: TextSpan(
                  text:
                  'By continuing, you agree to the Terms & Conditions and Privacy Policy.',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.offAll(()=> RegistrationScreen());
                        },
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
