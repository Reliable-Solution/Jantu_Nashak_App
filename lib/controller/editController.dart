//flutter
import 'package:flutter/material.dart';
//packages
import 'package:get/get.dart';
//controllers
// import 'package:getxnative/controllers/networkController.dart';

import 'networkController.dart';

class EditProfileController extends GetxController with GetSingleTickerProviderStateMixin {
  // getxcontroller instance
  NetworkController networkController = Get.put(NetworkController());

  TabController? tabController;

  var cFullName = TextEditingController();
  var cPhoneNo = TextEditingController();
  var cEmail = TextEditingController();
  var cLanguages = TextEditingController();
  var cMyBusinessName = TextEditingController();
  var cPincode = TextEditingController();
  var cCity = TextEditingController();

  var fFullName = FocusNode();
  var fPhoneNo = FocusNode();
  var fEmail = FocusNode();
  var fGender = FocusNode();
  var fLanguages = FocusNode();
  var fOccupation = FocusNode();
  var fMyBusinessName = FocusNode();
  var fPincode = FocusNode();
  var fCity = FocusNode();

  var selectgender = 'Male'.obs;
  var selectOccupation = "Others".obs;
  var switchVal1 = true.obs;
  var switchval2 = false.obs;

  // var selectValueLanges = ''.obs;

  List<String> genderList = [
    "Male",
    "Female",
    "Others",
  ];
  List<String> occupationList = [
    "Housewife",
    "Teacher",
    "Business",
    "Student",
    "Job/Service",
    "Others",
  ];
  final List<Tab> editprofileTabs = <Tab>[
    Tab(
      text: "Primary",
    ),
    // Tab(
    //   text: "Settings",
    // )
  ];
  @override
  void onInit() async {
    tabController = TabController(vsync: this, length: editprofileTabs.length);
    super.onInit();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  onSwitchedValue1() {
    try {
      switchVal1.value = !switchVal1.value;
      update();
    } on Exception catch (e) {
      print('Exception - Settingcontroller ' + e.toString());
    }
  }

  onSwitchedValue2() {
    try {
      switchval2.value = !switchval2.value;
      update();
    } on Exception catch (e) {
      print('Exception - Settingcontroller ' + e.toString());
    }
  }

  changeOccupationValue(String value) {
    try {
      selectOccupation.value = value;
      update();
    } catch (err) {
      print("Exception: changeGenderValue() :-" + err.toString());
    }
  }

  changeGenderValue(String value) {
    try {
      selectgender.value = value;
      update();
    } catch (err) {
      print("Exception: changeGenderValue() :-" + err.toString());
    }
  }

// List<NotificationList> languagesList = [
//   NotificationList(id: 1, isCheck: false, name: 'Hindi'),
//   NotificationList(id: 2, isCheck: false, name: 'English'),
//   NotificationList(id: 3, isCheck: false, name: 'Bengali'),
//   NotificationList(id: 4, isCheck: false, name: 'Tamil'),
//   NotificationList(id: 5, isCheck: false, name: 'Telugu'),
//   NotificationList(id: 6, isCheck: false, name: 'Malayalam'),
//   NotificationList(id: 7, isCheck: false, name: 'Kannada'),
//   NotificationList(id: 8, isCheck: false, name: 'Marathi'),
// ];
}
