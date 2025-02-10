import 'package:get/get.dart';
import 'package:keep_app/models/getCartTotalModel.dart';

import '../constant/api_endpoints.dart';
import '../models/cartDetailModel.dart';
import '../models/customerModel.dart';
import '../models/productModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';
import 'networkController.dart';

class CartController extends GetxController {
  NetworkController networkController = Get.put(NetworkController());
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  Rx<CartTotal>? cartTotal = CartTotal().obs;
  List<CartDetailModel> cartList = [];

  var isReadMore = false;
  var isCartLoading = false;

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
      getCartDetails(customer.customerId!);
      getCartTotal(customer.customerId!);
    }
    update();
  }

  updateCartTotal(CartTotal value) {
    cartTotal!.value = value;
    update();
  }

  Future<void> getCartDetails(String customerID) async {
    isCartLoading = false;
    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerID,
      };

      var response = await ApiService.post(
        endpoint: getCartDetailApi,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        var data = response.data['Data'];

        print("API Response: ${response.data}");
        if (data[0]['Cart'] != null) {
          cartList = (data[0]['Cart'] as List)
              .map((productJson) => CartDetailModel.fromJson(productJson))
              .toList();
        }
        isCartLoading = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in getDashboardData: $e");
      throw Exception("Failed to get dashboard data: $e");
    }
  }

  Future<void> updateCartQty(String cartID, String cartQuantity) async {
    try {
      final Map<String, dynamic> body = {
        'CartId': cartID,
        'CartQuantity': cartQuantity,
      };

      var response = await ApiService.post(
        endpoint: updateCartQtyApi,
        body: body,
      );
      if (response.data['IsSuccess'] == true) {
        getCartTotal(customerModel!.value.customerId!);
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in Cart: $e");
      throw Exception("Failed to update cart data: $e");
    }
  }

  Future<void> removeFromCart({required String cartID}) async {
    try {
      final Map<String, dynamic> body = {
        'CartId': cartID,
      };

      var response = await ApiService.post(
        endpoint: removeCartApi,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in Cart: $e");
      throw Exception("Failed to remove cart data: $e");
    }
  }

  Future<void> getCartTotal(String customerID) async {
    isCartLoading = false;
    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerID,
      };

      var response = await ApiService.post(
        endpoint: getCartTotalWithDeliveryChargeV2Api,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        var data = response.data['Data'];

        print("API Response: ${response.data}");
        if (data[0] != null) {
          updateCartTotal(CartTotal.fromJson(data[0]));
        }
        isCartLoading = false;
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
