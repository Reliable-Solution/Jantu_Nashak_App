//flutter
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//packages
import 'package:get/get.dart';
import 'package:keep_app/controller/homeController.dart';
//controllers
//models
import 'package:keep_app/controller/networkController.dart';
import 'package:keep_app/models/wishlistModel.dart';

import '../constant/api_endpoints.dart';
import '../constant/app_constant.dart';
import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';

class ShareProductController extends GetxController {
  // getxcontroller instance
  NetworkController networkController = Get.put(NetworkController());
  final HomeController homeController = Get.find<HomeController>();

  // HomeController homeController = Get.put(HomeController());
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  RxList<WishlistModel> wishList = <WishlistModel>[].obs;
  var isReadMore = false;
  var isWishLoading = true;

  TabController? tabController;

  final List<Tab> productsTabs = <Tab>[
    Tab(
      text: "Wishlist",
    ),
    Tab(
      text: "Shared",
    ),
  ];

  @override
  void onInit() async {
    getPrefs();
    super.onInit();
  }

  getPrefs() async {
    SharedHelper helper = SharedHelper();

    CustomerModel? customer = await helper.getCustomer();
    if (customer != null) {
      customerModel!.value = customer;
      getWishListDetails(customer.customerId!);
    }
    update();
  }

  Future<void> addWishlist({required String productId}) async {
    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerModel!.value.customerId,
        'ProductId': productId,
        'FirmId': firmId
      };

      var response = await ApiService.post(
        endpoint: addRemoveWishlist,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        Fluttertoast.showToast(msg: "Product Added To WishList Successfully");
        homeController
            .getDashboardData(homeController.customerModel!.value.customerId);
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in addWishList: $e");
      throw Exception("Failed to add WishList data: $e");
    }
  }

  Future<void> removeWishList({required String productId}) async {
    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerModel!.value.customerId,
        'ProductId': productId,
        'FirmId': firmId
      };

      var response = await ApiService.post(
        endpoint: addRemoveWishlist,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        wishList.removeWhere((item) => item.productId == productId);

        homeController
            .getDashboardData(homeController.customerModel!.value.customerId);

        Fluttertoast.showToast(msg: "Product Removed To WishList Successfully");

        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in  removeWishList: $e");
      throw Exception("Failed to remove WishList  data: $e");
    }
  }

  Future<void> getWishListDetails(String customerID) async {
    // isWishLoading = false;
    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerID,
        'FirmId': firmId
      };

      var response = await ApiService.post(
        endpoint: getWishlistByCustomerId,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        var data = response.data['Data'];

        print("API Response: ${response.data}");
        if (data != null) {
          print("DATA isprint ${data}");
          wishList.value = (data as List)
              .map((productJson) => WishlistModel.fromJson(productJson))
              .toList();
          print("wishlist data ${wishList}");
        }
        isWishLoading = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in getWishListData: $e");
      throw Exception("Failed to get WishList data: $e");
    } finally {
      isWishLoading = false;

      // isAddress.value = false;
      update();
    }
  }


}
