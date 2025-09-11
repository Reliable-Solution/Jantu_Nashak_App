import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:keep_app/constant/imagesConst.dart';
import 'package:keep_app/controller/otpController.dart';
import 'package:keep_app/view/otp/otp_screen.dart';
import 'package:keep_app/view/otp/registrationScreen.dart';
import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../controller/authController.dart';
import '../../controller/languageController.dart';
import '../../utils/sharedPrefs.dart';
import '../../utils/string_res.dart';
import '../dashboard/dashboardScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.put(AuthController());

  final OTPController otpController = Get.put(OTPController());

  TextEditingController txtNumber = TextEditingController();

  TextEditingController txtPhoneNumber = TextEditingController();

  TextEditingController txtOtpNumber = TextEditingController();

  final AuthController authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  final LanguageController languageController = Get.find<LanguageController>();

  final RxString selectedLang = "ગુજરાતી".obs;

  @override
  void initState() {
    // TODO: implement initState
    languageController.loadLanguage();
    if (languageController.languageName.value.isEmpty) {
      selectedLang.value = "ગુજરાતી";
      languageController.changeLanguage("ગુજરાતી");
    } else {
      languageController.languageName.value == "gu"
          ? selectedLang.value = "ગુજરાતી"
          : languageController.languageName == "hi"
              ? selectedLang.value = "हिंदी"
              : selectedLang.value = "English";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.background,
      appBar: AppBar(
        title: Text(
          StringRes.signIn,
          style:
              TextStyle(color: COLOR.background, fontWeight: FontWeight.w500),
        ),
        backgroundColor: COLOR.appBaseColor,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // Auto validate on interaction
        child: ListView(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://img.freepik.com/premium-vector/refer-friend-concept-earn-referral-commission-refer-customer-reward-marketing-programs_101434-587.jpg'
                      // 'https://www.shutterstock.com/image-vector/refer-friend-affiliate-partnership-earn-260nw-1434458168.jpg'
                      ),
                  // image: AssetImage(Images.transction), // apni image lagana
                  fit: BoxFit.fill,
                ),
              ),
            ),

            // Container(
            //   height: 180,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image : NetworkImage('https://img.pikbest.com/templates/20240730/decorative-banners-for-shops-selling-agricultural-products-on-e-commerce-platforms_10688600.jpg!w700wp'),
            //       // image: AssetImage(Images.transction), // apni image lagana
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLangChip(
                              "ગુજરાતી", selectedLang.value == "ગુજરાતી", () async {
                            selectedLang.value = "ગુજરાતી";
                            languageController.changeLanguage(selectedLang.value);
                            String name = "English";
                            if (selectedLang.value == "English") {
                              name = "English";
                            } else if (selectedLang.value == "हिंदी") {
                              name = "Hindi";
                            } else if (selectedLang.value == "ગુજરાતી") {
                              name = "Gujarati";
                            }
                            print("======> Language name ${name}");
                            // String name = "English";
                            // print("==========> Language Name ${lang["name"]}");
                            print(
                                "==========> Language Name save SharedPreferences set${selectedLang.value}");
                               print( "==========> Language Name save SharedPreferences set${name}");
                            SharedHelper helper = SharedHelper();
                            helper.storeString(
                                "languageNameFinal", name);
                          String? Name =await   helper.getStoredString("languageNameFinal");
                            print("Get Name ${name} ======= Save ${Name} ");
                          }),
                          _buildLangChip("हिंदी", selectedLang.value == "हिंदी",
                              () {
                            selectedLang.value = "हिंदी";
                            print(
                                "========= Langugae name ${selectedLang.value}");
                            String name = "English";
                            if (selectedLang.value == "English") {
                              name = "English";
                            } else if (selectedLang.value == "हिंदी") {
                              name = "Hindi";
                            } else if (selectedLang.value == "ગુજરાતી") {
                              name = "Gujarati";
                            }
                            // String name = "English";
                            // print("==========> Language Name ${lang["name"]}");
                            print(
                                "==========> Language Name save SharedPreferences set${name}");
                            SharedHelper helper = SharedHelper();
                            helper.storeString("languageNameFinal", name);
                            languageController
                                .changeLanguage(selectedLang.value);
                          }),
                          // _buildLangChip("ગુજરાતી", selectedLang.value == "ગુજરાતી",
                          //     () {
                          //   selectedLang.value = "ગુજરાતી";
                          //   print("========= Langugae name ${selectedLang.value}");
                          //   languageController.changeLanguage(selectedLang.value);
                          // }),
                          _buildLangChip(
                              "English", selectedLang.value == "English", () {
                            selectedLang.value = "English";
                            String name = "English";
                            if (selectedLang.value == "English") {
                              name = "English";
                            } else if (selectedLang.value == "हिंदी") {
                              name = "Hindi";
                            } else if (selectedLang.value == "ગુજરાતી") {
                              name = "Gujarati";
                            }
                            // String name = "English";
                            // print("==========> Language Name ${lang["name"]}");
                            print(
                                "==========> Language Name save SharedPreferences set${name}");
                            SharedHelper helper = SharedHelper();
                            helper.storeString("languageNameFinal", name);
                            print(
                                "========= Langugae name ${selectedLang.value}");
                            languageController
                                .changeLanguage(selectedLang.value);
                          }),
                        ],
                      ),
                    ),
                  ),
                  //   ],
                  // ),

                  const SizedBox(height: 25),
                  // Container(
                  //   height: 190,
                  //   width: 350,
                  //   // padding: EdgeInsets.all(10),
                  //   color: Colors.red,
                  //   // decoration: BoxDecoration(
                  //   //   color: Colors.red,
                  //   //   borderRadius: BorderRadius.all(Radius.circular(10))
                  //   // ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       height: MediaQuery.sizeOf(context).height * 0.042,
                  //       width: MediaQuery.sizeOf(context).width * 0.26,
                  //       // color: Colors.black,
                  //       padding: EdgeInsets.all(10),
                  //       // margin: EdgeInsets.all(10),
                  //       // color: Colors.red,
                  //       decoration: BoxDecoration(
                  //           color: Colors.black,
                  //           borderRadius: BorderRadius.all(Radius.circular(10))
                  //       ),
                  //     ),
                  //     Container(
                  //       height: MediaQuery.sizeOf(context).height * 0.042,
                  //       width: MediaQuery.sizeOf(context).width * 0.26,
                  //       // width: MediaQuery.sizeOf(context).width * 0.25,
                  //
                  //       // height: 40,
                  //       // width: 100,
                  //       // color: Colors.black,
                  //       padding: EdgeInsets.all(10),
                  //       margin: EdgeInsets.all(10),
                  //       // color: Colors.red,
                  //       decoration: BoxDecoration(
                  //           color: Colors.black,
                  //           borderRadius: BorderRadius.all(Radius.circular(10))
                  //       ),
                  //     ),
                  //     Container(
                  //       height: MediaQuery.sizeOf(context).height * 0.042,
                  //       width: MediaQuery.sizeOf(context).width * 0.26,
                  //       // width: MediaQuery.sizeOf(context).width * 0.25,
                  //
                  //       // height: 40,
                  //       // width: 50,
                  //       // color: Colors.black,
                  //       padding: EdgeInsets.all(10),
                  //       margin: EdgeInsets.all(10),
                  //       // color: Colors.red,
                  //       decoration: BoxDecoration(
                  //           color: Colors.black,
                  //           borderRadius: BorderRadius.all(Radius.circular(10))
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Text(StringRes.enterYourPhoneNumber,
                  //     style: TextStyle(fontSize: 18)),

                  Text(
                    StringRes.login,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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
                        return StringRes.invalidPhoneNumber;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 215),
                  Center(
                    child: Obx(() => controller.isLoading.value
                        ? CircularProgressIndicator(color: COLOR.appBaseColor)
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                SharedHelper helper = SharedHelper();

                                bool? isDeleted = await helper.getStoredBool(
                                    key: SharedHelper.deleteAccountKey);
                                if (isDeleted ?? false) {
                                  Fluttertoast.showToast(
                                      msg: StringRes.accountDeleted);
                                  return;
                                }

                                if (_formKey.currentState!.validate()) {
                                  txtNumber.text = controller.phoneNumber.value;
                                  // = Get.find<AuthController>();
                                  await authController.getToken(context);
                                  await controller.sendOTPPhone(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: COLOR.appBaseColor),
                              child: Text(
                                StringRes.continueString,
                                style: Themes.light.textTheme.displaySmall!
                                    .copyWith(
                                  color: COLOR.background,
                                ),
                              ),
                            ),
                          )),
                  ),
                  SizedBox(height: 10),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: RichText(
                      text: TextSpan(
                        text: StringRes.agreeTerms,
                        style: TextStyle(
                          color: COLOR.black,
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text: StringRes.signUp,
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
          ],
        ),
      ),
    );
  }

  Widget _buildLangChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            color: isSelected ? COLOR.appBaseColor : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade400),
            boxShadow: [BoxShadow(blurRadius: 15, spreadRadius: -10)]),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
