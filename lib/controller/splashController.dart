// //flutter
// import 'dart:async';
// //packages
// import 'package:get/get.dart';
// //controllers
// //views
// import 'package:keep_app/view/otp/phone_auth.dart';
// import 'package:keep_app/controller/networkController.dart';
// import 'package:keep_app/models/customerModel.dart';
// import 'package:keep_app/view/dashboard/dashboardScreen.dart';
// import 'package:keep_app/view/otp/registrationScreen.dart';
//
// import '../utils/sharedPrefs.dart';
//
// class SplashController extends GetxController {
//   NetworkController networkController = Get.put(NetworkController());
//   SharedHelper helper = SharedHelper();
//
//   @override
//   void onInit() async {
//     _init();
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//
//   _init() async {
//     CustomerModel? customerModel = await helper.getCustomer();
//     Timer(Duration(seconds: 3), () {
//       Get.off(
//         () =>
//         customerModel == null
//             ? LoginScreen()
//             : DashboardScreen(pageIndex: 0),
//             // // customerModel == null
//             //      RegistrationScreen()
//       );
//     });
//   }
// }
//

import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/constant/app_constant.dart';
import 'package:keep_app/constant/colorConst.dart';
import 'package:keep_app/models/settingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/api_endpoints.dart';
import '../models/customerModel.dart';
import '../models/firmModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';
import 'networkController.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController? popUpAnimationController;
  late Animation<double>? animation2;
  NetworkController networkController = Get.put(NetworkController());
  SharedHelper helper = SharedHelper();
  List<FirmInfo> firmList = [];
  List<SettingInfo> settingList = [];
  RxBool isLoading = false.obs;
  RxString checkException = "".obs;
  RxBool hasInternet = true.obs;



  RxDouble size = 50.0.obs;

  @override
  void onInit() {
    super.onInit();
    getFirm();
    getSettingData();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    popUpAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    animation2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    Future.delayed(const Duration(milliseconds: 150), onChangeSize);
  }

  void onChangeSize() {
    size.value = 200;
    popUpAnimationController?.forward();
  }

  // /// Save Firm ID
  // Future<void> saveFirmId(String firmId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_fir, firmId);
  // }

  /// Get Firm ID
  Future<String?> getFirmId() async {
    return helper.getStoredString("firmIdKey");
  }

  /// Get Firm all data
  Future<void> getFirm() async {
    try {

      isLoading.value = false;
      update();


      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        hasInternet.value = false;
        checkException.value = "No Internet Connection";
        return;
      } else {
        hasInternet.value = true;
      }
      var response = await ApiService.get(get_firms);



      if (response.data['IsSuccess'] == true) {
        print("API Response: ${response.data}");

        FirmModel firmModel = FirmModel.fromJson(response.data);


        if (firmModel.data != null && firmModel.data!.isNotEmpty) {
          firmList = firmModel.data!;

          // String firmId = firmList[0].firmId ?? '';
          // await helper.storeString("firmIdKey", firmId);
          // print("Saved firm ID: $firmId");
        }

          isLoading.value = false;
          update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      String errorMessage = e.toString();
      print("error $errorMessage");

      if (errorMessage.contains("receiveTimeout") ||
          errorMessage.contains("SocketException") ||
          errorMessage.contains("Network Error") ||
          errorMessage.contains("Connection failed") ||
          errorMessage.contains("aborted") ||
          errorMessage.contains("Failed host lookup")) {
        checkException.value = "Network Error";
        update();
      } else {
        checkException.value = errorMessage;
        update();

      }

      Get.snackbar("Error", checkException.value, backgroundColor: COLOR.background);
      print("Error in getFirmData: $errorMessage");

      throw Exception("Failed to get firm data: $errorMessage");
      // Get.snackbar("Error", e.toString(),backgroundColor: COLOR.background);
      // checkException.value = e..toString();
      // print("Error in getFirmData: $e");
      //
      // throw Exception("Failed to get firm data: $e");
    }
  }


  /// Get Setting all data
  // Future<void> getSettingData() async {
  //   try {
  //
  //     isLoading.value = false;
  //     update();
  //
  //
  //     final connectivityResult = await Connectivity().checkConnectivity();
  //     if (connectivityResult == ConnectivityResult.none) {
  //       hasInternet.value = false;
  //       checkException.value = "No Internet Connection";
  //       return;
  //     } else {
  //       hasInternet.value = true;
  //     }
  //     var response = await ApiService.get(getSetting);
  //
  //
  //
  //     if (response.data['IsSuccess'] == true) {
  //
  //       print("API Response: ${response.data}");
  //
  //       SettingModel settingModel = SettingModel.fromJson(response.data);
  //
  //
  //       if (settingModel.data != null && settingModel.data!.isNotEmpty) {
  //
  //         settingList = SettingModel.data!;
  //
  //         // String firmId = firmList[0].firmId ?? '';
  //         // await helper.storeString("firmIdKey", firmId);
  //         // print("Saved firm ID: $firmId");
  //       }
  //
  //         isLoading.value = false;
  //         update();
  //     } else {
  //       throw Exception("Error from API: ${response.data['Message']}");
  //     }
  //   } catch (e) {
  //     String errorMessage = e.toString();
  //     print("error $errorMessage");
  //
  //     if (errorMessage.contains("receiveTimeout") ||
  //         errorMessage.contains("SocketException") ||
  //         errorMessage.contains("Network Error") ||
  //         errorMessage.contains("Connection failed") ||
  //         errorMessage.contains("aborted") ||
  //         errorMessage.contains("Failed host lookup")) {
  //       checkException.value = "Network Error";
  //       update();
  //     } else {
  //       checkException.value = errorMessage;
  //       update();
  //
  //     }
  //
  //     Get.snackbar("Error", checkException.value, backgroundColor: COLOR.background);
  //     print("Error in getFirmData: $errorMessage");
  //
  //     throw Exception("Failed to get firm data: $errorMessage");
  //     // Get.snackbar("Error", e.toString(),backgroundColor: COLOR.background);
  //     // checkException.value = e..toString();
  //     // print("Error in getFirmData: $e");
  //     //
  //     // throw Exception("Failed to get firm data: $e");
  //   }
  // }
  Future<void> getSettingData() async {
    try {
      isLoading.value = true;
      update();

      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        hasInternet.value = false;
        checkException.value = "No Internet Connection";
        Get.snackbar("Error", checkException.value, backgroundColor: Colors.red);
        return;
      } else {
        hasInternet.value = true;
      }

      final response = await ApiService.get(getSetting);
      log("API  Setting Response: ${response.data}");

      if (response.data['IsSuccess'] == true) {
        SettingModel settingModel = SettingModel.fromJson(response.data);

        if (settingModel.data != null && settingModel.data!.isNotEmpty) {
          settingList.assignAll(settingModel.data!);
          // log("Assigned firmList: ${firmList.length} items");

          // Store firmId
          // String firmId = firmList[0].settingId ?? '';
          // if (firmId.isNotEmpty) {
          //   await helper.storeString("firmIdKey", firmId);
          //   log("Saved firm ID: $firmId");
          // } else {
          //   log("No valid firmId found in firmList[0]");
          // }
        } else {
          log("No data in SettingModel: ${settingModel.message}");
          checkException.value = "No settings data available";
          Get.snackbar("Warning", checkException.value, backgroundColor: Colors.orange);
        }
      }
      else {
        checkException.value = response.data['Message'] ?? "Unknown error";
        Get.snackbar("Error", checkException.value, backgroundColor: Colors.red);
        throw Exception("Error from API: ${checkException.value}");
      }
    } catch (e, stackTrace) {
      String errorMessage = e.toString();
      log("Error in getSettingData: $errorMessage, StackTrace: $stackTrace");

      if (errorMessage.contains("receiveTimeout") ||
          errorMessage.contains("SocketException") ||
          errorMessage.contains("Network Error") ||
          errorMessage.contains("Connection failed") ||
          errorMessage.contains("aborted") ||
          errorMessage.contains("Failed host lookup")) {
        checkException.value = "Network Error";
      } else {
        checkException.value = errorMessage;
      }

      Get.snackbar("Error", checkException.value, backgroundColor: Colors.red);
      throw Exception("Failed to get setting data: $errorMessage");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  @override
  void onClose() {
    controller.dispose();
    popUpAnimationController?.dispose();
    super.onClose();
  }
}
