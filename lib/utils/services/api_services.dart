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
import 'dart:developer';

import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl =
      "https://staging-jantunashak.reliablesolution.in/Admin/Ajax/";

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://staging-jantunashak.reliablesolution.in/Admin/Ajax/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      print("Response $response");

      final fullUrl = "$baseUrl$endpoint";

      // Build cURL string
      final curl = StringBuffer();
      curl.write("curl -X POST '$fullUrl' \\\n");

      // Headers (add content-type for FormData)
      curl.write("  -H 'Content-Type: multipart/form-data' \\\n");

      // // Body
      // if (body != null && body.isNotEmpty) {
      //   for (var entry in body.entries) {
      //     curl.write("  -F '${entry.key}=${entry.value}' \\\n");
      //   }
      // }

      // Print the cURL command
      print("======== cURL Command ========");
      print(curl.toString());
      print("==============================");
      if (response.statusCode == 200) {
        print("Response  code ${response.statusCode}");
        return response;
      } else {
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            "Error: ${e.response!.statusCode}, Message: ${e.response!.data}");
      } else {
        throw Exception("Network Error: ${e.message}");
      }
      // catch (e) {
      //   throw Exception("Unexpected Error: ${e.toString()}");
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

      // Print the endpoint and body for debugging
      print("POST Request URL: $baseUrl$endpoint");
      print("POST Request Body: ${body?.toString() ?? '{}'}");
      log("POST Request Body: ${body}");

      final fullUrl = "$baseUrl$endpoint";

      // Build cURL string
      final curl = StringBuffer();
      curl.write("curl -X POST '$fullUrl' \\\n");

      // Headers (add content-type for FormData)
      curl.write("  -H 'Content-Type: multipart/form-data' \\\n");

      // Body
      if (body != null && body.isNotEmpty) {
        for (var entry in body.entries) {
          curl.write("  -F '${entry.key}=${entry.value}' \\\n");
        }
      }

      // Print the cURL command
      print("======== cURL Command ========");
      print(curl.toString());
      print("==============================");
      final response = await _dio.post(endpoint,
          data: formData,
          options: Options(headers: {
            "Cookie": 'ci_session=a4546d65e592cda9a7a377fddf8145473b17410b'
          }));
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
