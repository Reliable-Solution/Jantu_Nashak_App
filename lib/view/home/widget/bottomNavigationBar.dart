// //flutter
// import 'package:flutter/material.dart';
// //constants
// import 'package:getxnative/constants/colorConst.dart';
// // controllers
// import 'package:getxnative/controllers/homeController.dart';
//
// class BottomNavigation extends StatelessWidget {
//   const BottomNavigation({
//     Key? key,
//     @required this.homeController,
//   }) : super(key: key);
//
//   final HomeController? homeController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.11,
//       width: MediaQuery.of(context).size.width,
//       child: BottomNavigationBar(
//         backgroundColor: COLOR.background,
//         type: BottomNavigationBarType.fixed,
//         unselectedItemColor: COLOR.grey,
//         selectedItemColor: COLOR.pink,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: [BottomNavigationBarItem(icon: Icon(Icons.add)), BottomNavigationBarItem(icon: Icon(Icons.add))],
//       ),
//     );
//   }
// }
