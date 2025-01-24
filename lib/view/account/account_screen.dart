import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keep_app/view/account/widget/accountList.dart';
import 'package:keep_app/view/home/pickupAddressScreen.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../controller/accountController.dart';
import '../../utils/services/firebase_authenticate.dart';
import '../../widget/alignWidget.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/buttonWidget.dart';
import '../../widget/iconButtonWidget.dart';
import '../../widget/textWidget.dart';
import '/utils/global.dart' as global;


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  FirebaseAuthenticate authenticate = FirebaseAuthenticate();
  TextEditingController txtNumber = TextEditingController();
  TextEditingController txtMsg = TextEditingController();
  AccountController controller = AccountController();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? fcmToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
      height: 90,
      appbarPadding: 0,
      title: TextWiget(
        title: 'ACCOUNT',
        style: Themes.light.textTheme.displayLarge,
      ),
      elevation: 1,
      // action: [
      //   IconButtonWidget(
      //     voidCallback: () {
      //       Get.to(() => ShareProductScreen());
      //     },
      //     color: COLOR.black,
      //     icons: Icons.favorite_border,
      //   ),
      //   IconButtonWidget(
      //     voidCallback: () {
      //       Get.to(() => AddToCardScreen());
      //     },
      //     color: COLOR.black,
      //     icons: Icons.shopping_cart_outlined,
      //   ),
      // ],
    ), body:SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ElevatedButton(onPressed: () {

            Get.to(PickupAddressScreen());
          }, child: Text("Address")),

          Padding(
            padding: EdgeInsets.only(top: 4),
            child: Container(
              color: COLOR.background,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 18),
                    child: CircleAvatar(
                      maxRadius: 31,
                      backgroundImage: AssetImage(Images.profileicon),
                      backgroundColor: COLOR.greyLight,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ButtonWidgets(
                        title: 'Sign Up',
                        voidCallback: () {
                          openBottomSheetSignup(context);
                        },
                        color: COLOR.pink,
                        style: Themes.light.textTheme.displayLarge!.copyWith(color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: TextWiget(title: 'View and update your profile details', style: Themes.light.textTheme.displaySmall),
                      ),
                    ],
                  ),
                  Expanded(
                    child: AlignWidget(
                      alignment: Alignment.centerRight,
                      child: IconButtonWidget(
                        voidCallback: () {
                          // Get.to(() => ProfileScreen());
                        },
                        icons: Icons.navigate_next_outlined,
                        size: 35,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: AccountList(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.14,
              color: COLOR.background,
            ),
          )
        ],
      ),
    ),);
  }
  void openBottomSheetSignup(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.55,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: AlignWidget(
                alignment: Alignment.topRight,
                child: IconButtonWidget(
                  voidCallback: () {
                    Get.back();
                  },
                  icons: Icons.close,
                ),
              ),
            ),
            AlignWidget(
              alignment: Alignment.centerLeft,
              child: TextWiget(
                title: 'Sign Up to continue',
                style: Themes.light.textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CountryCodePicker(
                    initialSelection: 'IN',
                    showCountryOnly: false,
                    barrierColor: COLOR.black,
                    textStyle: Themes.light.textTheme.displaySmall!.copyWith(color: COLOR.black),
                    backgroundColor: COLOR.background,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: COLOR.black,
                    ),
                    showOnlyCountryWhenClosed: false,
                    favorite: ['+91', 'IN '],
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      style: Themes.light.textTheme.displaySmall!.copyWith(color: COLOR.black),
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        isDense: true,
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: txtNumber,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                child: ButtonWidgets(
                  voidCallback: () {
                    openBottomSheetOTP(context);
                    authenticate.onVerifyCode(txtNumber.text);
                    onTap();
                  },
                  color: COLOR.pink,
                  style: Themes.light.textTheme.displaySmall!.copyWith(color: COLOR.background),
                  title: 'Send OTP',
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWiget(
                    title: 'By continuing, you agree to ${global.appname}\'s',
                    style: Themes.dark.textTheme.displayLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWiget(
                        title: 'Terms & Conditions ',
                        style: Themes.dark.textTheme.displayLarge!.copyWith(color: COLOR.pink),
                      ),
                      TextWiget(
                        title: 'and ',
                        style: Themes.dark.textTheme.displayLarge,
                      ),
                      TextWiget(
                        title: 'Privacy Policy ',
                        style: Themes.dark.textTheme.displayLarge!.copyWith(color: COLOR.pink),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: COLOR.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  void openBottomSheetOTP(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.55,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: IconButtonWidget(
                    voidCallback: () {},
                    icons: Icons.navigate_before,
                  ),
                ),
                TextWiget(
                  title: 'CHANGE NUMBER',
                  style: Themes.light.textTheme.displaySmall!.copyWith(color: COLOR.black),
                ),
                Expanded(
                  child: AlignWidget(
                    alignment: Alignment.topRight,
                    child: IconButtonWidget(
                      voidCallback: () {
                        Get.back();
                      },
                      icons: Icons.close,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: AlignWidget(
                alignment: Alignment.centerLeft,
                child: TextWiget(
                  title: 'Enter OTP sent to',
                  style: Themes.dark.textTheme.headlineMedium,
                ),
              ),
            ),
            AlignWidget(
              alignment: Alignment.centerLeft,
              child: TextWiget(
                title: 'CHANGE NUMBER',
                style: Themes.light.textTheme.displaySmall!.copyWith(
                  color: COLOR.pink,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              // child: OTPVerificationForm(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextWiget(
                title: 'Resend OTP in 55s',
                style: Themes.light.textTheme.headlineMedium,
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width,
                  child: ButtonWidgets(
                    voidCallback: () {
                      authenticate.onFormSubmited(controller.message.value!);
                    },
                    color: COLOR.pink,
                    style: Themes.light.textTheme.displaySmall!.copyWith(color: COLOR.background),
                    title: 'Verify',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: COLOR.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }
  void onTap()
  {
    print("==================== token1 ${fcmToken}");
  }
}
