//packages
import 'package:get/get.dart';
//controllers
import 'package:keep_app/controller/networkController.dart';

class DashboardController extends GetxController {
  // getxcontroller instance
  NetworkController networkController = Get.put(NetworkController());

  var tabIndex = 0;

  void changeTabIndex(int index) {
    try {
      tabIndex = index;
      update();
    } catch (e) {
      print(e);
    }
  }
}
