import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:keep_app/view/otp/phone_auth.dart';

import '../../constant/colorConst.dart';
import '../../controller/authController.dart';
import '../../controller/otpController.dart';
import '../../controller/registrationController.dart';
import '../../utils/services/firebase_authenticate.dart';
import '../../utils/string_res.dart';


class OTPVerificationScreen extends StatefulWidget {
  String? phoneNumber;
  String? registerPhoneNumber;
  OTPVerificationScreen({super.key,this.phoneNumber,this.registerPhoneNumber});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final OTPController otpController = Get.put(OTPController());
  final AuthController authController = Get.put(AuthController());
  final RegistrationController registerController = Get.put(RegistrationController());
  FirebaseAuthenticate authenticate = FirebaseAuthenticate();
  final List<TextEditingController> otpFields =
  List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFEDE7F6),
      appBar: AppBar(
        title: Text(
         "Enter Verification Code",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                        (index) => SizedBox(
                      width: 45,
                      height: 50,
                      child: TextField(
                        controller: otpFields[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                          print("======== otp $value");
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StringRes.didntGetOtp),
                    Obx(() => TextButton(
                      onPressed: otpController.isResendEnabled.value
                          ? otpController.resendOTP
                          : null,
                      child: Text(StringRes.sendAgain),
                    )),
                    Spacer(),
                    Obx(() {
                      return Text(
                        "${otpController.secondsRemaining.value}s",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    })

                    // Obx(() => Text(" ${otpController.secondsRemaining.value}s")),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    try {
                      String otp = "${otpFields[0].text+otpFields[1].text+otpFields[2].text+otpFields[3].text+otpFields[4].text+otpFields[5].text}";
                      if(widget.phoneNumber!=null){
                        otpController.onFormSubmitted(otp);
                        otpController.isLoading.value = true;

                      }
                      else if(widget.registerPhoneNumber != null)
                      {
                        otpController.onFormSubmitted(otp);

                      }
                    } catch (e) {
                      Get.snackbar("Error", e.toString());
                    }
                    // authenticate.onFormSubmited("${otpFields[0].text+otpFields[1].text+otpFields[2].text+otpFields[3].text+otpFields[4].text+otpFields[5].text}");

                    // Add OTP verification logic here
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
