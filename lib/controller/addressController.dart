import 'package:get/get.dart';

import '../constant/api_endpoints.dart';
import '../models/addressModel.dart';
import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';

class AddressController extends GetxController
{
  RxList<AddressModel> allAddressList = <AddressModel>[].obs;
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  SharedHelper helper = SharedHelper();



  getPrefs() async {
    CustomerModel? customer = await helper.getCustomer();
    if (customer != null) {
      customerModel!.value = customer;
    }
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
      final Map<String, dynamic> body = {
        "CustomerId": customerModel!.value.customerId,
      };

      var response = await ApiService.post(endpoint: getAddress, body: body);


      if (response.data['IsSuccess'] == true) {
        allAddressList.value = (response.data['Data'] as List)
            .map((addressJson) => AddressModel.fromJson(addressJson))
            .toList();
        print("address data ${allAddressList.length}");
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
}