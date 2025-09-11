import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../constant/api_endpoints.dart';
import '../constant/app_constant.dart';
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
  final TextEditingController searchController = TextEditingController();
  final RxString errorMessage = ''.obs;

  RxBool isAddress = false.obs;
  RxBool isSearching = false.obs;
  RxList<AddressModel> addressList = <AddressModel>[].obs;
  RxList<AddressModel> filteredList = <AddressModel>[].obs;

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
    update(); // Hide error on selection
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
    // filteredList.assignAll(addressList);
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

  void searchCategory(String query) {
    isSearching.value = true; // ✅ Start loader

    Future.delayed(Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        filteredList.assignAll(allAddressList);
      } else {
        filteredList.assignAll(
          allAddressList.where((item) =>
              item.addressFullName!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.addressMobileNo!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.addressColony!.toLowerCase().contains(query.toLowerCase())),
        );
      }
      isSearching.value = false; // ✅ Stop loader after filtering
    });
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
        'FirmId': firmId
      };

      var response = await ApiService.post(endpoint: addAddress, body: body);

      print(" Add Address data ${response.data}");

      if (response.data['IsSuccess'] == true) {
        allAddressList.add(addressModel);
        filteredList.add(addressModel);
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
      isAddress.value = true;
      allAddressList.clear();
      filteredList.clear();

      if (allAddressList.isNotEmpty && selectedAddressId.isEmpty) {
        selectedAddressId.value = allAddressList.last.addressId.toString();
      }
      // allAddressList.clear();
      final Map<String, dynamic> body = {
        "CustomerId": customerModel!.value.customerId,
        'FirmId': firmId
      };

      var response = await ApiService.post(endpoint: getAddress, body: body);

      print(" Address ${response.data}");
      if (response.data['IsSuccess'] == true) {
        allAddressList.value = (response.data['Data'] as List)
            .map((addressJson) => AddressModel.fromJson(addressJson))
            .toList();
        print("address data ${allAddressList.length}");

        filteredList.assignAll(allAddressList);

        // isCategory = true.obs;
        update();
      } else {
        print("Address list ${allAddressList.length}");
        print("Address list ${filteredList.length}");
        throw Exception("Error: ${response.data['Message']}");
      }
      // isAddress.value = false;
      update();
    } catch (e) {
      print("Error in Fetch Address Data: $e");
      throw Exception("Failed to fetch address data");
    } finally {
      isAddress.value = false;
      update();
    }
  }

  deleteAddressData({String? customerId, String? addressId}) async {
    try {
      final Map<String, dynamic> body = {
        "CustomerId": customerId,
        "AddressId": addressId,
        'FirmId': firmId
      };

      var response =
          await ApiService.post(endpoint: deleteAddressApi, body: body);
      if (response.data['IsSuccess'] == true) {
        int index =
            allAddressList.indexWhere((item) => item.addressId == addressId);
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

  updateAddressData({AddressModel? addressModel, String? addressId}) async {
    try {
      print(addressModel);
      print("Address Id ${addressId}");
      final Map<String, dynamic> body = {
        "CustomerId": addressModel!.customerId,
        "AddressFullName": addressModel.addressFullName,
        "AddressMobileNo": addressModel.addressMobileNo,
        "AddressPincode": addressModel.addressPincode,
        "Address": addressModel.addressColony,
        "AddressLandmark": addressModel.addressLandmark,
        "AddressType": addressModel.addressType,
        "AddressId": addressId,
        'FirmId': firmId
      };
      var response = await ApiService.post(endpoint: updateAddress, body: body);
      print(" Add Update Address data ${response.data}");
      if (response.data['IsSuccess'] == true) {
        int index = allAddressList.indexWhere(
          (element) => element.addressId == addressId,
        );
        // allAddressList[index] = addressModel;
        print(
            "All Address IDs: ${allAddressList.map((e) => e.addressId).toList()}");

        print("Update Address Data ${allAddressList.length}");
        if (index != -1) {
          allAddressList[index] = addressModel;
          print("Updated Address at index $index");
        } else {
          print("No address found with ID $addressId. Skipping update.");
        }
        getAllAddress();
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
  void deleteSelectAddressData(
      {required int customerId, required int addressId}) {
    allAddressList.removeWhere((address) => address.addressId == addressId);
    if (selectedAddressId.value == addressId.toString()) {
      selectedAddressId.value =
          ''; // Selected Address Delete Hua to Clear Karna
    }
  }
}
