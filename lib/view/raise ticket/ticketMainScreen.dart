import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/view/raise%20ticket/ticketMainViewScreen.dart';
// import 'package:suratjugaad/Screens/setting_tab/ticket/create_complain_screen.dart';
// import 'package:suratjugaad/Screens/setting_tab/ticket/ticket_view_screen.dart';
// import 'package:suratjugaad/a_structure/constant/app_styles.dart';
// import 'package:suratjugaad/Common/StringRes.dart';

import '../../utils/string_res.dart';
import 'app_style.dart';
import 'create_ticket.dart';

class TicketMainScreen extends StatefulWidget {
  const TicketMainScreen({super.key});

  static Widget create() {
    return const TicketMainScreen();
  }

  @override
  State<TicketMainScreen> createState() => _TicketMainScreenState();
}

class _TicketMainScreenState extends State<TicketMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final RxInt tabIndex = 0.obs; // Reactive tab index

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // Sync TabController with tabIndex
    tabController.addListener(() {
      if (tabController.index != tabIndex.value) {
        tabIndex.value = tabController.index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        // leading: InkWell(
        //   onTap: () {
        //     Get.back(); // Use GetX navigation
        //   },
        //   child: Icon(Icons.arrow_back),
        // ),
        title: Text(
          StringRes.ticket,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        bottom: TabBar(
          controller: tabController,
          automaticIndicatorColorAdjustment: true,
          indicatorColor: AppStyles.secondaryColor,
          labelColor: AppStyles.white,
          padding: EdgeInsets.zero,
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(text: StringRes.raiseTicket),
            Tab(text: StringRes.viewTicket),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CreateComplainScreen(), // GetX-compatible
          TicketViewScreen(), // Assumes GetX-compatible
        ],
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    tabIndex.close(); // Dispose Rx variable
    super.dispose();
  }
}
