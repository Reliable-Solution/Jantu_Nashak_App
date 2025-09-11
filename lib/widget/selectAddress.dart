import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/models/addressModel.dart';
import 'package:keep_app/widget/buttonWidget.dart';
import '../Theme/nativeTheme.dart';
import '../constant/colorConst.dart';
import '../controller/addressController.dart';
import '../utils/string_res.dart';
import '../view/address/pickupAddressScreen.dart';

void showAddressBottomSheet(BuildContext context) {
  final AddressController controller = Get.find();

  if (controller.allAddressList.isNotEmpty) {
    controller.selectedAddressId.value =
        controller.allAddressList.last.addressId.toString();
  }

  Get.bottomSheet(
    SafeArea(
      top: false,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Obx(() {
          if (controller.allAddressList.isEmpty) {
            return Column(
              children: [
                Center(child: Text(StringRes.noDataFound)),
                ButtonWidgets(
                  title: StringRes.addAddress,
                  voidCallback: () {
                    clearTextFields(controller);
                    Get.to(() => PickupAddressScreen())?.then((_) {
                      controller.getAllAddress();
                    });
                  },
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.allAddressList.length,
                    itemBuilder: (context, index) {
                      var address = controller.allAddressList[index];

                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            // margin: EdgeInsets.all(16.0),
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: controller.selectedAddressId.value ==
                                      address.addressId.toString()
                                  ? Color(0xffe7eeff)
                                  : Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person,
                                        color: Colors.teal, size: 28),
                                    SizedBox(width: 10.0),
                                    Text(
                                      address.addressFullName!,
                                      style: Themes
                                          .light.textTheme.displayMedium!
                                          .copyWith(fontSize: 20),
                                    ),
                                    Spacer(),
                                    Obx(() => Radio<String>(
                                          value: address.addressId.toString(),
                                          groupValue: controller
                                              .selectedAddressId.value,
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.selectedAddressId
                                                  .value = value;
                                              Navigator.pop(context);
                                            }
                                          },
                                        )),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${address.addressColony}\n${address.addressPincode}\n${address.addressLandmark}\n${address.addressType}',
                                        style: Themes
                                            .light.textTheme.bodyMedium!
                                            .copyWith(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Text(
                                      address.addressMobileNo!,
                                      style: Themes.light.textTheme.bodyMedium!
                                          .copyWith(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1.2,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ButtonWidgets(
                  title: StringRes.addAddress,
                  voidCallback: () {
                    clearTextFields(controller);
                    Get.to(() => PickupAddressScreen())?.then((_) {
                      controller.getAllAddress();
                    });
                  },
                  color: COLOR.appBaseColor,
                  style: Themes.light.textTheme.displaySmall!
                      .copyWith(color: COLOR.background),
                ),
              ],
            );
          }
        }),
      ),
    ),
  );
}

void clearTextFields(AddressController controller) {
  controller.txtAddress.clear();
  controller.txtFullname.clear();
  controller.txtLandmark.clear();
  controller.txtMobileno.clear();
  controller.txtPincode.clear();
  controller.txtType.clear();
}
