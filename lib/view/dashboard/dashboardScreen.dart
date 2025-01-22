// flutter
import 'package:flutter/material.dart';
// package
import 'package:get/get.dart';
// constants
// import 'package:getxnative/constants/colorConst.dart';
// // controllers
// import 'package:getxnative/controllers/dashboardController.dart';
// // views
// import 'package:getxnative/views/account/accountScreen.dart';
// import 'package:getxnative/views/categories/categorieScreen.dart';
// import 'package:getxnative/views/community/communityScreen.dart';
// import 'package:getxnative/views/home/homeScreen.dart';
// import 'package:getxnative/views/orders/orderScreen.dart';
import 'package:keep_app/constant/colorConst.dart';
// import 'package:keep_app/controller/dashboardController.dart';
import 'package:keep_app/view/home/home_screen.dart';

import '../../controller/dashboardController.dart';

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
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: COLOR.background,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: COLOR.grey,
            selectedItemColor: COLOR.pink,
            currentIndex: _controller.tabIndex,
              onTap: _controller.changeTabIndex,
            items: [
              _bottomNavigationBarItem(
                icon: _controller.tabIndex == 0 ? Icons.home : Icons.home_outlined,
                label: 'Home',
              ),
              // _bottomNavigationBarItem(
              //   icon: _controller.tabIndex == 1 ? Icons.grid_view_rounded : Icons.grid_view,
              //   label: 'Categories',
              // ),
              // _bottomNavigationBarItem(
              //   icon: _controller.tabIndex == 2 ? Icons.shopping_bag_rounded : Icons.shopping_bag_outlined,
              //   label: 'Orders',
              // ),
              // _bottomNavigationBarItem(
              //   icon: _controller.tabIndex == 3 ? Icons.group_rounded : Icons.group_outlined,
              //   label: 'Community',
              // ),
              _bottomNavigationBarItem(
                icon: _controller.tabIndex == 4 ? Icons.person : Icons.person_outline,
                label: 'Account',
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> screens() => [HomeScreen(),
     // CategorieScreen(),
    //OrderScreen(), CommunityScreen(),
    //  AccountScreen()
  ];
  _bottomNavigationBarItem({IconData? icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
      backgroundColor: COLOR.pink,
    );
  }
}
