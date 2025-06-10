import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/customerModel.dart';

class SharedHelper {
  static String customerModelKey = "customerModelKey";
  static String deleteAccountKey = "deleteAccountKey";

  static const String _firmIdKey = 'firmIdKey';

  Future<void> setCustomer(CustomerModel customerModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String customerJson = jsonEncode(customerModel.toJson());
    print(customerJson);
    print("============ customer details ${customerJson}");
    await prefs.setString(customerModelKey, customerJson);
  }

  Future<CustomerModel?> getCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerJson = prefs.getString(customerModelKey);
    if(customerJson != null){
    Map<String, dynamic> customerMap = jsonDecode(customerJson!);
    CustomerModel? customerModel = CustomerModel.fromJson(customerMap);
    print("============ get customer details ${customerJson}");

    return customerModel;
    }else{
      return null;
    }
  }

  Future<void> storeString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getStoredString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  Future<void> storeBool({required String key,required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getStoredBool({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> deleteCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(customerModelKey);
    print("Customer data deleted successfully.");
  }
}
