//flutter
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/constant/api_endpoints.dart';
import 'package:keep_app/controller/networkController.dart';
import 'package:keep_app/models/educationModel.dart';
import 'package:keep_app/models/productModel.dart';
import 'package:keep_app/models/subCategoryModel.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../constant/app_constant.dart';
import '../constant/colorConst.dart';
import '../models/brandModel.dart';
import '../models/categoryModel.dart';
import '../models/customerModel.dart';
import '../models/offerModel.dart';
import '../models/searchModel.dart';
import '../models/tagModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';
import '../utils/string_res.dart';
import '../widget/productDetailView.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  NetworkController networkController = Get.put(NetworkController());
  SharedHelper helper = SharedHelper();
  var isDashBoardLoading = false.obs;
  var isSearchLoading = false.obs;
  var search = TextEditingController();
  var deliveryPincode = TextEditingController();
  var products = <dynamic>[].obs;
  var fdeliveryPincode = FocusNode();
  var userName = "";
  TabController? myTabController;
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  var activeIndex = 0.obs;
  var educationIndex = 0.obs;
  var selectedFilterIndex = 0.obs;
  var sortValue = 1.obs;
  List<CategoryModel> categoryList = [];
  List<SubCategory> subCategoryList = [];
  List<ProductModel> productList = [];
  List<OfferModel> offerList = [];
  List<BrandModel> brandList = [];
  List<ProductModel> searchList = [];
  List<Blogs> blogList = [];
  List<EducationData> educationList = [];
  List<Blogs> searchBlogs = [];
  List<TagModel> tagProductList = [];

  PageController filterPage = PageController();
  RxBool isCategory = false.obs;
  TextEditingController txtFullname = TextEditingController();
  TextEditingController txtMobileno = TextEditingController();
  TextEditingController txtPincode = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtLandmark = TextEditingController();
  TextEditingController txtType = TextEditingController();
  var searchController = TextEditingController();
  CustomerModel? m1 = CustomerModel();
  var searchQuery = ''.obs;
  var speechToText = stt.SpeechToText();

  RxInt indexNew = 0.obs;

  RxBool isBlogSearching = false.obs;
  var currentLabelIndex = 0.obs; // Observable for current label index
   List<String> get searchLabels => [
    StringRes.searchProduct,
    StringRes.searchBrand,
    StringRes.searchInsecticide,
    StringRes.searchSuperKiller,
    StringRes.searchCoragen
    // 'Search Product',
    // 'Search Brand',
    // 'Search Insecticide',
    // 'Search SuperKiller',
    // 'Search Coragen',
  ];
  Timer? _timer;

  List<ProductModel> _allProducts = [];

  List<ProductModel> get allProducts => _allProducts;

  TextEditingController searchBlogController = TextEditingController();

  Map<String, dynamic>? lastJson;

  void collectAllProducts(Map<String, dynamic> json) {
    _allProducts.clear();

    // 1. Direct Product list
    final productList = json['Data']?[4]['Product'] as List<dynamic>? ?? [];
    _allProducts.addAll(productList.map((e) => ProductModel.fromJson(e)));

    // 2. Tag-wise products
    final tagList = json['Data']?[3]['Tag'] as List<dynamic>? ?? [];
    for (var tag in tagList) {
      final products = tag['Products'] as List<dynamic>? ?? [];
      _allProducts.addAll(products.map((e) => ProductModel.fromJson(e)));
    }


    // Remove duplicates (by ProductId)
    final ids = <String>{};
    _allProducts.retainWhere((p) => ids.add(p.productId!));
  }

  @override
  void onClose() {
    _timer?.cancel(); // Clean up timer
    super.onClose();
  }

  // Your existing search methods
  void clearSearch() {
    searchList.clear();
    searchController.clear();
    blogList.clear();
  }

  @override
  void onInit() async {
    myTabController = TabController(vsync: this, length: filters.length);
    m1 = await helper.getCustomer();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      currentLabelIndex.value =
          (currentLabelIndex.value + 1) % searchLabels.length;
    });
    // getDashboardData(m1!.customerId);
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

  HomeController() {
    print("HomeController instance created with hash: ${this.hashCode}");
  }

  Future<void> getPrefs() async {
    CustomerModel? customer = await helper.getCustomer();
    if (customer != null) {
      customerModel!.value = customer;
      print("✅ Name: ${customer.customerName}");
      print("=========> ✅ Name and Points: ${customer.points}");
      print("Controller hash in HomeController: ${this.hashCode}");
      print("Updated Name: ${customer.customerName}");
      update(); // agar tu GetBuilder bhi use kar raha hai
    }
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
    'Combo',
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

   String? languageName = await helper.getStoredString("languageNameFinal");
   print("=========> Language Name HomeScreen ${languageName}");
    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerId,
        'FirmId': firmId,
        "LanguageName":languageName
      };

      // Make the API call
      var response = await ApiService.post(
        endpoint: getDashboardDataTestByUser,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        getEducationData();
        print("API Response: ${response.data}");

        var data = response.data['Data']; // Assuming Data[0] exists

       print("========> Data Type ${data.runtimeType}");
        lastJson = data[0] as Map<String,dynamic>;
        collectAllProducts(lastJson!);
        print("Raw Category Data: ${data[1]['Category']}");
        print(
            "Category Count from API: ${(data[1]['Category'] as List).length}");

        if (data[0]['Offer'] != null) {
          offerList = (data[0]['Offer'] as List)
              .map((offerJson) => OfferModel.fromJson(offerJson))
              .toList();
        }
        if (data[1]['Category'] != null) {
          print(
              "Category Count from API: ${(data[1]['Category'] as List).length}");
          (data[1]['Category'] as List).forEach((category) {
            print(
                "Category ID: ${category['CategoryId']}, Name: ${category['CategoryName']}, FirmId: ${category['FirmId']}");
          });
          categoryList = (data[1]['Category'] as List)
              .map((categoryJson) => CategoryModel.fromJson(categoryJson))
              .toList();
          print("Category list data : ${categoryList.length}");
        }
        if (data[2]['Brand'] != null) {
          brandList = (data[2]['Brand'] as List)
              .map((brandJson) => BrandModel.fromJson(brandJson))
              .toList();
        }
        if (data[3]['Tag'] != null) {
          print(
              "Tag Count from API: ${(data[3]['Tag'] as List).length}"); // Debug log
          tagProductList = (data[3]['Tag'] as List)
              .map((tagJson) => TagModel.fromJson(tagJson))
              .toList();

          print("Tag list data: ${tagProductList.length}"); // Debug log
          // print("Tag list data: ${tagProductList[0].products[0].packInfo[0].}"); // Debug log
        }
        if (data[4]['Product'] != null) {
          productList = (data[4]['Product'] as List)
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

  Future<void> getProductData(String? productId) async {
    productList.clear();


    try {
      final Map<String, dynamic> body = {
        "ProductId":productId
        // 'CustomerId': customerId,
        // 'FirmId': firmId
      };

      // Make the API call
      var response = await ApiService.post(
        endpoint: getProductbyID,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {


        var data = response.data['Data'];
        // if (data[0]['Product'] != null) {
          productList = (data as List)
              .map((productJson) => ProductModel.fromJson(productJson))
              .toList();
        // }
        final product = productList.first;
        Get.to(() => ProductDetailScreen(
          products: product,
          fromDeepLink: true,
        ));
        // isDashBoardLoading.value = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in getDashboardData: $e");
      throw Exception("Failed to get dashboard data: $e");
    }
  }

  getEducationData() async {
    // isSearchLoading.value= true;
    update();
    educationList.clear();

    try {
      final Map<String, dynamic> body = {
        // "CustomerId": customerModel!.value.customerId,
        // "ProductName": productName,
        // 'FirmId':firmId
      };

      var response =
          await ApiService.post(endpoint: getEducationalData, body: body);
      log("Responces education data ${response.data}");
      if (response.data['IsSuccess'] == true) {
        educationList = (response.data['Data'] as List)
            .map((educationJson) => EducationData.fromJson(educationJson))
            .toList();
        print("education data ${educationList.length}");
        update();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in getDashboard Data: $e");
      throw Exception("Failed to getDashboard Data");
      print("Error in Fetch Search Data: $e");
      throw Exception("Failed to fetch Search data");
    } finally {
      print("isSearch print 3 ${isSearchLoading.value}");
      // isSearchLoading.value= false;

      update();
    }
  }

  Future<void> searchBlogsApi(String query) async {
    if (query.isEmpty) {
      searchBlogs.clear();
      return;
    }

    isBlogSearching.value = true; // 🔥 Start loader
    try {
      final body = {
        "search": query,
      };

      final response = await ApiService.post(
        endpoint: searchByBlog,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        print("======= Search Data ${response.data['Data']['blogs']}");
        log("======= Search Data ${response.data['Data']['blogs']}");
        final data = response.data['Data']['blogs'] as List;
        searchBlogs.assignAll(data.map((e) => Blogs.fromJson(e)).toList());
      } else {
        searchBlogs.clear();
      }
    } catch (e) {
      print("Search blogs error: $e");
      searchBlogs.clear();
    } finally {
      isBlogSearching.value = false; // 🔥 Stop loader
    }
  }
  void onSearchChanged(String query) {
    print(" query $query");
    if (query.isEmpty) {
      searchList.clear();
      blogList.clear();
      // isSearchLoading.value = true;
      update();
    }
    searchQuery.value = query;
    getSearchData(query);
  }

  Future<void> startVoiceSearch(BuildContext context) async {
    bool available = await speechToText.initialize();
    if (available) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Listening...",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: COLOR.appBaseColor,
                  child: Icon(Icons.mic, size: 50, color: Colors.white),
                ),
                SizedBox(height: 15),
                Text("Speak now...",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          ),
        ),
      );
      speechToText.listen(onResult: (result) {
        if (result.recognizedWords.isNotEmpty) {
          getSearchData(result.recognizedWords);
          searchController.text = result.recognizedWords;
          Navigator.of(context).pop();
        }
      });
    }
  }

  getSearchData(String productName) async {
    isSearchLoading.value = true;
    update();
    print("isSearch print 1: ${isSearchLoading.value}");

    await Future.delayed(Duration(seconds: 2)); // Increase delay for testing

    // await Future.delayed(Duration(milliseconds: 500)); // Minimum loader time
    if (productName.isEmpty) {
      products.clear();
      isSearchLoading.value = false;
      update();
      return;
    }
    try {
      final Map<String, dynamic> body = {
        "CustomerId": customerModel!.value.customerId,
        "ProductName": productName,
        'FirmId': firmId
      };
      print("isSearch print 2 ${isSearchLoading.value}");

      var response = await ApiService.post(endpoint: searchByUser, body: body);
      if (response.data['IsSuccess'] == true) {
        searchList = (response.data['Data'] as List)
            .map((searchJson) => ProductModel.fromJson(searchJson))
            .toList();
        print("Blog data ${response.data['blog']}");
        blogList =  (response.data['blog'] as List)
            .map((blogJson) => Blogs.fromJson(blogJson))
            .toList();

        print("Search data ${searchList.length}");
        print("======> Blog data ${blogList.length}");
        print("======> Blog data ${blogList.length}");
        isSearchLoading.value = false;
        update();
      } else {
        throw Exception("Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in getDashboard Data: $e");
      throw Exception("Failed to getDashboard Data");
      print("Error in Fetch Search Data: $e");
      throw Exception("Failed to fetch Search data");
    } finally {
      print("isSearch print 3 ${isSearchLoading.value}");

      // update();
      isSearchLoading.value = false;
      // print("isSearch print 4 ${isSearchLoading.value}");

      update();

      print("isSearch print 4 ${isSearchLoading.value}");

      // isLoading(false);
    }
  }
}
