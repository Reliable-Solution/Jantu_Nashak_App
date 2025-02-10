//packages
import 'package:get/get.dart';
import '../constant/api_endpoints.dart';
import '../models/customerModel.dart';
import '../models/productModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';
import 'networkController.dart';

class ProductDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  NetworkController networkController = Get.put(NetworkController());
  Rx<CustomerModel>? customerModel = CustomerModel().obs;

  var isReadMore = false;
  int Qty = 0;
  int productQty = 0;
  bool isCartRemoveLoading = false;
  bool isUpdateLoading = false;
  bool isCartLoading = false;
  bool isCart = false;

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

  Future<void> addToCart(ProductModel productModel) async {
    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerModel!.value.customerId,
        'ProductId': productModel.productId,
        'ProductdetailId': productModel.packInfo![0].productdetailId,
        'CartQuantity': "1",
      };

      var response = await ApiService.post(
        endpoint: addToCartApi,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        print("API Response: ${response.data}");

        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in add to cart: $e");
      throw Exception("Failed to add to cart: $e");
    }
  }


}
