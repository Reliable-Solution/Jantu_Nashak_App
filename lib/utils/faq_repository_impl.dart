// import 'dart:developer';
// import 'package:dio/dio.dart';
// // import 'package:suratjugaad/a_structure/repository/faq_repo/faq_repo.dart';
// // import 'package:suratjugaad/data/models/faq_model.dart';
// // import '../../../Common/config.dart';
// // import '../../api_client/api_utils.dart';
// // import '../../models/api_models/api_response.dart';
//
// class FaqRepositoryImpl extends FaqRepository {
//   final Dio _dio;
//
//   FaqRepositoryImpl(this._dio);
//
//   @override
//   Future<ApiResponse<FaqModel>> getFaqList(Map<String, dynamic> bodyData) async {
//     try {
//       final response = await _dio.post('https://suratjugaad-staging.reliablesolution.in/Admin/Ajax/get_modules', data: FormData.fromMap(bodyData));
//       log("FAQ Data: ${response.data}");
//       final getFaqResponse = FaqModel.fromJson(response.data);
//       return ApiResponse.success(data: getFaqResponse);
//     } on DioException catch (error) {
//       final errorModel = FaqModel.fromJson(error.response?.data);
//       return ApiResponse.error(
//         error: ApiUtils.getApiError(error),
//         errorMsg: errorModel.message,
//       );
//     }
//   }
// }

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:keep_app/utils/services/api_services.dart';
// import '../../../data/models/faq_model.dart';
// import '../../models/api_models/api_response.dart';
// import '../../api_client/api_utils.dart';
import '../models/faqModel.dart';
import 'api_response.dart';
import 'api_utils.dart';

class FaqRepositoryImpl {
  final Dio _dio = Dio();

  Future<ApiResponse<FaqModel>> getFaqList(Map<String, dynamic> bodyData) async {
    try {
      final response = await _dio.post('${ApiService.baseUrl}get_FAQ', data: FormData.fromMap(bodyData));

      log("FAQ API Response: ${response.data}");

      final faqModel = FaqModel.fromJson(response.data);

      if (faqModel.isSuccess == true) {
        return ApiResponse.success(data: faqModel);
      } else {
        return ApiResponse.error(
          // error: ApiUtils.getApiError(null), // 👈 Fix here
          errorMsg: faqModel.message ?? "Something went wrong",
        );
      }
    } on DioException catch (error) {
      log("FAQ API DioException: ${error.message}");
      final errorModel = FaqModel.fromJson(error.response?.data ?? {});
      return ApiResponse.error(
        error: ApiUtils.getApiError(error), // ✅ Correct here
        errorMsg: errorModel.message ?? "Server error",
      );
    } catch (e) {
      log("FAQ API Exception: $e");
      return ApiResponse.error(
        // error: ApiUtils.getApiError(), // 👈 Optional
        errorMsg: "Unexpected error",
      );
    }
  }

  // Future<ApiResponse<FaqModel>> getFaqList(Map<String, dynamic> bodyData) async {
  //   try {
  //     // API Call
  //     final response = await _dio.post(
  //       'https://suratjugaad-staging.reliablesolution.in/Admin/Ajax/get_modules',
  //       data: FormData.fromMap(bodyData),
  //     );
  //
  //     log("FAQ API Response: ${response.data}");
  //
  //     // Parsing data to model
  //     final faqModel = FaqModel.fromJson(response.data);
  //
  //     if (faqModel.isSuccess == true) {
  //       return ApiResponse.success(data: faqModel);
  //     } else {
  //       return ApiResponse.error(
  //         error: "Error",
  //         errorMsg: faqModel.message ?? "Something went wrong",
  //       );
  //     }
  //   } on DioException catch (error) {
  //     log("FAQ API DioException: ${error.message}");
  //     final errorModel = FaqModel.fromJson(error.response?.data ?? {});
  //     return ApiResponse.error(
  //       error: ApiUtils.getApiError(error),
  //       errorMsg: errorModel.message ?? "Server error",
  //     );
  //   } catch (e) {
  //     log("FAQ API Exception: $e");
  //     return ApiResponse.error(error: e.toString(), errorMsg: "Unexpected error");
  //   }
  // }
}
