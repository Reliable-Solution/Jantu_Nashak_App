import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colorConst.dart';
import '../controller/languageController.dart';
import '../utils/string_res.dart';

void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return LanguageSelectionSheet();
    },
  );
}

class LanguageSelectionSheet extends StatelessWidget {
  final LanguageController controller = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringRes.changeLanguage,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Language List (Grid Format)
            Obx(() {
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: controller.languages.map((lang) {
                  bool isSelected = lang["name"] == controller.selectedLanguage.value;
                  return GestureDetector(
                    onTap: () {
                      print("Selected Language: ${lang["name"]}");
                      controller.changeLanguage(lang["name"]!);
                      Future.delayed(Duration(milliseconds: 300), () {
                        Navigator.pop(context);  // ✅ Bottom Sheet Close after update
                      });
                      // Navigator.pop(context);
                      // controller.update();
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isSelected ? COLOR.appBaseColor : Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                        color: isSelected ? Colors.purple.shade50 : Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lang["symbol"]!,
                            style: TextStyle(
                              fontSize: 24,
                              color: isSelected ? COLOR.appBaseColor : Colors.black,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              lang["name"]!,
                              style: TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? COLOR.appBaseColor: Colors.black,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(Icons.check_circle, color: COLOR.appBaseColor, size: 20),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
        
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
