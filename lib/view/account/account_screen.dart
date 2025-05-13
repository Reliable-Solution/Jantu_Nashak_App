import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/utils/sharedPrefs.dart';
import 'package:keep_app/view/account/editProfile.dart';
import 'package:keep_app/view/account/primary.dart';
import 'package:keep_app/view/account/profile_screen.dart';
import 'package:keep_app/view/account/widget/accountList.dart';
import 'package:keep_app/view/address/pickupAddressScreen.dart';
import 'package:keep_app/view/order/orderScreen.dart';
import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../controller/accountController.dart';
import '../../utils/services/firebase_authenticate.dart';
import '../../utils/services/languageServices.dart';
import '../../utils/string_res.dart';
import '../../widget/alignWidget.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/buttonWidget.dart';
import '../../widget/dividerWidgets.dart';
import '../../widget/iconButtonWidget.dart';
import '../../widget/languageWidget.dart';
import '../../widget/textWidget.dart';
import '../address/allAddress_screen.dart';
import '../otp/OTPVerificationForm.dart';
import '../otp/phone_auth.dart';
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

  // ProductDetailsController productDetailsController = Get.find();
  final HomeController _controller = Get.find();
  String? fcmToken;

  @override
  Widget build(BuildContext context) {
    print(" name ${_controller.customerModel!.value.customerName}");
    return Scaffold(
      backgroundColor: COLOR.greyLight,
      appBar: MyCustomAppBar(
        actionPadding: 10,
        height: 90,
        appbarPadding: 0,
        title: TextWiget(
          title: StringRes.account,
          style: Themes.light.textTheme.displayLarge,
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // ElevatedButton(
            //     onPressed: () {
            //       Get.to(PickupAddressScreen());
            //     },
            //     child: Text(StringRes.address)),
            //  DividerWidget(thickness: 4,height: 2,),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Container(
                color: COLOR.background,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         Text( _controller.customerModel != null
                             ? "${StringRes.hello} ${_controller.customerModel!.value.customerName}"
                             : "${StringRes.hello}",),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: TextWiget(
                                title: StringRes.viewProfile,
                                style: Themes.light.textTheme.displaySmall),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AlignWidget(
                        alignment: Alignment.centerRight,
                        child: IconButtonWidget(
                          voidCallback: () {
                             Get.to(() => EditProfileScreen());
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
              padding: EdgeInsets.only(top: 06),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.14,
                color: COLOR.background,
                // margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    changeLanguageButton(() {
                      showLanguageBottomSheet(context);

                    },),
                    buildAddAddressButton(
                      onTap: () {
                        Get.to(() => AllAddressScreen());
                        print("Add Address Clicked!");
                        // Navigate to Add Address Screen
                      },
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 04),
              child: InkWell(
                onTap: () {
                  _showLogoutBottomSheet(context);
                },
                child: Container(
                   height: MediaQuery.of(context).size.height * 0.06,
                  color: COLOR.background,
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Logout ",style: Themes.light.textTheme.displayLarge!,),
                      Icon(Icons.logout),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 04),
              child: InkWell(
                onTap: () {
                  Get.to(Orderscreen());
                },
                child: Container(
                   height: MediaQuery.of(context).size.height * 0.06,
                  color: COLOR.background,
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Orders",style: Themes.light.textTheme.displayLarge!,),
                      Icon(Icons.shopping_bag),
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: InkWell(
            //     onTap: () {
            //       _showLogoutBottomSheet(context);
            //
            //     },
            //     child: Container(
            //       color: COLOR.background,
            //
            //       width: MediaQuery.sizeOf(context).width,
            //       child: Row(
            //         children: [
            //           Text("Logout "),
            //           Icon(Icons.logout),
            //         ],
            //       ),
            //     ),
            //   ),
            // )
            
            // ElevatedButton(
            //   onPressed: () {
            //     showLanguageBottomSheet(context);
            //   },
            //   child: Text("Change Language"),
            // ),
          ],
        ),)
      );
  }

  Widget buildAddAddressButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 35),
    decoration: BoxDecoration(
    color: Colors.grey.shade50,
    border: Border.all(color: Colors.grey,width: 0.5),
    borderRadius: BorderRadius.circular(12),),
        // padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(10),
        //   border: Border.all(color: Colors.grey.shade300),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.shade200,
        //       blurRadius: 5,
        //       spreadRadius: 2,
        //       offset: Offset(0, 3),
        //     ),
        //   ],
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on, color: Color(0xff900C3F), size: 30),
            SizedBox(height: 5),
            Text(
              "Add Address",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget changeLanguageButton(VoidCallback onTap) {
    return Material(
      color: Colors.transparent, // Transparent background for ripple effect
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12), // Ripple effect ke liye
        splashColor: COLOR.appBaseColor.withOpacity(0.2), // Ripple ka color
        highlightColor: COLOR.appBaseColor.withOpacity(0.1), // Button press effect
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border.all(color: Colors.grey,width: 0.5),
            borderRadius: BorderRadius.circular(12),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black12,
            //     blurRadius: 4,
            //     offset: Offset(0, 2),
            //   ),
            // ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.language, size: 30, color: COLOR.appBaseColor),
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                         color:  COLOR.appBaseColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "अ",
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 2),
                          Text(
                            "A",
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "Change Language",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )));
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
                title: "",
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
                      decoration: InputDecoration(
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
                  color: COLOR.appBaseColor,
                  style: Themes.light.textTheme.displaySmall!
                      .copyWith(color: COLOR.background),
                  title: StringRes.otp,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWiget(
                    title: "${StringRes.continuingAgree} ${global.appname}",
                    style: Themes.dark.textTheme.displayLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWiget(
                        title: StringRes.termsConditions,
                        style: Themes.dark.textTheme.displayLarge!
                            .copyWith(color: COLOR.appBaseColor),
                      ),
                      TextWiget(
                        title: StringRes.and,
                        style: Themes.dark.textTheme.displayLarge,
                      ),
                      TextWiget(
                        title: StringRes.privacyPolicy,
                        style: Themes.dark.textTheme.displayLarge!
                            .copyWith(color: COLOR.appBaseColor),
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
  void _showLogoutBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure you want to logout?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black),
                  ),
                  onPressed: () => Get.back(),
                  child: Text("Cancel", style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    SharedHelper helper = SharedHelper();
helper.deleteCustomer();
                    Get.offAll(() => LoginScreen());
                    // Logout logic here
                    Get.back();
                  },
                  child: Text("Logout", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
      enterBottomSheetDuration: Duration(milliseconds: 300),
      exitBottomSheetDuration: Duration(milliseconds: 300),
    );
  }
  // void _showLogoutBottomSheet(BuildContext context) {
  //   Get.bottomSheet(
  //     Container(
  //       padding: const EdgeInsets.all(16.0),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //       ),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             "Are you sure you want to logout?",
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
  //           ),
  //           const SizedBox(height: 20),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               TextButton(
  //                 onPressed: () => Get.back(),
  //                 child: Text("Cancel", style: TextStyle(fontSize: 16)),
  //               ),
  //               ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.purple,
  //                 ),
  //                 onPressed: () {
  //                   // Logout logic here
  //                   Get.back();
  //                 },
  //                 child: Text("Logout", style: TextStyle(fontSize: 16)),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //     isDismissible: true,
  //     enableDrag: true,
  //     enterBottomSheetDuration: Duration(milliseconds: 300),
  //     exitBottomSheetDuration: Duration(milliseconds: 300),
  //   );
  // }

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
                  title: StringRes.changeNumber,
                  style: Themes.light.textTheme.displaySmall!
                      .copyWith(color: COLOR.black),
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
                  title: StringRes.enterOtp,
                  style: Themes.dark.textTheme.headlineMedium,
                ),
              ),
            ),
            AlignWidget(
              alignment: Alignment.centerLeft,
              child: TextWiget(
                title: StringRes.changeNumber,
                style: Themes.light.textTheme.displaySmall!.copyWith(
                  color: COLOR.appBaseColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: OTPVerificationForm(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextWiget(
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
                    color: COLOR.appBaseColor,
                    style: Themes.light.textTheme.displaySmall!
                        .copyWith(color: COLOR.background),
                    title: StringRes.verify,
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

  void onTap() {
    print("==================== token1 ${fcmToken}");
  }
}
