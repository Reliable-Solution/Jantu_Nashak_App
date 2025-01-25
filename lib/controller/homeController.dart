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
  // getxcontroller instance
  NetworkController networkController = Get.put(NetworkController());
  SharedHelper helper = SharedHelper();

  var search = TextEditingController();
  var cHomesearch = TextEditingController();
  var deliveryPincode = TextEditingController();

  var fdeliveryPincode = FocusNode();
  var userName = "";
  TabController? myTabController;
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  var activeIndex = 0.obs;
  var categoryCheckBox = false.obs;
  var selectedFilterIndex = 0.obs;
  var sortValue = 1.obs;
  List<Category> categoryList = [];
  List<SubCategory> subCategoryList = [];
  List<ProductModel> productList = [];
  List<OfferModel> offerList = [];
  List<BrandModel> brandList = [];

  PageController filterPage = PageController();
  RxBool isCategory = false.obs;
  changeCategory() {
    try {
      categoryCheckBox.value = !categoryCheckBox.value;
      update();
    } on Exception catch (e) {
      print('Exception -  PaymentController' + e.toString());
    }
  }

  @override
  void onInit() async {
    myTabController = TabController(vsync: this, length: filters.length);
    getPrefs();
    getDashboardData(customerModel!.value.customerId);
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
      print("Phone  Number ${customerModel!.value.customerPhoneNo}");
      print("Phone  Number ${customerModel!.value.customerId}");
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

  final sliderImage = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnpypoGHJOi_GjgqS0jKzaXweNDZE1IaZGXQ&usqp=CAU',
    'https://i.ytimg.com/vi/9Relbr59GX0/maxresdefault.jpg',
    'https://play-lh.googleusercontent.com/N9TPdDLUluBvsOG3wAGsourZ5VspzXqKPqy-L5YvARYXq0jC2qZNUixeXTViDzk-eg4',
    'https://i.ytimg.com/vi/sk56DPAk-1c/maxresdefault.jpg',
  ];

  //pricelist
  final price = [99, 199, 299, 399, 499];



  /// Get dashboard all data
  getDashboardData(String? CustomerId) async {
    categoryList.clear();
    try {
      final Map<String, dynamic> body = {
        'CustomerId': CustomerId,
      };

      var response = await ApiService.post(
          endpoint: getDashboardDataTestByUser, body: body);

      if (response.data['IsSuccess'] == true) {
        print("=========== ${response.data}");
        offerList = (response.data['Data'][0]['Offer'] as List)
            .map((offerJson) => OfferModel.fromJson(offerJson))
            .toList();
        print("============ ${offerList[0].offerCDT}");
        categoryList = (response.data['Data'][1]['Category'] as List)
            .map((categoryJson) => Category.fromJson(categoryJson))
            .toList();
        print("============ ${categoryList[0].categoryName}");

        brandList = (response.data['Data'][2]['Brand'] as List)
            .map((brandJson) => BrandModel.fromJson(brandJson))
            .toList();
        productList = (response.data['Data'][3]['product'] as List)
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList();

        update();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in getDashboard Data: $e");
      throw Exception("Failed to getDashboard Data");
    }
  }
}
