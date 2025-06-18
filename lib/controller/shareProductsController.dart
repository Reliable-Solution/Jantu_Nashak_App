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
  Future<void> addWishlist({ required String productId}) async {
    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerModel!.value.customerId,
        'ProductId': productId,
        'FirmId':firmId

      };

      var response = await ApiService.post(
        endpoint: addRemoveWishlist,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {

        Fluttertoast.showToast(msg: "Product Added To WishList Successfully");
        homeController.getDashboardData(homeController.customerModel!.value.customerId);
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
        'FirmId':firmId

      };

      var response = await ApiService.post(
        endpoint: addRemoveWishlist,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        wishList.removeWhere((item) => item.productId == productId);

        homeController.getDashboardData(homeController.customerModel!.value.customerId);

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
        'FirmId':firmId

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
          wishList.value =  (data as List)
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
    }
    finally {
      isWishLoading = false;

      // isAddress.value = false;
      update();
    }

  }


// final List<Wishlist> wishlistList = [
//   Wishlist(
//     id: 1,
//     name: 'Myra Fashionable Krutis',
//     imageUrl: 'https://images.meesho.com/images/products/236112652/9i5ay_512.jpg', // 'https://www.pinkvilla.com/files/styles/amp_metadata_content_image/public/159963742_1849427255226394_5869188102905440561_n.jpg',
//     details: ['Name: Trendy Attractive Kurtis', 'Fabric: Rayon', 'Sleeve Length: Three-Quater sleeves', 'Pattern: Solid', 'Combo of: Single', 'Sizes:\n M,L,XL,XXL', 'Country of Origin: India'],
//     price: 490,
//     rate: 3.8,
//     isFavorite: false,
//   ),
//   Wishlist(
//     id: 2,
//     name: 'Classy Partywear Women Ethnic',
//     imageUrl: 'https://i.pinimg.com/736x/4a/eb/2d/4aeb2d5b5f6566449f87b46cf40e05fa.jpg',
//     details: ['Name: Jivika Sensational Kurtis', 'Fabric: Rayon', 'Sleeve Length: Short Sleeves', 'Pattern: Printed', 'Combo of: Single ', 'Sizes:\n M,L,XL,XXL', 'Country of Origin: India'],
//     price: 454,
//     rate: 4,
//     isFavorite: false,
//   ),
//   Wishlist(
//     id: 2,
//     name: 'Classy Partywear Women Ethnic',
//     imageUrl: 'https://images.meesho.com/images/products/72603024/lbe1e_512.jpg',
//     details: ['Name: Jivika Sensational Kurtis', 'Fabric: Rayon', 'Sleeve Length: Short Sleeves', 'Pattern: Printed', 'Combo of: Single ', 'Sizes:\n M,L,XL,XXL', 'Country of Origin: India'],
//     price: 454,
//     rate: 4,
//     isFavorite: false,
//   ),
// ];
}
