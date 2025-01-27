//flutter
import 'dart:convert';

import 'package:flutter/material.dart';

//packages
import 'package:get/get.dart';
import 'package:keep_app/constant/api_endpoints.dart';
import 'package:keep_app/controller/networkController.dart';
import 'package:keep_app/models/productModel.dart';
import 'package:keep_app/models/subCategoryModel.dart';
import '../models/addressModel.dart';
import '../models/brandModel.dart';
import '../models/categoryModel.dart';
import '../models/customerModel.dart';
import '../models/offerModel.dart';
import '../models/productsModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  NetworkController networkController = Get.put(NetworkController());
  SharedHelper helper = SharedHelper();
  var isDashBoardLoading = false.obs;
  var search = TextEditingController();
  var deliveryPincode = TextEditingController();

  var fdeliveryPincode = FocusNode();
  var userName = "";
  TabController? myTabController;
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  var activeIndex = 0.obs;
  var selectedFilterIndex = 0.obs;
  var sortValue = 1.obs;
  List<Category> categoryList = [];
  List<SubCategory> subCategoryList = [];
  List<ProductModel> productList = [];
  List<OfferModel> offerList = [];
  List<BrandModel> brandList = [];

  PageController filterPage = PageController();
  RxBool isCategory = false.obs;
  TextEditingController txtFullname = TextEditingController();
  TextEditingController txtMobileno = TextEditingController();
  TextEditingController txtPincode = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtLandmark = TextEditingController();
  TextEditingController txtType = TextEditingController();
  CustomerModel? m1 = CustomerModel();


  @override
  void onInit() async {
    myTabController = TabController(vsync: this, length: filters.length);
    m1 = await helper.getCustomer();
    getDashboardData(m1!.customerId);
    getPrefs();
    // fetchCategoryData();
    super.onInit();
  }

  @override
  void dispose() {
    myTabController!.dispose();
    filterPage.dispose();
    super.dispose();
  }

  getPrefs() async {
    CustomerModel? customer = await helper.getCustomer();
    if (customer != null) {
      customerModel!.value = customer;
      print("Phone  Number ${customerModel!.value.customerName}");
    }
    update();
  }

  List<String> filters = [
    'Category',
    'Gender',
    'Fabric',
    'Color',
    'Price',
    'Discount',
    'Rating',
    'Size',
    'Combo'
        'Material',
    'Bottom Length',
    'Bottom Style',
    'Bottomwear Fabric',
    'Ornmentation'
  ];




  //pricelist
  final price = [99, 199, 299, 399, 499];


  /// Get dashboard all data
  Future<void> getDashboardData(String? customerId) async {
    // Ensure lists are empty before populating them
    categoryList.clear();
    offerList.clear();
    brandList.clear();
    productList.clear();

    isDashBoardLoading.value = true;

    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerId,
      };

      // Make the API call
      var response = await ApiService.post(
        endpoint: getDashboardDataTestByUser,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        print("API Response: ${response.data}");


        var data = response.data['Data']; // Assuming Data[0] exists

        if (data[0]['Offer'] != null) {
          offerList = (data[0]['Offer'] as List)
              .map((offerJson) => OfferModel.fromJson(offerJson))
              .toList();
        }
        if (data[1]['Category'] != null) {
          categoryList = (data[1]['Category'] as List)
              .map((categoryJson) => Category.fromJson(categoryJson))
              .toList();
        }
        if (data[2]['Brand'] != null) {
          brandList = (data[2]['Brand'] as List)
              .map((brandJson) => BrandModel.fromJson(brandJson))
              .toList();
        }
        if (data[3]['product'] != null) {
          productList = (data[3]['product'] as List)
              .map((productJson) => ProductModel.fromJson(productJson))
              .toList();
        }
        isDashBoardLoading.value = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in getDashboardData: $e");
      throw Exception("Failed to get dashboard data: $e");
    }
  }
}