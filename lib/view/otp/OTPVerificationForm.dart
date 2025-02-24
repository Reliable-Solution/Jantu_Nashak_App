//  flutter
import 'package:flutter/material.dart';
// package
import 'package:get/get.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../controller/accountController.dart';
import '../../controller/otpController.dart';
// constants

class OTPVerificationForm extends StatelessWidget {
  final OTPController _controller = Get.find<OTPController>();
  AccountController controller = AccountController();
  TextEditingController txtMsg = TextEditingController();
  OTPVerificationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final otpInputDecoration = InputDecoration(
      counterText: '',
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: COLOR.appBaseColor),
      ),
      alignLabelWithHint: true,
    );
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: 40,
            child: TextFormField(
              controller: txtMsg,
              style: Themes.dark.textTheme.bodyLarge,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              autofocus: true,
              focusNode: _controller.fFirstText,
              decoration: otpInputDecoration,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                controller.message.value = txtMsg.text;
                _controller.nextFiled(value, _controller.fSecondText!);
              },
            ),
          ),
          SizedBox(
            width: 40,
            child: TextFormField(
              style: Themes.dark.textTheme.bodyLarge,
              focusNode: _controller.fSecondText,
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.next,
              decoration: otpInputDecoration,
              onChanged: (value) {
                _controller.nextFiled(value, _controller.fThirdText!);
              },
            ),
          ),
          SizedBox(
            width: 40,
            child: TextFormField(
              style: Themes.dark.textTheme.bodyLarge,
              focusNode: _controller.fThirdText,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLength: 1,
              textAlign: TextAlign.center,
              decoration: otpInputDecoration,
              onChanged: (value) {
                _controller.nextFiled(value, _controller.fFourText!);
              },
            ),
          ),
          SizedBox(
            width: 40,
            child: TextFormField(
              style: Themes.dark.textTheme.bodyLarge,
              focusNode: _controller.fFourText,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.next,
              maxLength: 1,
              decoration: otpInputDecoration,
              onChanged: (value) {
                _controller.nextFiled(value, _controller.fFiveText!);
              },
            ),
          ),
          SizedBox(
            width: 40,
            child: TextFormField(
              style: Themes.dark.textTheme.bodyLarge,
              focusNode: _controller.fFiveText,
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.next,
              decoration: otpInputDecoration,
              onChanged: (value) {
                _controller.nextFiled(value, _controller.fSixText!);
              },
            ),
          ),
          SizedBox(
            width: 40,
            child: TextFormField(
              style: Themes.dark.textTheme.bodyLarge,
              focusNode: _controller.fSixText,
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              decoration: otpInputDecoration,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _controller.fSixText!.unfocus();
                  print("value $value");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}