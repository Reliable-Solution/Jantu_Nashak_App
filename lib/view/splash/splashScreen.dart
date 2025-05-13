

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_splash/controllers/splash_controller.dart';

import '../../constant/colorConst.dart';
import '../../controller/splashController.dart';
import '../../models/customerModel.dart';
import '../../utils/sharedPrefs.dart';
import '../dashboard/dashboardScreen.dart';
import '../otp/phone_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // Initialize the GetX controller
  final SplashController controller = Get.put(SplashController());

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

    // Start the transition animation after a delay
    Future.delayed(const Duration(seconds: 2), () {
      _transitionController.forward().then((_) {
        // Navigate to home screen after animation completes
        Future.delayed(const Duration(milliseconds: 500), () async {
          CustomerModel? customerModel = await helper.getCustomer();

          Get.off(
        () =>
        customerModel == null
            ? LoginScreen()
            : DashboardScreen(pageIndex: 0));
          // Get.offNamed('/home');
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
       backgroundColor: COLOR.appBaseColor.withOpacity(0.8), // Light minimal background
      body: AnimatedBuilder(
        animation: Listenable.merge([_rotationController, _transitionController]),
        builder: (context, child) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Rotating products
                Opacity(
                  opacity: _productOpacityAnimation.value,
                  child: _buildRotatingProducts(),
                ),

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

  Widget _buildRotatingProducts() {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(_productImages.length, (index) {
          // Calculate position on the circle
          final double angle = _rotationAnimation.value + (index * (2 * math.pi / _productImages.length));
          final double radius = 130.0; // Radius of the orbit

          // Calculate x and y position
          final double x = radius * math.cos(angle);
          final double y = radius * math.sin(angle);

          // Calculate z for perspective effect (depth)
          final double z = 100 * math.sin(angle);

          // Calculate scale based on z position for better 3D effect
          // Items in front appear larger, items in back appear smaller
          final double scale = _mapRange(z, -100, 100, 0.7, 1.3);

          // Calculate opacity based on z position for better 3D effect
          // Items in front are more opaque, items in back are more transparent
          final double opacity = _mapRange(z, -100, 100, 0.6, 1.0);

          return Positioned(
            left: 150 + x - 30, // Center + offset - half of product size
            top: 150 + y - 30,  // Center + offset - half of product size
            child: Transform(
              // Apply proper 3D transformation
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Perspective
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
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
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
      ),
    );
  }

  // Helper function to map a value from one range to another
  double _mapRange(double value, double min1, double max1, double min2, double max2) {
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
