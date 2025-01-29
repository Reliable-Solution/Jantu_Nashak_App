
import 'package:get/get.dart';
import 'package:keep_app/controller/addressController.dart';
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
  }
}
