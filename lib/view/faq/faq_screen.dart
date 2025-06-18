import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_list/toggle_list.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/app_constant.dart';
import '../../constant/colorConst.dart';
import '../../controller/faq_controller.dart';
import '../../utils/string_res.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/textWidget.dart';

class FaqScreen extends StatelessWidget {
  final controller = Get.put(FaqController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyCustomAppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: COLOR.greyback,
            size: 20,
          ),
        ),

        // leading: SizedBox(),
        // action: [],
        actionPadding: 10,
        height: 90,
        appbarPadding: 0,
        title: TextWiget(
          title: StringRes.helpDesk,
          style: Themes.light.textTheme.displayLarge,
        ),
        elevation: 1,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final dataList = controller.isSearching.value
            ? controller.searchResultCategory
            : controller.timeLineData;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.searchController,
                        textInputAction: TextInputAction.search,
                        // style: GoogleFonts.lato(color: COLOR.appBaseColor),
                        cursorColor: COLOR.appBaseColor,
                        decoration: InputDecoration(
                          hintText: StringRes.searchHelp,
                          hintStyle: const TextStyle(fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: controller.searchCategory,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.searchCategory(controller.searchController.text),
                      child: const Icon(Icons.search, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
             Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(StringRes.faq, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: dataList.isEmpty
                  ? Center(child: Image.asset(""))
                  : Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: ToggleList(
                  divider: const Divider(height: 0),
                  children: List.generate(dataList.length, (index) {
                    final item = dataList[index];
                    print("FAQ Screen ${item.modulesImageLink }");
                    return ToggleListItem(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '${index + 1}. ${item.modulesTitle}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  letterSpacing: -0.1,
                                  color: COLOR.appBaseColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.modulesDescription ?? StringRes.noDescriptionAvailable,
                                style: const TextStyle(fontSize: 14)),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
