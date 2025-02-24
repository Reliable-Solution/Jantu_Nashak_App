import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:keep_app/constant/colorConst.dart';
import 'package:keep_app/controller/registrationController.dart';
import 'package:keep_app/view/otp/phone_auth.dart';
import 'package:keep_app/view/otp/otp_screen.dart';
import '../../Theme/nativeTheme.dart';
import '../../controller/otpController.dart';
class RegistrationScreen extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());
  final OTPController otpController = Get.put(OTPController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter your details', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),

              // Name Field
              Obx(
                () => TextFormField(
                  onChanged: controller.setName,
                  autofillHints: [AutofillHints.name],
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    errorText: controller.isNameValid.value
                        ? null
                        : 'Name must be at least 3 characters',
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Email Field
              Obx(
                () => TextFormField(
                  onChanged: controller.setEmail,
                  autofillHints: [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    errorText: controller.isEmailValid.value
                        ? null
                        : 'Enter a valid email address',
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Phone Number Field
          Obx(
                () => IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              initialCountryCode: 'IN',
              onChanged: (val) => controller.phoneNumber.value = val.number,
              controller: TextEditingController()
                ..text = controller.phoneController.value,
            ),),
              SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.getToken();
                    otpController.onVerifyCode(controller.phoneNumber.value);
                    Get.to(OTPVerificationScreen(
                      registerPhoneNumber: controller.phoneNumber.value,
                    ));
                  },
                  child: Text('Register',
                      style: Themes.light.textTheme.displaySmall!
                          .copyWith(color: COLOR.background)),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.purple),
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
                        text: 'Sign In',
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAll(()=> LoginScreen());
                          },
                      ),
                    ],
                  ),
                ),
              ),
              // Text(
              //   'By continuing, you agree to the Terms & Conditions and Privacy Policy.',
              //   style: TextStyle(fontSize: 12),
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
