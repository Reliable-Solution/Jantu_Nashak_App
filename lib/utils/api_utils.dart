import 'package:dio/dio.dart';

import 'api_error.dart';
// import 'package:suratjugaad/a_structure/models/api_models/api_error.dart';

class ApiUtils {
  ApiUtils._();

  static ApiError getApiError(DioException error) {
    final response = error.response;
    if (response != null) {
      final data = response.data;
      if (data != null) {
        return ApiError.fromJson(data);
      } else {
        return ApiError();
      }
    } else {
      return ApiError.fromMessage(error.message!);
    }
  }
}
