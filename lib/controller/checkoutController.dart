import 'dart:developer';

import 'package:get/get.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/editController.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/view/dashboard/dashboardScreen.dart';
import 'package:keep_app/view/sucess/payment_sucess.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_constant.dart';
import '../models/PaymenntModel.dart';
import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
import '../constant/api_endpoints.dart';
import '../utils/sharedPrefs.dart';
import '../view/home/home_screen.dart';

class CheckoutController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  CartController cartController = Get.find<CartController>();
  EditProfileController editProfileController = Get.find<EditProfileController>();
  RxString selectedPaymentMethod = ''.obs; // Default: Cash on Delivery
  RxBool isOnlineExpanded = false.obs; // Online Payment Section Expand/Collapse
  RxBool isLoading = false.obs;
  RxBool isSelected = false.obs;
  RxString selectedPayment = 'Razorpay'.obs;
  List<PaymentGateway> paymentMethodList = [];
  PaymentGateway? paymentGateway;
  SharedHelper helper = SharedHelper();
  // SharedPreferences helper = await SharedPreferences.getInstance();

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
    // isOnlineExpanded.value = (method == 'ONLINE'); // Expand   only if online selected
    isOnlineExpanded.value = (method.toLowerCase() == 'online');
    update();
  }

  void selectPaymentGateWay(PaymentGateway payment) {
    paymentGateway = payment;
    update();
  }

  Future<void> placeOrderCheckout({
    required String customerId,
    required String addressId,
    required String orderPaymentMethod,
    String? orderTransactionNo,
  }) async {
    isLoading.value = true;

    try {
      final Map<String, dynamic> body = {
        "CustomerId": customerId,
        "TotPoint": cartController.redeemPointsController.text,
        "Points": cartController.redeemPointsController.text.isEmpty ?false : true,
        "AddressId": addressId,
        "OrderPaymentMethod": orderPaymentMethod,
        "OrderTransactionNo": orderTransactionNo ?? "",
        'FirmId': firmId
      };

      var response = await ApiService.post(
        endpoint: placeOrder,
        body: body,
      );

      print("============== Place Order Data ${response.data}");
      if (response.data['IsSuccess'] == true) {
        print("Order Placed Successfully: ${response.data}");

        // Show success message
        // Get.snackbar("Success", "Your order has been placed!");
        // homeController.getDashboardData(customerId);
        editProfileController.GetProfile(customerId: customerId);
        homeController.getPrefs();
        // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        CustomerModel? customer =  await helper.getCustomer();
        print("==============> CHECKOUT Screen Point Get By Customer Id : ${homeController.customerModel!.value.points}");
        print("==============> CHECKOUT Screen Point Get By Customer Id : ${customer!.points}");
        if (customer != null) {
          homeController.customerModel!.value = customer;
        }
        print("==============> CHECKOUT Screen Point Get By Customer Id : ${homeController.customerModel!.value.points}");
        homeController.getDashboardData(customerId);

        Get.snackbar("Success", "Your order has been placed!");
        Get.offAll(PaymentSucess());
      } else {
        throw Exception("API Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Checkout Error: $e");
      Get.snackbar("Error", "Failed to place order: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> getPaymentMethod() async {
    isLoading.value = true;

    try {
      final Map<String, dynamic> body = {"FirmId": firmId};

      var response = await ApiService.post(
        endpoint: get_active_payment_gateways,
        body: body,
      );

      print("============== Payment Method Data ${response.data}");
      if (response.data['IsSuccess'] == true) {
        print("Payment Method  : ${response.data}");

        print("API Response: ${response.data}");
        log("API Response: ${response.data}");

        final dynamic rawData = response.data['Data'];

        if (rawData is List) {
          paymentMethodList = rawData
              .map((e) {
                try {
                  return PaymentGateway.fromJson(e);
                } catch (err) {
                  log("❌ Parsing error on item: $e \nError: $err");
                  return null;
                }
              })
              .whereType<PaymentGateway>()
              .toList();
        } else {
          log("❌ 'Data' is not a List: $rawData");
        }
        update();
      } else {
        throw Exception("API Error: ${response.data['Message']}");
      }
    } catch (e) {
      print("Payment Method Error: $e");
      Get.snackbar("Error", "Failed to Payment Method: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
