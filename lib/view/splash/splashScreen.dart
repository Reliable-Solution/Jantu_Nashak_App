// // // flutter
// // import 'package:flutter/material.dart';
// // // packages
// // import 'package:get/get.dart';
// // // utils
// // // constants
// // // controllers
// // // theme
// // // widget
// // import 'package:keep_app/controller/splashController.dart';
// // import 'package:keep_app/widget/baseRoute.dart';
// //
// // class SplashScreen extends BaseRoute {
// //   SplashScreen() : super(r: 'SplashScreen2');
// //
// //   final SplashController splashController = Get.put(SplashController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //         body: Center(
// //       child:  ClipRect(
// //         child: Image.asset(
// //         "assets/images/logo.png",
// //         height: MediaQuery.sizeOf(context).height * 0.20,
// //     width: MediaQuery.sizeOf(context).width * 0.5,
// //     fit: BoxFit.fill,
// //     )
// //
// //     )));
// //   }
// // }
//
// import 'dart:async';
// import 'package:circular_reveal_animation/circular_reveal_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:keep_app/view/splash/rotation.dart';
// // import '../../../config.dart';
// import '../../controller/splashController.dart';
// import '../../widget/spacing.dart';
// // import 'splash_controller.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final splash = Get.put(SplashController());
//
//     return Scaffold(
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             GetBuilder<SplashController>(
//                   builder: (splash) =>
//         splash.animation2 != null
//                   ? CircularRevealAnimation(
//                 animation: splash.animation2!,
//                 centerAlignment: Alignment.center,
//                 minRadius: 12,
//                 maxRadius: 600,
//                 child: Container(
//                   color: Colors.white70,
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   child: Opacity(
//                     opacity: 0.35,
//                     child: Image.asset(
//                      'assets/images/logo.png',
//                       // eImageAssets.splashBg,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               )
//                   :  SizedBox()
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const RotationAnimationLayout(),
//                 const VSpace(15),
//                 // Uncomment if needed after animation completion
//                 // SlideTransition(
//                 //   position: Tween<Offset>(
//                 //           begin: const Offset(0, 2), end: const Offset(0, -0.1))
//                 //       .animate(splash.popUpAnimationController!),
//                 //   child: Text(appFonts.fixit,
//                 //       style: appCss.outfitSemiBold45
//                 //           .textColor(appColor(context).whiteColor)),
//                 // )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/controller/editController.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/view/splash/stroreDetection_screen.dart';
// import 'package:flutter_splash/controllers/splash_controller.dart';

import '../../constant/colorConst.dart';
import '../../controller/splashController.dart';
import '../../models/customerModel.dart';
import '../../utils/sharedPrefs.dart';
import '../../utils/string_res.dart';
import '../dashboard/dashboardScreen.dart';
import '../otp/phone_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Initialize the GetX controller
  final SplashController controller = Get.put(SplashController());
  final HomeController homeController = Get.put(HomeController());
  final EditProfileController editProfileController = Get.put(EditProfileController());

  late AnimationController _rotationController;
  late AnimationController _transitionController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoPositionAnimation;
  late Animation<double> _productOpacityAnimation;
  SharedHelper helper = SharedHelper();

  final List<String> _productImages = [
    'assets/images/p1.png',
    'assets/images/p2.png',
    'assets/images/p3.png',
    'assets/images/p4.png',
    'assets/images/p5.png',
    // 'assets/images/p6.png',
  ];

  @override
  void initState() {
    super.initState();

    // Continuous rotation controller
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    // Transition animation controller
    _transitionController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Rotation animation for continuous spinning
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(_rotationController);

    // Logo scale animation starts after delay
    _logoScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.8,
    ).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
      ),
    );

    // Logo position animation moves logo upward
    _logoPositionAnimation = Tween<double>(
      begin: 0.0,
      end: -80.0, // Move up by 80 pixels
    ).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
      ),
    );

    // Product opacity animation fades out products
    _productOpacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _transitionController,
        curve: const Interval(0.5, 0.7, curve: Curves.easeOut),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      _transitionController.forward().then((_) async {
        CustomerModel? customerModel = await helper.getCustomer();

        Future.delayed(const Duration(milliseconds: 500), () async {
          Get.off(
            customerModel == null
                ? LoginScreen()
                : DashboardScreen(pageIndex: 0),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 500),
          );

          // Navigator.of(context).pushReplacement(
          //   PageRouteBuilder(
          //     pageBuilder: (context, animation, secondaryAnimation) => DashboardScreen(pageIndex: 0),
          //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //       return FadeTransition(opacity: animation, child: child);
          //     },
          //     transitionDuration: Duration(milliseconds: 800),
          //   ),
          // );
          editProfileController.GetProfile(customerId: homeController.customerModel!.value.customerId!);
          homeController
              .getDashboardData(homeController.customerModel!.value.customerId);
        });
      });
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.appBaseColor.withOpacity(0.8),
      // Light minimal background
      body: AnimatedBuilder(
        animation:
            Listenable.merge([_rotationController, _transitionController]),
        builder: (context, child) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Rotating products
                // Opacity(
                //   opacity: _productOpacityAnimation.value,
                //   child: _buildRotatingProducts(),
                // ),

                // Brand logo
                Transform.translate(
                  offset: Offset(0, _logoPositionAnimation.value),
                  child: Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.shopping_bag,
                              size: 60,
                              color: Colors.deepPurple,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showStoreDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: StringRes.chooseStore,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox(); // Required for pageBuilder, but we use transitionBuilder.
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue = Curves.easeInOutBack.transform(animation.value);

        return Transform.scale(
          scale: curvedValue,
          child: Opacity(
            opacity: animation.value,
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animated logo
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      StringRes.chooseStore,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.blue, // Button color
                            child: InkWell(
                              splashColor: Colors.red, // Splash color
                              onTap: () {
                                Navigator.pop(context);
                                Get.to(() => LoginScreen());
                              },
                              child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                    'assets/images/logo1.png',
                                  )),
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.blue, // Button color
                            child: InkWell(
                              splashColor: Colors.red, // Splash color
                              onTap: () {
                                Navigator.pop(context);
                                Get.to(() => LoginScreen());
                              },
                              child: SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                    'assets/images/logo2.png',
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRotatingProducts() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double centerX = constraints.maxWidth / 2;
        final double centerY = constraints.maxHeight / 2;
        final double radius = 130.0;

        return Stack(
          alignment: Alignment.center,
          children: List.generate(_productImages.length, (index) {
            final double angle = _rotationAnimation.value +
                (index * (2 * math.pi / _productImages.length));
            final double x = radius * math.cos(angle);
            final double y = radius * math.sin(angle);
            final double z = 100 * math.sin(angle);

            final double scale = _mapRange(z, -100, 100, 0.7, 1.3);
            final double opacity = _mapRange(z, -100, 100, 0.6, 1.0);

            return Positioned(
              left: centerX + x - 30,
              top: centerY + y - 30,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(0.0, 0.0, z)
                  ..scale(scale),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        _productImages[index],
                        width: 60,
                        height: 60,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            _getIconForIndex(index),
                            size: 30,
                            color: _getColorForIndex(index),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  // Helper function to map a value from one range to another
  double _mapRange(
      double value, double min1, double max1, double min2, double max2) {
    return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
  }

  IconData _getIconForIndex(int index) {
    final icons = [
      Icons.checkroom,
      Icons.shopping_bag,
      Icons.face,
      Icons.devices,
      Icons.watch,
      Icons.backpack,
    ];
    return icons[index % icons.length];
  }

  Color _getColorForIndex(int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.pink,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];
    return colors[index % colors.length];
  }
}
