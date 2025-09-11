// //flutter
// import 'package:flutter/material.dart';
// //packages
// import 'package:get/get.dart';
// //controllers
// // import 'package:getxnative/controllers/networkController.dart';
//
// import '../models/customerModel.dart';
// import '../utils/sharedPrefs.dart';
// import 'networkController.dart';
//
// class EditProfileController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   // getxcontroller instance
//   NetworkController networkController = Get.put(NetworkController());
//
//   TabController? tabController;
//
//   var cFullName = TextEditingController();
//   var cPhoneNo = TextEditingController();
//   var cEmail = TextEditingController();
//   var cLanguages = TextEditingController();
//   var cMyBusinessName = TextEditingController();
//   var cPincode = TextEditingController();
//   var cCity = TextEditingController();
//
//   var fFullName = FocusNode();
//   var fPhoneNo = FocusNode();
//   var fEmail = FocusNode();
//   var fGender = FocusNode();
//   var fLanguages = FocusNode();
//   var fOccupation = FocusNode();
//   var fMyBusinessName = FocusNode();
//   var fPincode = FocusNode();
//   var fCity = FocusNode();
//
//   var selectgender = 'Male'.obs;
//   var selectOccupation = "Others".obs;
//   var switchVal1 = true.obs;
//   var switchval2 = false.obs;
//
//   SharedHelper helper = SharedHelper();
//
//   CustomerModel? m1 = CustomerModel();
//
//   // var selectValueLanges = ''.obs;
//
//   List<String> genderList = [
//     "Male",
//     "Female",
//     "Others",
//   ];
//   List<String> occupationList = [
//     "Housewife",
//     "Teacher",
//     "Business",
//     "Student",
//     "Job/Service",
//     "Others",
//   ];
//   final List<Tab> editprofileTabs = <Tab>[
//     Tab(
//       text: "Primary",
//     ),
//     // Tab(
//     //   text: "Settings",
//     // )
//   ];
//   @override
//   void onInit() async {
//     tabController = TabController(vsync: this, length: editprofileTabs.length);
//     m1 = await helper.getCustomer();
//
//     getData();
//
//     super.onInit();
//   }
//
//   getData() {
//     cFullName.text = m1!.customerName!;
//     cPhoneNo.text = m1!.customerPhoneNo!;
//     cEmail.text = m1!.customerEmailId!;
//     cPincode.text = m1!.customerCode!;
//     print("Profile name : ${cFullName.text}");
//     print("Profile name : ${cPhoneNo.text}");
//     print("Profile name : ${cEmail.text}");
//     print("Profile name : ${cPincode.text}");
//     // print("Profile name : ${cFullName.text}");
//     update();
//   }
//
//   @override
//   void dispose() {
//     tabController!.dispose();
//     super.dispose();
//   }
//
//   onSwitchedValue1() {
//     try {
//       switchVal1.value = !switchVal1.value;
//       update();
//     } on Exception catch (e) {
//       print('Exception - Settingcontroller ' + e.toString());
//     }
//   }
//
//   onSwitchedValue2() {
//     try {
//       switchval2.value = !switchval2.value;
//       update();
//     } on Exception catch (e) {
//       print('Exception - Settingcontroller ' + e.toString());
//     }
//   }
//
//   changeOccupationValue(String value) {
//     try {
//       selectOccupation.value = value;
//       update();
//     } catch (err) {
//       print("Exception: changeGenderValue() :-" + err.toString());
//     }
//   }
//
//   changeGenderValue(String value) {
//     try {
//       selectgender.value = value;
//       update();
//     } catch (err) {
//       print("Exception: changeGenderValue() :-" + err.toString());
//     }
//   }
//
// // List<NotificationList> languagesList = [
// //   NotificationList(id: 1, isCheck: false, name: 'Hindi'),
// //   NotificationList(id: 2, isCheck: false, name: 'English'),
// //   NotificationList(id: 3, isCheck: false, name: 'Bengali'),
// //   NotificationList(id: 4, isCheck: false, name: 'Tamil'),
// //   NotificationList(id: 5, isCheck: false, name: 'Telugu'),
// //   NotificationList(id: 6, isCheck: false, name: 'Malayalam'),
// //   NotificationList(id: 7, isCheck: false, name: 'Kannada'),
// //   NotificationList(id: 8, isCheck: false, name: 'Marathi'),
// // ];
// }

//flutter
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//packages
import 'package:get/get.dart';
import 'package:keep_app/constant/api_endpoints.dart';

//controllers
// import 'package:getxnative/controllers/networkController.dart';

import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
// import '../utils/shared_pref.dart';
import '../utils/sharedPrefs.dart';
import '../utils/string_res.dart';
import 'networkController.dart';
import 'package:http_parser/http_parser.dart';

// import 'package:dio/dio.dart';

