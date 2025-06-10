//packages
import 'package:get/get.dart';
//controllers
import 'package:keep_app/controller/networkController.dart';

class DashboardController extends GetxController {
  // getxcontroller instance
  NetworkController networkController = Get.put(NetworkController());

  var tabIndex = 0;

   @override
  void onInit() {
    // TODO: implement onInit
     tabIndex = 0;
     print("tab index ${tabIndex}");
    super.onInit();
  }
  void changeTabIndex(int index) {
    try {
      tabIndex = index;
      update();
    } catch (e) {
      print(e);
    }
  }
}
