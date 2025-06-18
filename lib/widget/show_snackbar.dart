// import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
void showSnackBar(
    {required BuildContext context,
      required String msg,
      bool isError = false}) {
  Flushbar? flushbar;
  flushbar = Flushbar(
    titleColor: Colors.white,
    // message: msg,
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
    borderRadius: BorderRadius.circular(10),
    backgroundColor: isError ? Colors.red : Colors.green,
    // boxShadows: [BoxShadow(color: Colors.blue[800]!, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
    // backgroundGradient: LinearGradient(colors: [Colors.blueGrey, Colors.black]),
    isDismissible: true,
    dismissDirection: FlushbarDismissDirection.VERTICAL,
    duration: const Duration(seconds: 4),
    mainButton: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            height: 25,
            width: 25,
            decoration:
            BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(
              Icons.close_outlined,
              size: 20,
              color: isError ? Colors.red : Colors.green,
            ),
          ),
        )),
    messageText:Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child:  Text(
          msg, style: TextStyle(color: Colors.white,fontSize: 16)),
    ),
  );
  flushbar.dismiss();
  flushbar.show(context);
}