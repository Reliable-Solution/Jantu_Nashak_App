//packages
import 'package:get/get.dart';
import '../constant/api_endpoints.dart';
import '../constant/app_constant.dart';
import '../models/cartDetailModel.dart';
import '../models/customerModel.dart';
import '../models/productModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';
import 'cartController.dart';
import 'networkController.dart';

class ProductDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  NetworkController networkController = Get.put(NetworkController());
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  RxInt selectedSize = 0.obs;
  RxInt selectColor = 0.obs;


  var isReadMore = false;
  int Qty = 0;
  int productQty = 0;
  bool isCartRemoveLoading = false;
  bool isUpdateLoading = false;
  bool isCartLoading = false;
  bool isCart = false;
  RxBool isLoader = false.obs;

  double downloadProgress = 0.0;
  bool isImagesDownloaded = false;
  bool isDescriptionShared = false;
  bool isSharingDescription = false;
  var cartCount = 0.obs; // Cart count as observable



  void add() {
    Qty++;
    update();
  }

  void remove() {
    if (Qty != 0) {
      Qty--;
      update();
    }
  }

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
      print("Product Detail Screen ${customerModel!.value.customerName}");
    }
    update();
  }

  void updateCartCount() {
    cartCount++; // Increase count on add to cart
    update(); // UI refresh
  }


  Future<void> addToCart(ProductModel productModel,String productDetailId ) async {
    try {
      isLoader.value = true;
      print("Add to Cart in ${ isLoader.value}");
      final Map<String, dynamic> body = {
        'CustomerId': customerModel!.value.customerId,
        'ProductId': productModel.productId,
        'ProductdetailId': productDetailId?? productModel.packInfo![0].productdetailId,
        'CartQuantity': "1",
        'FirmId':firmId

      };

      var response = await ApiService.post(
        endpoint: addToCartApi,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        print("Add To Cart API Response: ${response.data}");

         // Get.find<CartController>().cartList.add(CartDetailModel.fromJson(response.data['Data']));
        //
        // ✅ **Cart total aur UI update karo**
        Get.find<CartController>().getCartDetails(
          Get.find<CartController>().customerModel!.value.customerId!,
        );
        Get.find<CartController>().getCartTotal(
          Get.find<CartController>().customerModel!.value.customerId!,
        );
        isLoader.value = false;
        print("Add to Cart out ${ isLoader.value}");


        // isLoader = false.obs;
        // Get.find<CartController>().update();
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in add to cart: $e");
      throw Exception("Failed to add to cart: $e");
    }
  }
  void updateProgress(double progress) {
    downloadProgress = progress;
    update();
  }

  void updateImagesStatus(bool status)
  {
    isImagesDownloaded = status;
    update();
  }

  void updateDescriptionStatus(bool status) {
    isDescriptionShared = status;
    update();
  }

  void startDescriptionSharing() {
    isSharingDescription = true;
    downloadProgress = 0.0; // Reset progress for description
    update();
  }


}
