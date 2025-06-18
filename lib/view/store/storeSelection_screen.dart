import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/colorConst.dart';
import '../../utils/string_res.dart';
import '../splash/splashScreen.dart';

class StoreselectionScreen extends StatefulWidget {
  const StoreselectionScreen({super.key});

  @override
  State<StoreselectionScreen> createState() => _StoreselectionScreenState();
}

class _StoreselectionScreenState extends State<StoreselectionScreen>  with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..forward();

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirmStoreSwitch() {
    Get.defaultDialog(
      title: StringRes.chooseStore,
      middleText: 'Are you sure you want to switch to Store?',
      textConfirm: 'YES',
      textCancel: 'NO',
      confirmTextColor: Colors.white,
      buttonColor: Colors.deepPurple,
      onConfirm: () {
        Get.back();
        Get.offAll(() => SplashScreen());
      },
      onCancel: () {},
    );
  }

  // Widget _buildStoreButton(String storeName, String imagePath) {
  //   return GestureDetector(
  //     onTap: () => _confirmStoreSwitch(storeName),
  //     child: Container(
  //       width: 110,
  //       height: 120,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(15),
  //         boxShadow: [
  //           BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
  //         ],
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Image.asset(imagePath, height: 50, width: 50),
  //           SizedBox(height: 10),
  //           Text(
  //             storeName,
  //             style: TextStyle(
  //               fontSize: 15,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.deepPurple,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.appBaseColor,
      body:
      Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child:
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text(
                  StringRes.switchStore,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                 Text(
                  StringRes.confirmSwitchStore,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: COLOR.appBaseColor,
                      ),
                      onPressed: (){
                        Get.offAll(() => SplashScreen());
                      },
                      child:  Text(StringRes.yes, style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                      ),
                      onPressed: () => Get.back(),
                      child:  Text(StringRes.no, style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),



              ],
            ),
          ),
        ),
      ),
    );
// Get.defaultDialog(
    // title: 'Switch Store?',
    //   middleText: 'Are you sure you want to switch to Store?',
    //   textConfirm: 'YES',
    //   textCancel: 'NO',
    //   confirmTextColor: Colors.white,
    //   buttonColor: Colors.deepPurple,
    //   onConfirm: () {
    //     Get.back();
    //     Get.offAll(() => SplashScreen());
    //   },
    //   onCancel: () {},
    // )
    // Column(
    //     children: [],
    //   ),
    // );
  }
}