import 'package:dio/dio.dart' as dio;

class EditProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
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
  RxString? path = "".obs;

  SharedHelper helper = SharedHelper();

  // CustomerModel? m1 = CustomerModel();
  Rx<CustomerModel?> m1 = Rx<CustomerModel?>(null); // Make m1 reactive

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
    m1.value = await helper.getCustomer();
    GetProfile(customerId: m1.value!.customerId!);

    getData();

    super.onInit();
  }

  getData() {
    cFullName.text = m1!.value!.customerName!;
    cPhoneNo.text = m1!.value!.customerPhoneNo!;
    cEmail.text = m1!.value!.customerEmailId!;
    cPincode.text = m1.value!.customerCode!;
    print("Profile name : ${cFullName.text}");
    print("Profile name : ${cPhoneNo.text}");
    print("Profile name : ${cEmail.text}");
    print("Profile name : ${cPincode.text}");
    // print("Profile name : ${cFullName.text}");
    update();
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
      print('Exception - Settingcontroller $e');
    }
  }

  onSwitchedValue2() {
    try {
      switchval2.value = !switchval2.value;
      update();
    } on Exception catch (e) {
      print('Exception - Settingcontroller $e');
    }
  }

  changeOccupationValue(String value) {
    try {
      selectOccupation.value = value;
      update();
    } catch (err) {
      print("Exception: changeGenderValue() :-$err");
    }
  }

  changeGenderValue(String value) {
    try {
      selectgender.value = value;
      update();
    } catch (err) {
      print("Exception: changeGenderValue() :-$err");
    }
  }

// EditProfile(){}
  Future<void> EditProfile({
    required String customerId,
    required String name,
    required String email,
    required String gender,
    required String? path,
  }) async {
    try {
      print("Edit Profile Phone Number ${m1.value!.customerPhoneNo}");
      String fileName = path!.split('/').last;
      final Map<String, dynamic> body = {
        'CustomerId': m1!.value!.customerId,
        'CustomerName': cFullName.text,
        'CustomerEmailId': cEmail.text,
        'CustomerGender': "",
        'CustomerPhoneNo': cPhoneNo.text ?? m1.value!.customerPhoneNo,
        // 'CustomerGender': firmId,

        'CustomerImage': path.isEmpty ? "":await dio.MultipartFile.fromFile(
          path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'), // or 'png' if needed
        ),
        // path!.value,
      };

      print("Edit Profile Body Data ${body[0]}");
      var response = await ApiService.post(
        endpoint: "updateCustomerProfile",
        body: body,
      );
      if (response.data['IsSuccess'] == true) {
        print("============ Data added SuccessFully in Update Profile");
        Fluttertoast
            .showToast(
            msg: "Profile Edited Successfully",
            gravity: ToastGravity.BOTTOM);
        Get.back();
        GetProfile(customerId: m1!.value!.customerId!);
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in Profile: $e");
      throw Exception("Failed to update profile data: $e");
    }
  }




  Future<void> GetProfile({
    required String customerId,

  }) async {
    try {
      // String fileName = path!.split('/').last;
      final Map<String, dynamic> body = {'CustomerId':customerId,};

      print("Body Data ${body[0]}");
      var response = await ApiService.post(
        endpoint: "getCustomerProfile",
        body: body,
      );
      if (response.data['IsSuccess'] == true) {
        print("============ Data added SuccessFully in Update Profile");
        print("Data in Profile Screen  ${response.data['Data'][0]}");
        // getCartTotal(customerModel!.value.customerId!);

        if (response.data['Data'] != null && response.data['Data'].isNotEmpty) {

          String? existingPhoneNo = m1.value?.customerPhoneNo; // Preserve phone number
          m1.value = CustomerModel.fromJson(response.data['Data'][0]);
          m1.value!.customerPhoneNo = existingPhoneNo ?? m1.value!.customerPhoneNo;
          // CustomerModel customerModel = CustomerModel.fromJson(response.data['Data'][0]);

          // String? oldPhoneNo = m1.value?.customerPhoneNo;
          // m1.value = CustomerModel.fromJson(response.data['Data'][0]);

          // Set TextEditingController values
          cFullName.text = m1.value!.customerName ?? '';
          cPhoneNo.text = m1.value!.customerPhoneNo ?? '';
          cEmail.text = m1.value!.customerEmailId ?? '';


          // Save to SharedPreferences
          await helper.setCustomer(m1.value!);
          print("Customer data saved successfully!");

          // Save to SharedPreferences using helper
          // await helper.setCustomer(customerModel);
          print("Customer data saved successfully!");

          // Update UI or state if needed
          update();
        } else {
          throw Exception("No customer data found in response");
        }
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in getProfile: $e");
      throw Exception("Failed to get profile data: $e");
    }
  }
}
