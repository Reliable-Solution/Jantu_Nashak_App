//flutter
import 'package:flutter/material.dart';
//packages
import 'package:get/get.dart';
//controllers
import 'package:keep_app/controller/networkController.dart';

class AccountController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // getxcontroller instance
  NetworkController networkController = Get.put(NetworkController());

  var accountno = TextEditingController();
  var confirmAccountno = TextEditingController();
  var accountHoldername = TextEditingController();
  // RxnString verification = RxnString();
  RxnString message = RxnString();

  TabController? paymentTabController;

  final List<Tab> paymentTabs = <Tab>[
    Tab(
      text: "Tranactions",
    ),
    Tab(
      text: "Payment Modes",
    ),
  ];

  @override
  void onInit() async {
    paymentTabController =
        TabController(vsync: this, length: paymentTabs.length);
    super.onInit();
  }

  @override
  void dispose() {
    paymentTabController!.dispose();
    super.dispose();
  }
}
