
import 'package:get/get.dart';
import 'package:keep_app/controller/addressController.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/checkoutController.dart';
import 'package:keep_app/controller/editController.dart';
import 'package:keep_app/controller/languageController.dart';
import 'package:keep_app/controller/orderController.dart';
import 'package:keep_app/controller/productDetailController.dart';
import 'package:keep_app/controller/subCategoreyController.dart';
import '../../controller/accountController.dart';
import '../../controller/dashboardController.dart';
import '../../controller/homeController.dart';
import '../../controller/networkController.dart';
import '../../controller/shareProductsController.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController());
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<AccountController>(() => AccountController(), fenix: true);
    Get.lazyPut<ShareProductController>(() => ShareProductController(), fenix: true);
    Get.lazyPut<AddressController>(() => AddressController(), fenix: true);
    Get.lazyPut<ProductDetailsController>(() => ProductDetailsController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
    Get.lazyPut<LanguageController>(() => LanguageController(), fenix: true);
    Get.lazyPut<SubCategoryController>(() => SubCategoryController(), fenix: true);
    Get.lazyPut<CheckoutController>(() => CheckoutController(), fenix: true);
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
    Get.lazyPut<EditProfileController>(() => EditProfileController(), fenix: true);
  }
}
