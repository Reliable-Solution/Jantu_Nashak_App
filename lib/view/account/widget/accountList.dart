//flutter
import 'package:flutter/material.dart';
//package
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keep_app/utils/string_res.dart';
// utils
import '/utils/global.dart' as global;
//theme

import '../../../Theme/nativeTheme.dart';
import '../../../constant/colorConst.dart';
import '../../../widget/alignWidget.dart';
import '../../../widget/dividerWidgets.dart';
import '../../../widget/iconButtonWidget.dart';
import '../../../widget/textWidget.dart';

class AccountList extends StatelessWidget {
  const AccountList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: COLOR.background,
      child: Column(
        children: [
          // ListTileWidget(
          //   leading: Icon(
          //     Icons.shop,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          //   title: TextWiget(
          //     title: 'My Follwed Shops',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     Get.to(() => MyFollwedShopScreen());
          //   },
          // ),
          // DividerWidget(),
          // ListTileWidget(
          //   leading: Icon(
          //     Icons.account_balance_outlined,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          //   title: TextWiget(
          //     title: 'My Bank Details',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     Get.to(() => BankDetailScreen());
          //   },
          // ),
          // DividerWidget(),
          // ListTileWidget(
          //   leading: Icon(
          //     Icons.share_outlined,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          //   title: TextWiget(
          //     title: 'My Shared Products',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     Get.to(() => ShareProductScreen());
          //   },
          // ),
          // DividerWidget(),
          // ListTileWidget(
          //   leading: Icon(
          //     Icons.payment_outlined,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          //   title: TextWiget(
          //     title: 'My Payments',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     Get.to(() => PaymentsScreen());
          //   },
          // ),
          // DividerWidget(),
          // ListTileWidget(
          //   leading: Icon(
          //     Icons.redeem_outlined,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          //   title: TextWiget(
          //     title: 'Refer & Earn',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     Get.to(() => ReferScreen());
          //   },
          // ),
          // DividerWidget(),
          // ListTileWidget(
          //   leading: Icon(
          //     Icons.account_balance_wallet_outlined,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          //   title: TextWiget(
          //     title: '${global.appname} Credits',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     Get.to(() => MeeshoCreditsScreen());
          //   },
          // ),
          // DividerWidget(),
          // ListTileWidget(
          //   leading: Icon(
          //     Icons.shop,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          //   title: TextWiget(
          //     title: 'Become a Supplier',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     Get.to(() => SupplierSignupScreen());
          //   },
          // ),
          // DividerWidget(),
          // ListTileWidget(
          //   leading: Icon(
          //     Icons.settings_outlined,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          //   title: TextWiget(
          //     title: 'Setting',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     Get.to(() => SettingScreen());
          //   },
          // ),
          // DividerWidget(),
          // ListTileWidget(
          //   leading: Icon(
          //     Icons.shop,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          //   title: TextWiget(
          //     title: 'Notification Setting',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     Get.to(() => NotificationScreen());
          //   },
          // ),
          // DividerWidget(),
          // ListTileWidget(
          //   leading: Icon(
          //     Icons.star_border_outlined,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          //   title: TextWiget(
          //     title: 'Rate ${global.appname}',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     openBottomRate(context);
          //   },
          // ),
          // DividerWidget(),
          // ListTileWidget(
          //   title: TextWiget(
          //     title: 'Legal and Policies',
          //     style: Themes.light.textTheme.displayLarge,
          //   ),
          //   ontap: () {
          //     Get.to(() => PoliciesScreen());
          //   },
          //   leading: Icon(
          //     Icons.shop,
          //     color: COLOR.black,
          //     size: 22,
          //   ),
          // ),
        ],
      ),
    );
  }

  void openBottomRate(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              AlignWidget(
                alignment: Alignment.topRight,
                child: IconButtonWidget(
                  voidCallback: () {
                    Get.back();
                  },
                  icons: Icons.close,
                ),
              ),
              Column(
                children: [
                  TextWiget(
                    title: StringRes.rateUsQuestion,
                    style: Themes.dark.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  TextWiget(
                    title: StringRes.store,
                    style: Themes.dark.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Container(
                color: COLOR.background,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: FittedBox(
                  child: TextWiget(
                    title: StringRes.feedbackText,
                    style: Themes.light.textTheme.displayLarge!.copyWith(
                      color: COLOR.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Column(
                children: [
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      size: 25,
                      color: COLOR.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextWiget(
                        title: StringRes.worst,
                        style: Themes.dark.textTheme.displayMedium!.copyWith(
                          color: COLOR.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextWiget(
                          title: StringRes.best,
                          style: Themes.dark.textTheme.displayMedium!.copyWith(
                            color: COLOR.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
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
}
