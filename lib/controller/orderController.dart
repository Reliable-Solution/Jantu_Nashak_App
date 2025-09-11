import 'dart:developer';

import 'package:get/get.dart';
import 'package:keep_app/models/orderDetailModel.dart';
import 'package:keep_app/models/orderModel.dart';

import '../constant/api_endpoints.dart';
import '../constant/app_constant.dart';
import '../models/customerModel.dart';
import '../utils/services/api_services.dart';
import '../utils/sharedPrefs.dart';

class OrderController extends GetxController {
  var isLoading = true.obs;
  var isDetailLoading = true.obs;
  RxList<OrderDataModel> orderList = <OrderDataModel>[].obs;
  RxList<OrderDetailData> orderDetailList = <OrderDetailData>[].obs;
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  SharedHelper helper = SharedHelper();

  @override
  void onInit() {
    getPrefs();
    super.onInit();
  }

  getPrefs() async {
    CustomerModel? customer = await helper.getCustomer();
    if (customer != null) {
      customerModel!.value = customer;
      print("Phone  Number ${customerModel!.value.customerName}");

      customerModel!.value = customer;
      print("Phone  Number ${customerModel!.value.customerName}");
      getOrder(customer.customerId);
      // getSubCategoryProduct(categoryId, customerModel!.value.customerId!);
    }
    update();
  }

  Future<void> getOrder(String? customerId) async {
    orderList.clear();
    isLoading.value = true;

    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerId,
        'FirmId': firmId
      };

      // Make the API call
      var response = await ApiService.post(
        endpoint: orderHistory,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        print("API Response: ${response.data}");
        log("API Response: ${response.data}");

        var data = response.data['Data']; // Assuming Data[0] exists

        if (data != null) {
          orderList.value = (data as List)
              .map((orderJson) => OrderDataModel.fromJson(orderJson))
              .toList();
          // orderList.value = (response.data['Data'] as List)
          //     .map((orderJson) => OrderModel.fromJson(orderJson))
          //     .toList();
        }

        isLoading.value = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in subCategoryData: $e");
      throw Exception("Failed to get Sub Category  data: $e");
    }
  }

  Future<void> getOrderDetail(String? orderId) async {
    orderDetailList.clear();
    isDetailLoading.value = true;

    try {
      final Map<String, dynamic> body = {'OrderId': orderId, 'FirmId': firmId};

      // Make the API call
      var response = await ApiService.post(
        endpoint: getOrderdetailByOrderIdV2,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        print("API Response: ${response.data}");
        log("API Response: ${response.data}");

        var data = response.data['Data']; // Assuming Data[0] exists

        print("Order detail data ${data}");
        if (data != null) {
          orderDetailList.value = (data as List)
              .map((orderDetailJson) =>
                  OrderDetailData.fromJson(orderDetailJson))
              .toList();
          // orderList.value = (response.data['Data'] as List)
          //     .map((orderJson) => OrderModel.fromJson(orderJson))
          //     .toList();
        }

        isDetailLoading.value = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in subCategoryData: $e");
      throw Exception("Failed to get Sub Category  data: $e");
    }
  }

  Future<void> cancelOrder(String? customerId, String? orderId) async {
    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerId,
        "OrderId": orderId,
        'FirmId': firmId
      };

      // Make the API call
      var response = await ApiService.post(
        endpoint: cancelOrderProduct,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        print("API Response: ${response.data}");

        var data = response.data['Data']; // Assuming Data[0] exists

        if (data != null) {
          // orderList.removeWhere((order) => order.orderId == orderId);
          Get.snackbar("Success", "Order cancelled successfully");
        }

        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in subCategoryData: $e");
      throw Exception("Failed to get Sub Category  data: $e");
    }
  }
}
