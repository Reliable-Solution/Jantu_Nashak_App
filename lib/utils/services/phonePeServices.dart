import 'dart:convert';
import 'package:dio/dio.dart';

class PhonePeService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://api-preprod.phonepe.com/apis/hermes';
  final String merchantId = 'YOUR_MERCHANT_ID';
  final String saltKey = 'YOUR_SALT_KEY';
  final int saltIndex = 1; // Usually 1 in sandbox

  Future<void> initiatePayment(double amount) async {
    try {
      String transactionId = DateTime.now().millisecondsSinceEpoch.toString();
      var requestBody = {
        "merchantId": merchantId,
        "transactionId": transactionId,
        "amount": (amount * 100).toInt(),
        "callbackUrl": "https://your-website.com/callback",
        "paymentInstrument": {"type": "UPI_INTENT"}
      };

      // Generate SHA256 Checksum
      String payload = base64Encode(utf8.encode(jsonEncode(requestBody)));
      String checksum = generateChecksum(payload);

      var response = await _dio.post(
        '$baseUrl/v1/pay',
        data: jsonEncode(requestBody),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "X-VERIFY": checksum,
            "X-MERCHANT-ID": merchantId,
            "X-SALT-INDEX": saltIndex.toString(),
          },
        ),
      );

      if (response.statusCode == 200) {
        String paymentUrl =
            response.data['data']['instrumentResponse']['redirectInfo']['url'];
        print('Payment URL: $paymentUrl');
        // await launch(paymentUrl);
      } else {
        print('Payment Failed: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String generateChecksum(String payload) {
    var input = '$payload/saltKey';
    return base64Encode(
        utf8.encode(input)); // Replace with actual SHA256 generation
  }
}
