import 'dart:convert';

import 'package:get/get.dart';
import 'package:keep_app/controller/homeController.dart';

import '../constant/api_endpoints.dart';
import '../models/MonthlyUser.dart';
import '../models/prizeModel.dart';
import '../utils/services/api_services.dart';

class LeaderboardController extends GetxController {
  HomeController homeController = Get.find();
  final monthlyUsers = <MonthlyUser>[].obs;
  final prizes = <Prize>[].obs;
  final isLoading = true.obs;


  Future<void> fetchData() async {
    isLoading(true);

    final Map<String, dynamic> body = {
      'CustomerId': homeController.customerModel!.value.customerId,
      'Month':"09",
      'Year':2025,
    };


    // Call APIs
    final prizeRes = await ApiService.post(endpoint: getPrizeData);
    var monthlyRes = await ApiService.post(endpoint: getMonthlyData,body: body);

    if (prizeRes.data['IsSuccess'] == true) {
      prizes.assignAll(
        (prizeRes.data['Data'] as List).map((e) => Prize.fromJson(e)),
      );
    }
    print("Prize data ${prizeRes.data}");

    print("Monthly data ${monthlyRes.data}");
    print("Type of monthlyRes: ${monthlyRes.runtimeType}");
    print("Type of monthlyRes.data: ${monthlyRes.data.runtimeType}");
    final responseBody = jsonDecode(monthlyRes.data);

    if (responseBody is Map<String, dynamic>   && responseBody['IsSuccess'] == true) {
      final data = responseBody['Data'];
      print("Data is a List ${(data as List).length}");
      if (data is List) {
        monthlyUsers.assignAll(
          data.map((e) => MonthlyUser.fromJson(e)).toList(),
        );
      } else {
        print("Data is not a List – actual type: ${data.runtimeType}");
      }
    } else {
      print("Invalid response format – ${monthlyRes.data}");
    }

    isLoading(false);
  }

  Prize? getPrizeForRank(int rank) {
    return prizes.firstWhereOrNull((p) => p.prizePosition == rank);
  }
}