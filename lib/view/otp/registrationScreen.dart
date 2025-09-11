import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:keep_app/constant/colorConst.dart';
import 'package:keep_app/controller/registrationController.dart';
import 'package:keep_app/view/otp/phone_auth.dart';
import 'package:keep_app/view/otp/otp_screen.dart';
import 'package:keep_app/widget/buttonWidget.dart';
import '../../Theme/nativeTheme.dart';
import '../../controller/otpController.dart';
import '../../utils/sharedPrefs.dart';
import '../../utils/string_res.dart';

class RegistrationScreen extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());
  final OTPController otpController = Get.put(OTPController());
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNumber = TextEditingController();
  TextEditingController txtRefer = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    txtNumber.text = "${controller.phoneNumber.value}";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringRes.register,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: COLOR.appBaseColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringRes.enterDetails, style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),

                // Name Field
                TextFormField(
                  controller: txtName,
                  onChanged: controller.setName,
                  autofillHints: [AutofillHints.name],
                  decoration: InputDecoration(
                    labelText: StringRes.name,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return StringRes.nameRequired;
                    if (value.length < 3) return StringRes.validName;
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // // Email Field
                // TextFormField(
                //   controller: txtEmail,
                //   onChanged: (value) {
                //     controller.setEmail(txtEmail.text);
                //     controller.update();
                //   },
                //   autofillHints: [AutofillHints.email],
                //   keyboardType: TextInputType.emailAddress,
                //   decoration: InputDecoration(
                //     labelText: StringRes.email,
                //     border: OutlineInputBorder(),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return StringRes.addressRequired; // 🛑 Empty email error
                //     }
                //     String emailPattern =
                //         r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                //     RegExp regex = RegExp(emailPattern);
                //     print("Email Validation: ${regex.hasMatch(value)}");
                //
                //     if (!regex.hasMatch(value)) {
                //       return StringRes.validEmail; // 🛑 Invalid email format
                //     }
                //
                //     return null; // ✅ Valid email
                //     // if (value!.isEmpty) return StringRes.addressRequired;
                //     // if (value.length < 5) return StringRes.validEmail;
                //     // return null;
                //   },
                // ),
                // SizedBox(height: 20),

                // Phone Number Field
                GetBuilder<RegistrationController>(
                  builder: (controller) => TextFormField(
                    decoration: InputDecoration(
                      labelText: StringRes.phoneNumber,
                      border: OutlineInputBorder(),
                    ),
                    controller: txtNumber,
                    onChanged: (value) {
                      controller.setPhoneNumber(txtNumber.text);
                      controller.update();
                    },
                    validator: (value) {
                      if (value!.isEmpty) return StringRes.mobileInvalid;
                      if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                        return StringRes.mobileRequired;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                GetBuilder<RegistrationController>(
                  builder: (controller) => TextFormField(
                    decoration: InputDecoration(
                      labelText: "Referral Code",
                      border: OutlineInputBorder(),
                    ),
                    controller: txtRefer,
                    onChanged: controller.setRefer,
                    // onChanged: (value) {
                    //   controller.setPhoneNumber(txtRefer.text);
                    //   controller.update();
                    // },
                    // validator: (value) {
                    //   if (value!.isEmpty) return StringRes.mobileInvalid;
                    //   // if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                    //   //   return StringRes.mobileRequired;
                    //   // }
                    //   return null;
                    // },
                  ),
                ),

                SizedBox(height: 20),

                Obx(() {
                  return controller.isLoading.value
                      ? Center(
                          child:
                              CircularProgressIndicator()) // 🟢 Loading Indicator
                      : Center(
                          child: ButtonWidgets(
                            voidCallback: () async {
                              SharedHelper helper = SharedHelper();

                              bool? isDeleted = await helper.getStoredBool(
                                  key: SharedHelper.deleteAccountKey);
                              if (isDeleted ?? false) {
                                Fluttertoast.showToast(
                                    msg: StringRes.deleteAccount);
                                return;
                              }
                              if (_formKey.currentState!.validate()) {
                                // otpController.verifyPhoneOtp(verifyPhoneOtp,txtNumber.text,);
                                otpController.startTimer();
                                controller.registerUser(context, "");

                                // controller.getToken();
                              }
                            },
                            title: StringRes.register,
                            color: COLOR.appBaseColor,
                            style: TextStyle(color: Colors.white),
                            // child: Text(StringRes.register),
                          ),
                        );
                }),

                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: RichText(
                    text: TextSpan(
                      text: StringRes.agreeTerms,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: StringRes.signIn,
                          style: TextStyle(
                              color: COLOR.appBaseColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offAll(() => LoginScreen());
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
      ),
    );
  }
}
