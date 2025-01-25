import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../constant/api_endpoints.dart';
import '../models/addressModel.dart';
import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';

class AddressController extends GetxController
{
  RxList<AddressModel> allAddressList = <AddressModel>[].obs;
  // Rx<CustomerModel>? customerModel = CustomerModel().obs;
  SharedHelper helper = SharedHelper();
  TextEditingController txtFullname = TextEditingController();
  TextEditingController txtMobileno = TextEditingController();
  TextEditingController txtPincode = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtLandmark = TextEditingController();
  TextEditingController txtType = TextEditingController();
  CustomerModel? customer = CustomerModel();
  RxBool isAddress = false.obs;



  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    customer = await helper.getCustomer();

    getPrefs();
    getAllAddress();
    super.onInit();
  }

  getPrefs() async {
   customer = await helper.getCustomer();
    print("====== cid 1 ${customer!.customerId}");
    // if (customer != null) {
    //   customerModel!.value = customer;
    // }
    update();
  }
  addAddressData({AddressModel? addressModel}) async {
    try {
      final Map<String, dynamic> body = {
        "CustomerId": addressModel!.customerId,
        "AddressFullName": addressModel.addressFullName,
        "AddressMobileNo": addressModel.addressMobileNo,
        "AddressPincode": addressModel.addressPincode,
        "Address": addressModel.addressColony,
        "AddressLandmark": addressModel.addressLandmark,
        "AddressType": addressModel.addressType,
      };

      var response = await ApiService.post(endpoint: addAddress, body: body);

      print("sub category data ${response.data}");

      if (response.data['IsSuccess'] == true) {
        allAddressList.value = (response.data['Data'] as List)
            .map((addressJson) => AddressModel.fromJson(addressJson))
            .toList();
        print("sub category data ${allAddressList.length}");
        // isCategory = true.obs;
        update();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in fetchCategoryData: $e");
      throw Exception("Failed to fetch category data");
    }
  }
  getAllAddress() async {
    try {
      print("======  cid${customer!.customerId}");
      final Map<String, dynamic> body = {
        "CustomerId": customer!.customerId,
      };

      var response = await ApiService.post(endpoint: getAddress, body: body);
print("======== responces ${response.data}");
      if (response.data['IsSuccess'] == true) {
        allAddressList.value = (response.data['Data'] as List)
            .map((addressJson) => AddressModel.fromJson(addressJson))
            .toList();
        print("address data ${allAddressList.length}");
        isAddress.value =true;
        // isCategory = true.obs;
        update();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in fetchaddressData: $e");
      throw Exception("Failed to fetch address data");
    }
  }
  deleteAddressData({String? custmoerId,String? addressId}) async {
    try {
      allAddressList.clear();
      print("======  cid${customer!.customerId}");
      final Map<String, dynamic> body = {
        "CustomerId": custmoerId,
        "AddressId": addressId,
      };

      var response = await ApiService.post(endpoint: deleteAddress, body: body);
      print("======== responces ${response.data}");
      if (response.data['IsSuccess'] == true) {
        allAddressList.value = (response.data['Data'] as List)
            .map((addressJson) => AddressModel.fromJson(addressJson))
            .toList();
        print("address data ${allAddressList.length}");
        isAddress.value =true;
        // isCategory = true.obs;
        update();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in fetchdeleteAddressData: $e");
      throw Exception("Failed to fetch delete Address Data");
    }
  }
}