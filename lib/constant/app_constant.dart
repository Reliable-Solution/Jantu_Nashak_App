import 'package:flutter/material.dart';
import 'package:get/get.dart';

String API_URL =
    // " ";
"https://staging-jantunashak.reliablesolution.in/Admin/Ajax/";
// String API_URL = "https://keep.reliablesolution.in/Admin/Ajax/";
String IMAGE_URL =
    "https://staging-jantunashak.reliablesolution.in/resources/images/";
// String IMAGE_URL = "https://keep.reliablesolution.in/resources/images/";
String? firmId = "1";

getSnackbar(body) {
  Get.snackbar(
    'Success',
    body,
    backgroundColor: Colors.lightBlue,
  );
}
