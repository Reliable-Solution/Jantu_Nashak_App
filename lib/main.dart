
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keep_app/utils/binding/networkBinding.dart';
import 'package:keep_app/utils/services/languageServices.dart';
import 'package:keep_app/view/splash/splashScreen.dart';

import 'controller/homeController.dart';
import 'controller/languageController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("🟡 Initializing language...");

  await Get.putAsync(() async => LanguageController());
  await LocalizationService.loadTranslations();

  Get.put(HomeController());  // Sirf yaha ek baar

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
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocalizationService(),
      locale: Get.locale ?? Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      home: SplashScreen(),
      initialBinding: NetworkBinding(),
    ),
  );
}

