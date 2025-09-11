import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/faqModel.dart';
import '../utils/api_status.dart';
import '../utils/faq_repository_impl.dart';

class FaqController extends GetxController {
  // final FaqRepository _faqRepository = Get.find<FaqRepository>();

  RxList<FaqModelData> timeLineData = <FaqModelData>[].obs;
  RxList<FaqModelData> searchResultCategory = <FaqModelData>[].obs;
  RxBool isLoading = true.obs;
  RxBool isSearching = false.obs;
  RxString errorMsg = ''.obs;

  late SharedPreferences preferences;
  String? faqId;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadLocalData();
    fetchFaqData();
  }

  void loadLocalData() async {
    preferences = await SharedPreferences.getInstance();
    faqId = preferences.getString("");
  }

  void fetchFaqData() async {
    isLoading.value = true;
    try {
      final Map<String, dynamic> body = {};

      final response = await FaqRepositoryImpl().getFaqList(body);

      if (response.status == ApiStatus.success) {
        timeLineData.value = response.data?.faqModelData ?? [];
      } else {
        errorMsg.value = response.errorMsg ?? 'Failed to load FAQ';
        Get.snackbar("Error", errorMsg.value);
      }
    } catch (e) {
      log("Fetch FAQ Exception: $e");
      errorMsg.value = "Something went wrong";
      Get.snackbar("Error", errorMsg.value);
    } finally {
      isLoading.value = false;
    }
  }


  void searchCategory(String searchText) {
    if (searchText.isEmpty) {
      isSearching.value = false;
      searchResultCategory.clear();
      return;
    }

    final results = timeLineData.where((item) {
      final title = item?.modulesTitle?.toLowerCase() ?? '';
      return title.contains(searchText.toLowerCase());
    }).toList();

    searchResultCategory.assignAll(results);
    isSearching.value = true;
  }
}
