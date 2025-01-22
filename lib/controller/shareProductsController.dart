//flutter
import 'package:flutter/material.dart';
//packages
import 'package:get/get.dart';
//controllers
//models
import 'package:keep_app/controller/networkController.dart';
import 'package:keep_app/models/wishlistModel.dart';

class ShareProductController extends GetxController with GetSingleTickerProviderStateMixin {
  // getxcontroller instance
  NetworkController networkController = Get.put(NetworkController());

  TabController? tabController;
  //Tab List
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
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  final List<Wishlist> wishlistList = [
    Wishlist(
      id: 1,
      name: 'Myra Fashionable Krutis',
      imageUrl: 'https://images.meesho.com/images/products/236112652/9i5ay_512.jpg', // 'https://www.pinkvilla.com/files/styles/amp_metadata_content_image/public/159963742_1849427255226394_5869188102905440561_n.jpg',
      details: ['Name: Trendy Attractive Kurtis', 'Fabric: Rayon', 'Sleeve Length: Three-Quater sleeves', 'Pattern: Solid', 'Combo of: Single', 'Sizes:\n M,L,XL,XXL', 'Country of Origin: India'],
      price: 490,
      rate: 3.8,
      isFavorite: false,
    ),
    Wishlist(
      id: 2,
      name: 'Classy Partywear Women Ethnic',
      imageUrl: 'https://i.pinimg.com/736x/4a/eb/2d/4aeb2d5b5f6566449f87b46cf40e05fa.jpg',
      details: ['Name: Jivika Sensational Kurtis', 'Fabric: Rayon', 'Sleeve Length: Short Sleeves', 'Pattern: Printed', 'Combo of: Single ', 'Sizes:\n M,L,XL,XXL', 'Country of Origin: India'],
      price: 454,
      rate: 4,
      isFavorite: false,
    ),
    Wishlist(
      id: 2,
      name: 'Classy Partywear Women Ethnic',
      imageUrl: 'https://images.meesho.com/images/products/72603024/lbe1e_512.jpg',
      details: ['Name: Jivika Sensational Kurtis', 'Fabric: Rayon', 'Sleeve Length: Short Sleeves', 'Pattern: Printed', 'Combo of: Single ', 'Sizes:\n M,L,XL,XXL', 'Country of Origin: India'],
      price: 454,
      rate: 4,
      isFavorite: false,
    ),
  ];
}
