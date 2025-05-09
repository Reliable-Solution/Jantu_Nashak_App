import 'package:flutter/material.dart';
import '../utils/services/phonePeServices.dart';
import '../utils/services/razorPayServices.dart';

class PaymentController {
  final RazorpayService _razorpayService = RazorpayService();
  final PhonePeService _phonePeService = PhonePeService();

  void makePayment({required double amount, required String method}) {
    if (method == 'Razorpay') {
      _razorpayService.openCheckout(amount);
    } else if (method == 'PhonePe') {
      _phonePeService.initiatePayment(amount);
    }
  }
}
