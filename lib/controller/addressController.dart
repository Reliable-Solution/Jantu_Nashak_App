import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../constant/api_endpoints.dart';
import '../models/addressModel.dart';
import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';

class AddressController extends GetxController {
  RxList<AddressModel> allAddressList = <AddressModel>[].obs;
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  SharedHelper helper = SharedHelper();
  TextEditingController txtFullname = TextEditingController();
  TextEditingController txtMobileno = TextEditingController();
  TextEditingController txtPincode = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtLandmark = TextEditingController();
  TextEditingController txtType = TextEditingController();
  RxBool isAddress = false.obs;
  RxList<AddressModel> addressList = <AddressModel>[].obs;
  RxString selectedAddressId = ''.obs;
  // var selectedType = ''.obs;
  //
  // final List<String> types = ['Home', 'Office', 'Other'];
  //
  // void setType(String value) {
  //   selectedType.value = value;
  // }
  var selectedType = ''.obs;
  var showError = false.obs;

  final List<String> types = ['Home', 'Office', 'Other'];

  void setType(String? value) {
    selectedType.value = value ?? '';
    showError.value = false;
    update();// Hide error on selection
  }

  bool validate() {
    if (selectedType.value.isEmpty) {
      showError.value = true;
      return false;
    }
    return true;
  }



  @override
  Future<void> onInit() async {
    getPrefs();
    super.onInit();
  }

  getPrefs() async {
    CustomerModel? customer = await helper.getCustomer();

    if (customer != null) {
      customerModel!.value = customer;
    }

    update();
    getAllAddress();
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

      print(" Add Address data ${response.data}");

      if (response.data['IsSuccess'] == true) {
        allAddressList.add(addressModel);
        print("sub category data ${allAddressList.length}");
        // isCategory = true.obs;
        update();
        Get.back();
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
      if (allAddressList.isNotEmpty && selectedAddressId.isEmpty) {
        selectedAddressId.value = allAddressList.last.addressId.toString();
      }
      final Map<String, dynamic> body = {
        "CustomerId": customerModel!.value.customerId,
      };

      var response = await ApiService.post(endpoint: getAddress, body: body);

      print(" Address ${response.data}");
      if (response.data['IsSuccess'] == true) {
        allAddressList.value = (response.data['Data'] as List)
            .map((addressJson) => AddressModel.fromJson(addressJson))
            .toList();
        print("address data ${allAddressList.length}");
        isAddress.value = true;
        // isCategory = true.obs;
        update();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in Fetch Address Data: $e");
      throw Exception("Failed to fetch address data");
    }
  }

  deleteAddressData({String? customerId, String? addressId}) async {
    try {
      final Map<String, dynamic> body = {
        "CustomerId": customerId,
        "AddressId": addressId,
      };

      var response = await ApiService.post(endpoint: deleteAddressApi, body: body);
      if (response.data['IsSuccess'] == true) {
        int index =  allAddressList.indexWhere((item) => item.addressId == addressId);
        allAddressList.removeAt(index);
        update();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in deleteAddressData: $e");
      throw Exception("Failed to fetch delete Address Data");
    }
  }
  updateAddressData({AddressModel? addressModel,String? addressId}) async {
    try {
      print(addressModel);
      final Map<String, dynamic> body = {
        "CustomerId": addressModel!.customerId,
        "AddressFullName": addressModel.addressFullName,
        "AddressMobileNo": addressModel.addressMobileNo,
        "AddressPincode": addressModel.addressPincode,
        "Address": addressModel.addressColony,
        "AddressLandmark": addressModel.addressLandmark,
        "AddressType": addressModel.addressType,
        "AddressId":addressModel.addressId
      };
      var response = await ApiService.post(endpoint: updateAddress, body: body);
      print(" Add Update Address data ${response.data}");
      if (response.data['IsSuccess'] == true) {
        int index = allAddressList.indexWhere((element) => element.addressId == addressId,);
        allAddressList[index] = addressModel;
        print("Update Address Data ${allAddressList.length}");
        // isCategory = true.obs;
        update();
        Get.back();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in fetch Update Address Data: $e");
      throw Exception("Failed to fetch Update Address Data");
    }
  }

  // Address Add Karne Ka Function
  void selectAddAddress(AddressModel address) {
    allAddressList.add(address);
  }

  // Address Edit Karne Ka Function
  void editAddress(int index, AddressModel newAddress) {
    allAddressList[index] = newAddress;
  }

  // Address Select Karne Ka Function
  void selectAddress(int addressId) {
    selectedAddressId.value = addressId.toString();
    Get.back(); // BottomSheet Close
  }

  // Address Delete Karne Ka Function
  void deleteSelectAddressData({required int customerId, required int addressId}) {
    allAddressList.removeWhere((address) => address.addressId == addressId);
    if (selectedAddressId.value == addressId.toString()) {
      selectedAddressId.value = ''; // Selected Address Delete Hua to Clear Karna
    }
  }


}
