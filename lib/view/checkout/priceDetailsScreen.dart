import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/Theme/nativeTheme.dart';

class PriceDetailsWidget extends StatelessWidget {
  PriceDetailsWidget({Key? key}) : super(key: key);

  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PRICE DETAILS",
            style: Themes.light.textTheme.displayMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Item total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Item Total",
                style: TextStyle(fontSize: 14),
              ),
              Obx(() => Text(
                "₹${cartController.cartTotal.value?.totalInteger ?? 0}",
                style: const TextStyle(fontSize: 14),
              )),
            ],
          ),
          const SizedBox(height: 8),

          // Delivery fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Delivery Fee",
                style: TextStyle(fontSize: 14),
              ),
              const Text(
                "FREE",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Discount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Discount",
                style: TextStyle(fontSize: 14),
              ),
              Obx(() => Text(
                "-₹${cartController.cartTotal.value?.save ?? 0}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              )),
            ],
          ),
          const SizedBox(height: 16),

          const Divider(),
          const SizedBox(height: 16),

          // Total amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: Themes.light.textTheme.displayMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Obx(() => Text(
                "₹${cartController.cartTotal.value?.totalInteger ?? 0}",
                style: Themes.light.textTheme.displayMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
            ],
          ),
          const SizedBox(height: 16),

          // Savings
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Obx(() => Text(
              "You will save ₹${cartController.cartTotal.value?.save ?? 0} on this order",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
