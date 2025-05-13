import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keep_app/utils/binding/networkBinding.dart';
import 'package:keep_app/utils/services/languageServices.dart';
import 'package:keep_app/view/splash/splashScreen.dart';

import 'controller/languageController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() async => LanguageController());

  await LocalizationService.loadTranslations(); // ✅ Translations Load Karega

  Firebase.initializeApp();
  await GetStorage.init();
  runApp(

    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocalizationService(),
      locale: Get.locale ?? Locale('en', 'US'),
      // 👈 Default locale
      fallbackLocale: Locale('en', 'US'),
      // 👈 Fallback Language
      home: SplashScreen(),
      initialBinding: NetworkBinding(),
    ),
  );
}


