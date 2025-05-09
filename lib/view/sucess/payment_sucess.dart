import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/imagesConst.dart';
import '../dashboard/dashboardScreen.dart';

class PaymentSucess extends StatefulWidget {
  const PaymentSucess({super.key});

  @override
  State<PaymentSucess> createState() => _PaymentSucessState();
}

class _PaymentSucessState extends State<PaymentSucess> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      Get.off(
            () =>
             DashboardScreen(pageIndex: 0),
        // // customerModel == null
        //      RegistrationScreen()
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(child:  Image.asset(Images.success,scale: 0.2,),scale: 0.5,),
            SizedBox(height: 30,),
            Text("Payment SuccessFully",style: TextStyle(color: Colors.white,fontSize: 18),)
            
            // Container(height: 100,width: 100,
            //
            //   // color: Colors.yellow,
            //   decoration: BoxDecoration(
            //       // color: Colors.yellow,
            //
            //       image: DecorationImage(image: AssetImage(Images.success))),
            // )
          ],
        ),
      ),
    );
  }
}
