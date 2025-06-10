// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../otp/phone_auth.dart';
// // // import 'login_screen.dart';
// //
// // class StoreSelectionScreen extends StatefulWidget {
// //   const StoreSelectionScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<StoreSelectionScreen> createState() => _StoreSelectionScreenState();
// // }
// //
// // class _StoreSelectionScreenState extends State<StoreSelectionScreen>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late Animation<double> _scaleAnimation;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     _controller = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 700),
// //     )..forward();
// //
// //     _scaleAnimation =
// //         CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
// //   }
// //
// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }
// //
// //   Widget buildPopup() {
// //     return ScaleTransition(
// //       scale: _scaleAnimation,
// //       child: AnimatedContainer(
// //         duration: const Duration(milliseconds: 500),
// //         padding: const EdgeInsets.all(20),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(30),
// //           boxShadow: const [
// //             BoxShadow(
// //               blurRadius: 20,
// //               color: Colors.black26,
// //               offset: Offset(0, 10),
// //             )
// //           ],
// //         ),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             // Logo
// //             Container(
// //               width: 80,
// //               height: 80,
// //               padding: const EdgeInsets.all(10),
// //               decoration: const BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 color: Colors.white,
// //               ),
// //               child: Image.asset('assets/images/logo.png'),
// //             ),
// //             const SizedBox(height: 16),
// //             const Text(
// //               'Choose Your Store',
// //               style: TextStyle(
// //                 fontSize: 20,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.deepPurple,
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //
// //             // Row with 2 stores
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 buildStoreButton('assets/images/logo1.png'),
// //                 const SizedBox(width: 20),
// //                 buildStoreButton('assets/images/logo2.png'),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget buildStoreButton(String imagePath) {
// //     return ClipOval(
// //       child: Material(
// //         color: Colors.blue,
// //         child: InkWell(
// //           onTap: () {
// //             Get.to(() =>  LoginScreen());
// //           },
// //           child: SizedBox(
// //             width: 70,
// //             height: 70,
// //             child: Image.asset(imagePath),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.deepPurple.shade50,
// //       body: Center(
// //         child: buildPopup(),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import '../otp/phone_auth.dart';
// // import 'login_screen.dart';
//
// class StoreSelectionDialog extends StatefulWidget {
//   @override
//   _StoreSelectionDialogState createState() => _StoreSelectionDialogState();
// }
//
// class _StoreSelectionDialogState extends State<StoreSelectionDialog> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool _isZoomedIn = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//
//     _animation = TweenSequence<double>([
//       TweenSequenceItem(
//         tween: Tween<double>(begin: 0.0, end: 1.2),
//         weight: 40.0,
//       ),
//       TweenSequenceItem(
//         tween: Tween<double>(begin: 1.2, end: 1.0),
//         weight: 60.0,
//       ),
//     ]).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOutBack,
//     ));
//
//     _controller.forward();
//
//     // Start the zoom in-out animation after initial animation
//     Future.delayed(Duration(seconds: 2), () {
//       _startPulseAnimation();
//     });
//   }
//
//   void _startPulseAnimation() {
//     Future.delayed(Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() {
//           _isZoomedIn = !_isZoomedIn;
//         });
//         _startPulseAnimation();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _navigateToLogin(String store) {
//     Navigator.of(context).push(
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return FadeTransition(opacity: animation, child: child);
//         },
//         transitionDuration: Duration(milliseconds: 500),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black54,
//       body: Center(
//         child: ScaleTransition(
//           scale: _animation,
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 800),
//             curve: Curves.easeInOut,
//             transform: Matrix4.identity()..scale(_isZoomedIn ? 1.05 : 1.0),
//             width: MediaQuery.of(context).size.width * 0.85,
//             height: MediaQuery.of(context).size.height * 0.5,
//             decoration: BoxDecoration(
//               color: Color(0xFF900C3F),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 15,
//                   spreadRadius: 5,
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Select a Store',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildStoreButton(
//                       'Fashion Store',
//                       Icons.shopping_bag,
//                           () => _navigateToLogin('Fashion Store'),
//                     ),
//                     _buildStoreButton(
//                       'Electronics',
//                       Icons.devices,
//                           () => _navigateToLogin('Electronics Store'),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   'Choose your preferred shopping experience',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.white70,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStoreButton(String name, IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         width: 120,
//         height: 120,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 8,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               size: 50,
//               color: Color(0xFF900C3F),
//             ),
//             SizedBox(height: 10),
//             Text(
//               name,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF900C3F),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keep_app/constant/app_constant.dart';
import 'package:keep_app/controller/dashboardController.dart';

import '../../controller/homeController.dart';
import '../../controller/splashController.dart';
import '../../models/customerModel.dart';
import '../../utils/sharedPrefs.dart';
import '../dashboard/dashboardScreen.dart';
import '../otp/phone_auth.dart';
// import 'login_screen.dart';

class StoreSelectionScreen extends StatefulWidget {
  @override
  _StoreSelectionScreenState createState() => _StoreSelectionScreenState();
}

class _StoreSelectionScreenState extends State<StoreSelectionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final controller = Get.put(SplashController());
   final HomeController homeController =
      Get.put(HomeController());


  SharedHelper helper = SharedHelper();


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    // Start the animation after a short delay
    Future.delayed(Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateToLogin(String store,String? firmIdSave) async {
    print("Store button ${store}");
    CustomerModel? customerModel = await helper.getCustomer();
     // Get.put(HomeController());  // Sirf yaha ek baar

    await helper.storeString("firmIdKey", firmIdSave!);
     firmId = firmIdSave ?? '';
    print("Saved firm ID: $firmId");
    DashboardController dashboardController =Get.find();
    dashboardController.tabIndex =0;
    dashboardController.update();
    Get.off(
      customerModel == null
          ? LoginScreen()
          : DashboardScreen(pageIndex: 0),
      transition: Transition.fade,
      duration: const Duration(milliseconds: 500),
    );
    homeController.getDashboardData(customerModel!.customerId);


    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         customerModel == null
    //             ? LoginScreen()
    //             : DashboardScreen(pageIndex: 0),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: animation, child: child);
    //     },
    //     transitionDuration: Duration(milliseconds: 500),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF900C3F),
      body:
      controller.firmList.isEmpty
          ? Center(child: Text('No firms found.',style: TextStyle(color: Colors.white),))

    :  Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select a Store',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF900C3F),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStoreButton(
                      controller.firmList[0].firmName!,
                      controller.firmList[0].firmLogo!,
                      // Icons.shopping_bag,
                          () => _navigateToLogin('Reeya Saree',controller.firmList[0].firmId),
                    ),
                    _buildStoreButton(
                      controller.firmList[1].firmName!,
                      controller.firmList[1].firmLogo!,
                      // Icons.devices,
                          () => _navigateToLogin('Keep Fashion',controller.firmList[1].firmId),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Choose your preferred shopping experience',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoreButton(String name, String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "${IMAGE_URL + image}" ??
                  'http://surti.idnmserver.com/resources/product_no_image.png',
              fit: BoxFit.cover,
              height: 50,
              width: 50,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/images/noInternet.jpg");
              },
            ),
            // Image.asset(
            //   // icon,
            //   image,
            //   // 'assets/images/p1.png',
            //   height: 50,
            //   width: 50,
            //   // size: 50,
            //   // color: Color(0xFF900C3F),
            // ),
            SizedBox(height: 10),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF900C3F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

