import 'package:get/get.dart';
import 'package:keep_app/models/productModel.dart';

import '../constant/api_endpoints.dart';
import '../models/customerModel.dart';
import '../models/subCategoryModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';
import 'networkController.dart';

class SubCategoryController extends GetxController {
  NetworkController networkController = Get.put(NetworkController());
  List<SubCategory> subCategoryList = [];
  List<ProductModel> categoryProductList = [];
  List<ProductModel> subCategoryProductList = [];
  SharedHelper helper = SharedHelper();
  RxBool isLoading = false.obs;
  RxBool isCategoryProduct = false.obs;
  RxBool isSubCategoryProduct = false.obs;
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  CustomerModel? m1 = CustomerModel();


  @override
  void onInit() async {
    super.onInit();
  }

  getPrefs(String? categoryId) async {
    CustomerModel? customer = await helper.getCustomer();
    if (customer != null) {
      customerModel!.value = customer;
      print("Phone  Number ${customerModel!.value.customerName}");

        customerModel!.value = customer;
        print("Phone  Number ${customerModel!.value.customerName}");
        getProductCategoryData(categoryId, customerModel!.value.customerId!);
        // getSubCategoryProduct(categoryId, customerModel!.value.customerId!);


    }
    update();
  }


  Future<void> getSubCategoryData(String? categoryId) async {
    subCategoryList.clear();
    isLoading.value = true;

    try {
      final Map<String, dynamic> body = {
        'CategoryId': categoryId,
      };

      // Make the API call
      var response = await ApiService.post(
        endpoint: getSubcategorybyCategoryId,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        print("API Response: ${response.data}");

        var data = response.data['Data']; // Assuming Data[0] exists

        if (data != null) {
          subCategoryList = (response.data['Data'] as List)
              .map((subCategoryJson) => SubCategory.fromJson(subCategoryJson))
              .toList();
        }

        isLoading.value = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in subCategoryData: $e");
      throw Exception("Failed to get Sub Category  data: $e");
    }
  }

  Future<void> getProductCategoryData(String? categoryId,String customerId) async {
    categoryProductList.clear();
    isCategoryProduct.value = true;

    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerId,
        'CategoryId': categoryId,
      };

      // Make the API call
      var response = await ApiService.post(
        endpoint: getProductByCategoryId,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        print("API Response: ${response.data}");

        var data = response.data['Data']; // Assuming Data[0] exists

        if (data != null) {
          categoryProductList = (response.data['Data'] as List)
              .map((productJson) => ProductModel.fromJson(productJson))
              .toList();
        }

        isCategoryProduct.value = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in categoryProductData: $e");
      throw Exception("Failed to get category Product data: $e");
    }
  }

  Future<void> getSubCategoryProduct(String? subCategoryId) async {
    subCategoryProductList.clear();

    isSubCategoryProduct.value = true;

    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerModel!.value.customerId,
        'SubcategoryId': subCategoryId,
      };

      // Make the API call
      var response = await ApiService.post(
        endpoint: getProductbySubcategoryId,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        print("API Response: ${response.data}");

        var data = response.data['Data']; // Assuming Data[0] exists

        if (data != null) {
          subCategoryProductList = (response.data['Data'] as List)
              .map((productJson) => ProductModel.fromJson(productJson))
              .toList();
        }

        isSubCategoryProduct.value = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in subCategoryProductData: $e");
      throw Exception("Failed to get Sub Category Product data: $e");
    }
  }
}
