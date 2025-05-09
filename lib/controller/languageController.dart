import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var selectedLanguage = "English".obs;
  var currentLocale = Locale('en', 'US').obs;  // ✅ Default Locale

  final List<Map<String, String>> languages = [
    {"name": "English", "symbol": "🇺🇸", "code": "en", "country": "US"},
    {"name": "हिंदी", "symbol": "🇮🇳", "code": "hi", "country": "IN"},
    {"name": "ગુજરાતી", "symbol": "🇮🇳", "code": "gu", "country": "IN"},
    // {"symbol": "અ", "name": "Gujarati"},
    // {"symbol": "अ", "name": "Hindi"},
    // {"symbol": "A", "name": "English"},
    // {"symbol": "అ", "name": "Telugu"},
    // {"symbol": "அ", "name": "Tamil"},
    // {"symbol": "ಅ", "name": "Kannada"},
    // {"symbol": "অ", "name": "Bengali"},
    // {"symbol": "अ", "name": "Marathi"},
    // {"symbol": "അ", "name": "Malayalam"},
    // {"symbol": "ଅ", "name": "Odia"},
  ];


  @override
  void onInit() {
    super.onInit();
    loadLanguage();

  }

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString("language") ?? "en";
    selectedLanguage.value = prefs.getString("languageName") ?? "English";
    print("🔵 Loaded Language: $langCode");

    var locale = Locale(langCode, languages.firstWhere((e) => e["code"] == langCode)["country"]!);
    currentLocale.value = locale;
    Get.updateLocale(locale);
  }

  Future<void> changeLanguage(String name) async {
    var lang = languages.firstWhere((element) => element["name"] == name);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", lang["code"]!);
    await prefs.setString("languageName", lang["name"]!);
    selectedLanguage.value = lang["name"]!;  // ✅ Fix: Update selectedLanguage

    var locale = Locale(lang["code"]!, lang["country"]!);
    currentLocale.value = locale;  // ✅ Obx UI Update Karega
    Get.updateLocale(locale);

    print("✅ Locale Updated to: ${Get.locale}");
  }

  void updateLanguage(String langCode, {bool notify = true}) {
    print("🌐 Changing Language to: $langCode");

    var lang = languages.firstWhere((element) => element["code"] == langCode);
    selectedLanguage.value = lang["name"]!;

    Get.updateLocale(Locale(langCode, lang["country"]));
    print("✅ Locale Updated to: ${Get.locale}");

    if (notify) update();  // ✅ UI Refresh
  }

  Locale getLocale() {
    var lang = languages.firstWhere((element) => element["name"] == selectedLanguage.value, orElse: () => languages[0]);
    return Locale(lang["code"]!, lang["country"]!);
  }

}
