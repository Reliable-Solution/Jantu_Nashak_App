import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';

class LocalizationService extends Translations {
  static final fallbackLocale = Locale('en', 'US');

  static final locales = [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
    Locale('gu', 'IN'),
  ];

  static Map<String, Map<String, String>> translations = {};

  @override
  Map<String, Map<String, String>> get keys => translations;

  static Future<void> loadTranslations() async {
    try {
      String enJson = await rootBundle.loadString('assets/language/en.json');
      String hiJson = await rootBundle.loadString('assets/language/hindi.json');
      String guJson = await rootBundle.loadString('assets/language/gu.json');

      translations['en'] = Map<String, String>.from(json.decode(enJson));
      translations['hi'] = Map<String, String>.from(json.decode(hiJson));
      translations['gu'] = Map<String, String>.from(json.decode(guJson));
      print("🌍 Translations Loaded Successfully");
    } catch (e) {
      print("❌ Error Loading Translations: $e");
    }
  }

  /// ✅ **Language Change Function**
  static void changeLocale(String langCode) {
    Locale locale = locales.firstWhere(
          (element) => element.languageCode == langCode,
      orElse: () => fallbackLocale,
    );
    print(" local data ${locale.languageCode}");
    Get.updateLocale(locale);
    print("🌐 Language Changed to: $langCode");
  }
}
