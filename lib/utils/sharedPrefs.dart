import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/customerModel.dart';

class SharedHelper {
  static String customerModelKey = "customerModelKey";

  Future<void> setCustomer(CustomerModel customerModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String customerJson = jsonEncode(customerModel.toJson());
    print(customerJson);
    await prefs.setString(customerModelKey, customerJson);
  }

  Future<CustomerModel?> getCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerJson = prefs.getString(customerModelKey);
    if(customerJson != null){
    Map<String, dynamic> customerMap = jsonDecode(customerJson!);
    CustomerModel? customerModel = CustomerModel.fromJson(customerMap);
    return customerModel;
    }else{
      return null;
    }
  }
}
