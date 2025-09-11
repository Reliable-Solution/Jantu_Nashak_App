import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keep_app/utils/binding/networkBinding.dart';
import 'package:keep_app/utils/services/firebase_notification.dart';
import 'package:keep_app/utils/services/languageServices.dart';
import 'package:keep_app/view/home/home_screen.dart';
import 'package:keep_app/view/order/orderScreen.dart';
import 'package:keep_app/view/splash/splashScreen.dart';
import 'package:keep_app/widget/appBarWidget.dart';
import 'package:keep_app/widget/productDetailView.dart';
import 'package:keep_app/widget/textWidget.dart';
import 'package:share_plus/share_plus.dart';

import 'Theme/nativeTheme.dart';
import 'controller/homeController.dart';
import 'controller/languageController.dart';
import 'models/productModel.dart';

Uri? _initialLink;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // optional: allow upside down
  ]);
  print("🟡 Initializing language...");

  await Get.putAsync(() async => LanguageController());
  await LocalizationService.loadTranslations();

  // Get.put(HomeController());  // Sirf yaha ek baar (uncomment if needed, but assuming it's handled in bindings)

  try {
    if (Platform.isAndroid) {
      print("🟡 Initializing Firebase... is Android ");
      // Android-specific code
    } else if (Platform.isIOS) {
      print("🟡 Initializing Firebase... is iOS ");
      // iOS-specific code
    }
    print("🟡 Initializing Firebase...");
    await Firebase.initializeApp();
    FirebaseNotification().initNotifications();
    print("🟢 Firebase initialized.");
  } catch (e) {
    print("❌ Firebase init error: $e");
  }

  try {
    await GetStorage.init();
    print("🟢 GetStorage initialized.");
  } catch (e) {
    print("❌ GetStorage init error: $e");
  }

  // Add this for debugging Firebase issues
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    print('Auth state changed: ${user?.uid}');
  });

  // Get initial deep link before running the app
  final appLinks = AppLinks();
  _initialLink = await appLinks.getInitialLink();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();

    // Handle initial link after the first frame (ensures GetX is ready)
    if (_initialLink != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleDeepLink(_initialLink!);
      });
    }

    // Listen for incoming links while app is running
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print("========>>> Mounted ");
      if (mounted) {
        _handleDeepLink(uri);
      }
    });
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocalizationService(),
      locale: Get.locale ?? Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      home: SplashScreen(),
      initialBinding: NetworkBinding(),
    );
  }
}


void _handleDeepLink(Uri link) async {
  print("========> Deep link received: $link"); // Check console
  print("========> Scheme: ${link.scheme}");

  print("========> Scheme Path Name : ${link.path}");
  String schemeUrl=link.scheme.toString();
  print(schemeUrl.compareTo("jantunashak")==0);
  if (schemeUrl.compareTo("jantunashak")==0) {
    final productId = link.pathSegments.last;
    print("Product ID: $productId");
    print("===========MAIN ENter");
// Get.to(ProductDetailScreen(fromDeepLink: true,));
//     print("===========MAIN Exits");

    final homeController = Get.find<HomeController>();
    await homeController.getProductData(productId); // API call
    //
    // // if (homeController.productList.isNotEmpty) {
    // //   final product = homeController.productList.first;
    //   Get.to(() => ProductDetailScreen(
    //     // products: ,
    //     fromDeepLink: true,
    //   ));
    // } else {
    //   Get.snackbar("Product not found", "ID: $productId");
    }


    // final productId = link.pathSegments.last; // '932asbn'
    // print("Product ID: $productId");
    // final homeController = Get.find<HomeController>();
    // homeController.getProductData(productId);
    // Get.to(() => ProductDetailScreen(products: product,fromDeepLink: true,));
    // // ProductModel? product = homeController.allProducts.firstWhereOrNull((p) => p.productId == productId);
    // if (product != null) {
    //   print("Product found locally");
    //   Get.to(() => ProductDetailScreen(products: product,fromDeepLink: true,));
    // } else {
    //   print("Fetching dashboard data...");
    //   await homeController.getDashboardData('7'); // Replace '7' with dynamic customer ID if possible
    //   // homeController.collectAllProducts(homeController.lastJson!);
    //   // product = homeController.allProducts.firstWhereOrNull((p) => p.productId == productId);
    //   if (product != null) {
    //     print("Product found after fetch");
    //     Get.to(() => ProductDetailScreen(products: product));
    //   } else {
    //     print("Product not found");
    //     // Get.snackbar("Product not found", "ID: $productId");
    //   }
    // }
  // } else {
  //   print("Invalid deep link scheme or path");
  // }
}
// void _handleDeepLink(Uri link) async {
//   print("Handling deep link: $link"); // For debugging
//
//   if (link.scheme == 'jantunashak' && link.host == 'product') {
//     final productId = link.pathSegments.last;
//
//     // Ensure HomeController is available (assuming NetworkBinding or SplashScreen initializes it)
//     final homeController = Get.find<HomeController>();
//     ProductModel? product = homeController.allProducts
//         .firstWhereOrNull((p) => p.productId == productId);
//
//     if (product != null) {
//       Get.to(() => ProductDetailScreen(products: product));
//     } else {
//       await homeController.getDashboardData('7'); // customerId (consider making this dynamic)
//       homeController.collectAllProducts(homeController.lastJson!);
//       product = homeController.allProducts
//           .firstWhereOrNull((p) => p.productId == productId);
//       if (product != null) {
//         Get.to(() => ProductDetailScreen(products: product));
//       } else {
//         Get.snackbar("Product not found", "");
//       }
//     }
//   }
// }

