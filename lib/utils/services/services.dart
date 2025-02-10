
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../constant/app_constant.dart';



Dio dio = Dio();

class Services {
  static Future<List> postforlist({apiName, body}) async {
    String url = '$API_URL$apiName';
    log("$apiName url : $url");

    Response response;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }
      log("Maja ma");
      log("api stratus code : ${response.statusCode}");
      if (response.statusCode == 200) {
        List list = [];
        log("$apiName Response: ${jsonEncode(response.data)}");
        var responseData = response.data;
        if (responseData["IsSuccess"] == true &&
            responseData["Data"].length > 0) {
          list = responseData["Data"];
        }
        return list;
      } else {
        log("error ->${response.data}");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      log("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<SaveDataClass> postForSave({apiName, body}) async {
    String url = '$API_URL$apiName';
    log("$apiName url : $url");
    Response response;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }
      if (response.statusCode == 200) {
        SaveDataClass saveData =
        SaveDataClass(Message: 'No Data', IsSuccess: false, Data: null);
        log("$apiName Response: ${response.data}");
        var responseData = response.data;
        saveData.Message = responseData["Message"];
        saveData.IsSuccess = responseData["IsSuccess"];
        saveData.Data = responseData["Data"].toString();

        return saveData;
      } else {
        log("error ->${response.data}");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      log("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}


class SaveDataClass {
  String? Message;
  bool? IsSuccess;
  String? Data;
  List? Content;

  SaveDataClass({this.Message, this.IsSuccess, this.Data, this.Content});

  factory SaveDataClass.fromJson(Map<String, dynamic> json) {
    return SaveDataClass(
      Message: json['Message'] as String,
      IsSuccess: json['IsSuccess'] as bool,
      Data: json['Data'] as String,
      Content: json['Data'] as List,
    );
  }
}