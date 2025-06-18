
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_common_text.dart';
import 'app_style.dart';
// import 'package:suratjugaad/a_structure/constant/app_common_text.dart';
// import 'package:suratjugaad/a_structure/constant/app_styles.dart';


class AppUtils {
  AppUtils._();

  static void showToast(String msg) {
    if (msg == '') {
      return;
    }
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

  static noRecordMsg({String? message}) {
    return Center(
        child: textSemiBold(text: message ?? "No Record Found", fontSize: 16)
    );
  }

  static circularLoaderData() {
    return  Center(
      child: SizedBox(
        height: 23,
        width: 23,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppStyles.secondaryColor,
        ),
      ),
    );
  }

}

