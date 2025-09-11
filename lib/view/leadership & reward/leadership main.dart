import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keep_app/utils/string_res.dart';
import 'package:keep_app/view/leadership%20&%20reward/reward.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/colorConst.dart';
import 'leadership.dart';

// import 'constant/colorConst.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Tabs Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: TabMainScreen(),
//     );
//   }
// }

/* -------------------------------------------------
   Tab Main Screen
-------------------------------------------------- */
class TabMainScreen extends StatefulWidget {
  const TabMainScreen({super.key});

  @override
  State<TabMainScreen> createState() => _TabMainScreenState();
}

class _TabMainScreenState extends State<TabMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: COLOR.appBaseColor,
          leading: IconButton(onPressed: () {

            Get.back();
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
          title:  Text(
            StringRes.leaderShipRewards,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs:  [
              Tab(text: StringRes.leadership),
              Tab(text: StringRes.rewards),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            LeadershipScreen(),
            RewardScreen(),
          ],
        ),
      ),
    );
  }
}
