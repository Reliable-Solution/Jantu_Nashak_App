//flutter
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/constant/api_endpoints.dart';
import 'package:keep_app/controller/networkController.dart';
import 'package:keep_app/models/productModel.dart';
import 'package:keep_app/models/subCategoryModel.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../constant/colorConst.dart';
import '../models/brandModel.dart';
import '../models/categoryModel.dart';
import '../models/customerModel.dart';
import '../models/offerModel.dart';
import '../models/searchModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  NetworkController networkController = Get.put(NetworkController());
  SharedHelper helper = SharedHelper();
  var isDashBoardLoading = false.obs;
  var isLoading = false.obs;
  var search = TextEditingController();
  var deliveryPincode = TextEditingController();
  var products = <dynamic>[].obs;
  var fdeliveryPincode = FocusNode();
  var userName = "";
  TabController? myTabController;
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  var activeIndex = 0.obs;
  var selectedFilterIndex = 0.obs;
  var sortValue = 1.obs;
  List<CategoryModel> categoryList = [];
  List<SubCategory> subCategoryList = [];
  List<ProductModel> productList = [];
  List<OfferModel> offerList = [];
  List<BrandModel> brandList = [];
  List<ProductModel> searchList = [];

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
              .map((categoryJson) => CategoryModel.fromJson(categoryJson))
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

  void onSearchChanged(String query) {
    print(" query $query");
    if (query.isEmpty) {
      searchList.clear();
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
    if (productName.isEmpty) {
      products.clear();
      return;
    }
    try {
      isLoading(true);
      final Map<String, dynamic> body = {
        "CustomerId": customerModel!.value.customerId,
        "ProductName": productName,
      };

      var response = await ApiService.post(endpoint: searchByUser, body: body);
      if (response.data['IsSuccess'] == true) {
        searchList = (response.data['Data'] as List)
            .map((searchJson) => ProductModel.fromJson(searchJson))
            .toList();
        print("Search data ${searchList.length}");
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
      isLoading(false);
    }
  }
}
