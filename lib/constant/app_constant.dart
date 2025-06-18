import 'package:flutter/material.dart';
import 'package:get/get.dart';

String API_URL = "https://kffashionnew.reliablesolution.in/Admin/Ajax/";
// String API_URL = "https://keep.reliablesolution.in/Admin/Ajax/";
String IMAGE_URL = "https://kffashionnew.reliablesolution.in/resources/images/";
// String IMAGE_URL = "https://keep.reliablesolution.in/resources/images/";
String? firmId = "0";

getSnackbar(body) {
  Get.snackbar(
    'Success',
    body,
    backgroundColor: Colors.lightBlue,
  );
}
