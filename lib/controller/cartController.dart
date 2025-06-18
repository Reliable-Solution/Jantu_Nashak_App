import 'dart:developer';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/models/getCartTotalModel.dart';

import '../constant/api_endpoints.dart';
import '../constant/app_constant.dart';
import '../models/cartDetailModel.dart';
import '../models/customerModel.dart';
import '../models/productModel.dart';
import '../utils/services/api_services.dart';
import '../utils/services/services.dart';
import '../utils/sharedPrefs.dart';
import 'networkController.dart';

class CartController extends GetxController {
  NetworkController networkController = Get.put(NetworkController());
  final HomeController homeController = Get.find<HomeController>();

  // HomeController homeController = Get.put(HomeController());
  Rx<CustomerModel>? customerModel = CustomerModel().obs;
  // Rx<CartTotal?> cartTotal = Rx<CartTotal?>(null);
  final Rx<CartTotal> cartTotal = CartTotal().obs;
  RxList<CartDetailModel> cartList = <CartDetailModel>[].obs;
  RxInt cartCount = 0.obs;
  RxBool isUpdateLoading = false.obs;
  RxBool isCartRemoveLoading = false.obs;



  var isReadMore = false;
  RxBool isCartLoading = false.obs;

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
      print("Pro"
          ""
          "duct Detail Screen ${customerModel!.value.customerName}");
      // await Future.delayed(Duration(seconds: 10)); // ⏳ delay for 2 seconds

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
    isCartLoading.value = true;

    cartList.clear();
    // await Future.delayed(Duration(seconds: 2)); // ⏳ delay for 2 seconds

    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerID,
        'FirmId':firmId

      };

      var response = await ApiService.post(
        endpoint: getCartDetailApi,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        var data = response.data['Data'];

        print("API Response: ${response.data}");
        if (data[0]['Cart'] != null) {
          cartList.value = (data[0]['Cart'] as List).map((productJson) => CartDetailModel.fromJson(productJson)).toList();
        }
        isCartLoading.value = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
     } catch (e) {
      print("Failed to fetch cart: $e");
  Get.snackbar('Error', 'Failed to fetch cart: $e');
  } finally {
  isCartLoading.value = false;
  }
    // catch (e) {
    //   print("Error in getDashboardData: $e");
    //   throw Exception("Failed to get dashboard data: $e");
    // }
  }

  // updateCartQty(String cartID, String cartQuantity) async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       // setState(() {
  //         isUpdateLoading.value = true;
  //       // });
  //         final Map<String, dynamic> body = {
  //           'CartId': cartID,
  //           'CartQuantity': cartQuantity,
  //         };
  //       // FormData body = FormData.fromMap(
  //       //     {"CartId": "", "CartQuantity": });
  //       Services.postForSave(apiName: 'updateCartQty', body: body).then(
  //               (responseList) async {
  //             if (responseList.IsSuccess == true && responseList.Data == "1") {
  //               // setState(() {
  //                 log("update");
  //                 isUpdateLoading.value = false;
  //               // });
  //               // widget.onQtyUpdate!();
  //             } else {
  //               // setState(() {
  //                 isUpdateLoading.value = false;
  //               // });
  //               Fluttertoast.showToast(msg: "Something went wrong");
  //               //show "data not found" in dialog
  //             }
  //           }, onError: (e) {
  //         // setState(() {
  //           isUpdateLoading.value = false;
  //         // });
  //         log("error on call -> ${e.message}");
  //         Fluttertoast.showToast(msg: "Something Went Wrong");
  //       });
  //     }
  //   } on SocketException catch (_) {
  //     Fluttertoast.showToast(msg: "No Internet Connection.");
  //   }
  // }
  Future<void> updateCartQty(String cartID, String cartQuantity) async {
    try {
      final Map<String, dynamic> body = {
        'CartId': cartID,
        'CartQuantity': cartQuantity,
        'FirmId':firmId

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


//   removeFromCart({required String cartID}) async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         // setState(() {
//           isCartRemoveLoading.value = true;
//         // });
//           final Map<String, dynamic> body = {
//             'CartId': cartID,
//           };
//         // FormData body =
//         // FormData.fromMap({"CartId": "${widget.cartData["CartId"]}"});
//         Services.postForSave(apiName: '/removeCart', body: body).then(
//                 (responseRemove) async {
//               if (responseRemove.IsSuccess == true && responseRemove.Data == "1") {
//                 // widget.onRemove!();
//                 // Provider.of<CartProvider>(context, listen: false).decreaseCart(
//                 //     productId: int.parse(widget.cartData["ProductId"]));
//                 // setState(() {
//                   isCartRemoveLoading.value = false;
//                 // });
//                 // widget.onQtyUpdate!();
//                 Fluttertoast.showToast(
//                     msg: "Product Removed Successfully",
//                     gravity: ToastGravity.BOTTOM);
//               }
//             }, onError: (e) {
//           // setState(() {
//             isCartRemoveLoading.value = false;
//           // });
//           log("error on call -> ${e.message}");
//           Fluttertoast.showToast(msg: "something went wrong");
//         });
//       }
//     } on SocketException catch (_) {
//       Fluttertoast.showToast(msg: "No Internet Connection");
// //      showMsg("No Internet Connection.");
//     }
//   }

  Future<void> removeFromCart({required String cartID}) async {
    try {
      final Map<String, dynamic> body = {
        'CartId': cartID,
        'FirmId':firmId

      };

      var response = await ApiService.post(
        endpoint: removeCartApi,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        homeController.getDashboardData(customerModel!.value.customerId);
        getCartTotal(customerModel!.value.customerId!);
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in Cart: $e");
      throw Exception("Failed to remove cart data: $e");
    }
  }

  Future<void> getCartTotal(customerID) async {
    isCartLoading.value = false;
    try {
      final Map<String, dynamic> body = {
        'CustomerId': customerID,
        'Points':"",
        'FirmId':firmId
      };

      var response = await ApiService.post(
        endpoint: getCartTotalWithDeliveryChargeV2Api,
        body: body,
      );

      if (response.data['IsSuccess'] == true) {
        var data = response.data['Data'];
        print("API Response: ${response.data}");

        if (data != null && data is List && data.isNotEmpty) {
          updateCartTotal(CartTotal.fromJson(data[0]));
        } else {
          print("No cart data available.");
          // You can call updateCartTotal with default or empty object if needed
          // updateCartTotal(CartTotal.empty());
        }

        // var data = response.data['Data'];
        //
        // print("API Response: ${response.data}");
        // if (data[0] != null) {
        //   updateCartTotal(CartTotal.fromJson(data[0]));
        // }
        isCartLoading.value = false;
        update();
      } else {
        throw Exception("Error from API: ${response.data['Message']}");
      }
    } catch (e) {
      print("Error in getCartDetailData: $e");
        throw Exception("Failed to get cart data: $e");
    }
  }
}