// // import 'package:flutter/material.dart';
// //
// // void main()  {
// //   runApp(new Test());
// // }
// //
// // class Test extends StatefulWidget {
// //   @override
// //   _TestState createState() => _TestState();
// // }
// //
// // class _TestState extends State<Test> with TickerProviderStateMixin {
// //
// //   late AnimationController _resizableController;
// //
// //   static Color? colorVariation(int note){
// //     if(note <= 1){
// //       return Colors.blue[50];
// //     }else if(note>1 && note<=2){
// //       return Colors.blue[100];
// //     }else if(note>2 && note<=3){
// //       return Colors.blue[200];
// //     }else if(note>3 && note<=4){
// //       return Colors.blue[300];
// //     }else if(note>4 && note<=5){
// //       return Colors.blue[400];
// //     }else if(note>5 && note<=6){
// //       return Colors.blue;
// //     }else if(note>6 && note<=7){
// //       return Colors.blue[600];
// //     }else if(note>7 && note<=8){
// //       return Colors.blue[700];
// //     }else if(note>8 && note<=9){
// //       return Colors.blue[800];
// //     }else if(note>9 && note<=10){
// //       return Colors.blue[900];
// //     }
// //   }
// //
// //   AnimatedBuilder getContainer() {
// //     return new AnimatedBuilder(
// //         animation: _resizableController,
// //         builder: (context, child) {
// //           return Container(
// //             //color: colorVariation((_resizableController.value *100).round()),
// //             padding: EdgeInsets.all(24),
// //             child: Text("SAMPLE"),
// //             decoration: BoxDecoration(
// //               shape: BoxShape.rectangle,
// //               borderRadius: BorderRadius.all(Radius.circular(12)),
// //               border: Border.all(
// //                   color: colorVariation((_resizableController.value *10).round())!, width:10),
// //             ),
// //           );
// //         });
// //   }
// //
// //   @override
// //   void initState() {
// //     _resizableController = new AnimationController(
// //       vsync: this,
// //       duration: new Duration(
// //         milliseconds: 500,
// //       ),
// //     );
// //     _resizableController.addStatusListener((animationStatus) {
// //       switch (animationStatus) {
// //         case AnimationStatus.completed:
// //           _resizableController.reverse();
// //           break;
// //         case AnimationStatus.dismissed:
// //           _resizableController.forward();
// //           break;
// //         case AnimationStatus.forward:
// //           break;
// //         case AnimationStatus.reverse:
// //           break;
// //       }
// //     });
// //     _resizableController.forward();
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //         home:Scaffold(
// //             backgroundColor: Colors.white,
// //             body: Center(child: getContainer())));
// //   }
// // }



// lib/main.dart

//
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) => const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: BorderSweepPage(),
//   );
// }
//
// class BorderSweepPage extends StatefulWidget {
//   const BorderSweepPage({Key? key}) : super(key: key);
//   @override
//   State<BorderSweepPage> createState() => _BorderSweepPageState();
// }
//
// class _BorderSweepPageState extends State<BorderSweepPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _ctrl;
//
//   @override
//   void initState() {
//     super.initState();
//     _ctrl = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       body: Center(
//         child: SizedBox(
//           width: 200,
//           height: 200,
//           child: AnimatedBuilder(
//             animation: _ctrl,
//             builder: (_, __) {
//               return CustomPaint(
//                 painter: _BorderSweepPainter(
//                   sweepAngle: _ctrl.value * 2 * math.pi,
//                   strokeWidth: 6,
//                   color: Colors.cyanAccent, // jo color ghumwana hai
//                 ),
//                 child: const Center(
//                   child: Icon(Icons.favorite, color: Colors.white, size: 64),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _BorderSweepPainter extends CustomPainter {
//   final double sweepAngle;
//   final double strokeWidth;
//   final Color color;
//
//   _BorderSweepPainter({
//     required this.sweepAngle,
//     required this.strokeWidth,
//     required this.color,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final rect = Offset.zero & size;
//     final rrect = RRect.fromRectAndRadius(
//       rect.deflate(strokeWidth / 2),
//       const Radius.circular(20),
//     );
//
//     // full border gray (static)
//     final grayPaint = Paint()
//       ..color = Colors.grey[800]!
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;
//
//     canvas.drawRRect(rrect, grayPaint);
//
//     // sweeping color arc (only border)
//     final sweepPaint = Paint()
//       ..shader = SweepGradient(
//         colors: [color.withOpacity(0), color, color.withOpacity(0)],
//         stops: const [0.0, 0.1, 0.2],
//         transform: GradientRotation(sweepAngle),
//       ).createShader(rect)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;
//
//     canvas.drawRRect(rrect, sweepPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant _BorderSweepPainter old) =>
//       old.sweepAngle != sweepAngle;
// }