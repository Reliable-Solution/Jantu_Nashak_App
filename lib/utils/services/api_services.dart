// import 'package:dio/dio.dart';
//
// class ApiService {
//   static final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: "https://kffashionnew.reliablesolution.in/Admin/Ajax/",
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//     ),
//   );
//
//   // Generic POST method
//   static Future<Response> post({
//     required String endpoint,
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? headers,
//   }) async {
//     try {
//       // Adding optional headers
//       if (headers != null) {
//         _dio.options.headers.addAll(headers);
//       }
//
//       final response = await _dio.post(
//         endpoint,
//         data: body,
//       );
//
//       return response; // Return raw response
//     } on DioException catch (e) {
//       // Dio-specific error handling
//       if (e.response != null) {
//         throw Exception(
//             "Error: ${e.response!.statusCode}, Message: ${e.response!.data}");
//       } else {
//         throw Exception("Network Error: ${e.message}");
//       }
//     } catch (e) {
//       throw Exception("Unexpected Error: ${e.toString()}");
//     }
//   }
//
//   // Generic GET method
//   static Future<Response> get({
//     required String endpoint,
//     Map<String, dynamic>? headers,
//   }) async {
//     try {
//       // Adding optional headers
//       if (headers != null) {
//         _dio.options.headers.addAll(headers);
//       }
//
//       final response = await _dio.get(endpoint);
//
//       return response; // Return raw response
//     } on DioException catch (e) {
//       if (e.response != null) {
//         throw Exception(
//             "Error: ${e.response!.statusCode}, Message: ${e.response!.data}");
//       } else {
//         throw Exception("Network Error: ${e.message}");
//       }
//     } catch (e) {
//       throw Exception("Unexpected Error: ${e.toString()}");
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl =
      "https://kffashionnew.reliablesolution.in/Admin/Ajax/";
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://kffashionnew.reliablesolution.in/Admin/Ajax/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      print("Response $response");

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  static Future<Response> post({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      FormData formData = FormData.fromMap(body ?? {});

      final response = await _dio.post(endpoint, data: formData);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception("Failed to post data: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            "Error: ${e.response!.statusCode}, Message: ${e.response!.data}");
      } else {
        throw Exception("Network Error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected Error: ${e.toString()}");
    }
  }
}
