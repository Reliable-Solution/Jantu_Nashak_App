import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:keep_app/view/otp/phone_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constant/colorConst.dart';
import '../../controller/authController.dart';
import '../../controller/otpController.dart';
import '../../controller/registrationController.dart';
import '../../utils/services/firebase_authenticate.dart';
import '../../utils/string_res.dart';

class OTPVerificationScreen extends StatefulWidget {
  String? phoneNumber;
  String? registerPhoneNumber;
  OTPVerificationScreen(
      {super.key, this.phoneNumber, this.registerPhoneNumber});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final OTPController otpController = Get.put(OTPController());
  final AuthController authController = Get.put(AuthController());
  final RegistrationController registerController =
      Get.put(RegistrationController());
  FirebaseAuthenticate authenticate = FirebaseAuthenticate();
  final List<TextEditingController> otpFields =
      List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFEDE7F6),
      appBar: AppBar(
        title: Text(
          StringRes.enterVerificationCode,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: COLOR.appBaseColor,
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/otp.svg",
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  width: MediaQuery.sizeOf(context).width * 0.4,
                ),
                SizedBox(height: 20),
                Text(
                  StringRes.enterVerificationCode,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  StringRes.otpSentMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 20),
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  appContext: context,
                  length: 6,
                  controller: TextEditingController(),
                  onChanged: (value) {
                    if (value.length == 6) {
                      for (int i = 0; i < value.length && i < 6; i++) {
                        otpFields[i].text = value[i];
                      }
                      // otpController.verifyPhoneOtp(context, value, widget.phoneNumber ?? widget.registerPhoneNumber!);
                    }
                  },
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 45,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.blue.shade50,
                      selectedColor: COLOR.appBaseColor.withOpacity(0.8),
                      inactiveFillColor: Colors.grey.shade200,
                      inactiveColor: Colors.black26,
                      activeColor: COLOR.appBaseColor.withOpacity(0.8)),
                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StringRes.didntGetOtp),
                    SizedBox(width: 10),

                    Obx(() {
                      return otpController.isResendEnabled.value
                          ? TextButton(
                              onPressed: () {
                                otpController.resendOTP(
                                    context, widget.phoneNumber!);
                              },
                              child: Text(StringRes.sendAgain),
                            )
                          : Opacity(
                              child: Text(StringRes.sendAgain),
                              opacity: 0.4,
                            );
                    }),

                    //       : SizedBox();
                    // }),
                    // GetBuilder<OTPController>(builder: (otpController) { return otpController.isResendEnabled.value ? TextButton(
                    //   onPressed: () {
                    //
                    //     // otpController.isResendEnabled.value
                    //     //     ?
                    //     otpController.resendOTP(context,widget.phoneNumber!);
                    //         // : false;
                    //   },
                    //   // otpController.isResendEnabled.value
                    //   //     ? otpController.resendOTP(context)
                    //   //     : null,
                    //   child: Text(StringRes.sendAgain),
                    // )
                    // : Opacity(child: Text(StringRes.sendAgain),opacity: 0.4,);}),
                    Spacer(),
                    Obx(() {
                      return Text(
                        "${otpController.secondsRemaining.value}s",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    })
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    try {
                      String otp =
                          otpFields.map((field) => field.text.trim()).join();
                      if (widget.phoneNumber != null) {
                        otpController.verifyPhoneOtp(
                            context, otp, widget.phoneNumber!);
                      } else if (widget.registerPhoneNumber != null) {
                        otpController.verifyPhoneOtp(
                            context, otp, widget.registerPhoneNumber!);
                      } else {
                        Get.snackbar(
                            StringRes.error, StringRes.phoneNumberMissing);
                      }
                    } catch (e) {
                      Get.snackbar(StringRes.error, e.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: COLOR.appBaseColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text(StringRes.verifyOtp),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(LoginScreen());
                    print("Changing phone number...");
                  },
                  child: Text(StringRes.changeNumber),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
