// flutter
import 'package:flutter/material.dart';

// package
import 'package:get/get.dart';
import 'package:keep_app/constant/colorConst.dart';
import 'package:keep_app/view/Crop/crop_screen.dart';
import 'package:keep_app/view/home/home_screen.dart';
import 'package:keep_app/view/order/orderScreen.dart';
import 'package:keep_app/view/splash/splashScreen.dart';
import 'package:keep_app/view/splash/stroreDetection_screen.dart';

import '../../controller/dashboardController.dart';
import '../../utils/string_res.dart';
import '../account/account_screen.dart';
import '../store/storeSelection_screen.dart';

class DashboardScreen extends StatelessWidget {
  final int? pageIndex;

  DashboardScreen({@required this.pageIndex, Key? key}) : super(key: key);
  final DashboardController _controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: screens().elementAt(_controller.tabIndex),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.amber),
            child: BottomNavigationBar(
              backgroundColor: COLOR.background,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: COLOR.grey,
              selectedItemColor: COLOR.appBaseColor,
              currentIndex: _controller.tabIndex,
              onTap: _controller.changeTabIndex,
              items: [
                _bottomNavigationBarItem(
                  isStatus: _controller.tabIndex == 0 ? true : false,
                  icon: _controller.tabIndex == 0
                      ? Icons.home
                      : Icons.home_outlined,
                  label: StringRes.home,
                ),
                _bottomNavigationBarItem(
                  isStatus: _controller.tabIndex == 1 ? true : false,
                  icon: _controller.tabIndex == 0
                      ? Icons.menu_book
                      : Icons.menu_book_outlined,
                  label: StringRes.book,
                ),
                _bottomNavigationBarItem(
                  isStatus: _controller.tabIndex == 2 ? true : false,
                  icon: _controller.tabIndex == 0
                      ? Icons.shopping_bag
                      : Icons.shopping_bag_outlined,
                  label: StringRes.orders,
                ),
                // _bottomNavigationBarItem(
                //   icon: _controller.tabIndex == 2 ? Icons.shopping_bag_rounded : Icons.shopping_bag_outlined,
                //   label: 'Orders',
                // ),
                // _bottomNavigationBarItem(
                //   icon: _controller.tabIndex == 3 ? Icons.group_rounded : Icons.group_outlined,
                //   label: 'Community',
                // ),
                // _bottomNavigationBarItem(
                //   isStatus: _controller.tabIndex == 3 ? true : false,
                //   icon: _controller.tabIndex == 4
                //       ? Icons.person
                //       : Icons.person_outline,
                //   label: StringRes.account,
                // )
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> screens() => [
        HomeScreen(),
        CropScreen(),
        // StoreselectionScreen(),
        // CategorieScreen(),
        //OrderScreen(),
        // CommunityScreen(),
        Orderscreen(),
        // AccountScreen()
      ];

  _bottomNavigationBarItem({IconData? icon, String? label,bool isStatus = false}) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
        if(isStatus == true)  Container(
            // color: COLOR.appBaseColor,
            width: 45,
            height: 2,
            decoration: BoxDecoration(
                color: COLOR.appBaseColor,)
                // boxShadow: [BoxShadow(color: COLOR.appBaseColor)],
                // gradient: LinearGradient(colors: [COLOR.appBaseColor],begin:  Alignment(0, 0),stops: [0,0],end: Alignment(0, -))),
          ),
          Icon(icon),
        ],
      ),
      label: label,
      backgroundColor: COLOR.appBaseColor,
    );
  }
}
