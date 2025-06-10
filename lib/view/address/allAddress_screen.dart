import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keep_app/controller/addressController.dart';
import 'package:keep_app/view/address/pickupAddressScreen.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../utils/string_res.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/textWidget.dart';

class AllAddressScreen extends StatefulWidget {
  const AllAddressScreen({super.key});

  @override
  State<AllAddressScreen> createState() => _AllAddressScreenState();
}

class _AllAddressScreenState extends State<AllAddressScreen> {
  final AddressController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyCustomAppBar(
          actionPadding: 10,
          height: 100,
          appbarPadding: 0,
          elevation: 1,
          title: TextWiget(
            title: StringRes.allAddress,
            style: Themes.light.textTheme.displayLarge,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: COLOR.appBaseColor,
          onPressed: () {
            controller.txtAddress.clear();
            controller.txtFullname.clear();
            controller.txtLandmark.clear();
            controller.txtMobileno.clear();
            controller.txtPincode.clear();
            controller.txtType.clear();
            Get.to(() => PickupAddressScreen());
          },
          child: Icon(Icons.add,color: COLOR.background,),
        ),
        body: RefreshIndicator(
          onRefresh: () {
           return controller.getAllAddress();
          },
          child: Column(
            children: [
              Obx(() {
                if (controller.allAddressList.isNotEmpty) {
                  if (controller.isAddress.value) {
                    return ListView.builder(
                      itemCount: controller.allAddressList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider()),

                              Center(
                                child: Container(
                                  // margin: EdgeInsets.all(16.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 10.0),
                                          Text(
                                            "${controller.allAddressList[index].addressFullName}",
                                            style: Themes.light.textTheme.displayMedium!.copyWith(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 06.0),
                                      // Address
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 10.0),
                                          Expanded(
                                            child: Text(
                                              '${controller.allAddressList[index].addressColony} ${controller.allAddressList[index].addressPincode} ${controller.allAddressList[index].addressLandmark} \n ${controller.allAddressList[index].addressType}',
                                              style: Themes.light.textTheme.bodyMedium!.copyWith(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 06.0),
                                      // Phone
                                      Row(
                                        children: [
                                          SizedBox(width: 10.0),
                                          Text(
                                            "+91 ${controller.allAddressList[index].addressMobileNo}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      // Action Buttons
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              Get.to(PickupAddressScreen(
                                                address:
                                                    controller.allAddressList[index],
                                              ));
                                            },
                                            icon: Icon(Icons.edit,color: COLOR.background,),
                                            label: Text(StringRes.edit,style: TextStyle(color: COLOR.background),),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: COLOR.appBaseColor,
                                              // primary: Colors.teal,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          OutlinedButton.icon(
                                            onPressed: () {
                                              controller.deleteAddressData(
                                                  customerId: controller
                                                      .allAddressList[index]
                                                      .customerId,
                                                  addressId: controller
                                                      .allAddressList[index]
                                                      .addressId);
                                            },
                                            icon:
                                                Icon(Icons.delete, color: Colors.red),
                                            label: Text(
                                              StringRes.delete,
                                              style: TextStyle(color: Colors.red),
                                            ),
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(color: Colors.red),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                } else {
                  return Center(
                    child: Text(StringRes.noDataFound),
                  );
                }
              }),
            ],
          ),
        ));
  }
}
