//  flutter
import 'package:flutter/material.dart';

// package
import 'package:get/get.dart';
import 'package:keep_app/controller/addressController.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/models/addressModel.dart';


import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../utils/string_res.dart';
import '../../widget/alignWidget.dart';
import '../../widget/buttonWidget.dart';
import '../../widget/inputWidget.dart';
import '../../widget/textWidget.dart';

class PickupAddressScreen extends StatelessWidget {
  final AddressController _controller = Get.find<AddressController>();

  PickupAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.onInit();
    return Scaffold(
      backgroundColor: COLOR.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: COLOR.yellow100,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: ImageIcon(
                          AssetImage(Images.circle),
                          size: 25,
                          color: Colors.yellow,
                        ),
                      ),
                      TextWiget(
                        title: StringRes.productsWill,
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10),
                //   child: AlignWidget(
                //     alignment: Alignment.topLeft,
                //     child: Obx(
                //       () => CheckboxListTileWidget(
                //         title: TextWiget(
                //           title: 'Use address registered on GST',
                //           style: Themes.light.textTheme.bodyLarge!.copyWith(
                //             color: COLOR.black.withOpacity(0.6),
                //           ),
                //         ),
                //         value: _controller.isSelected.value,
                //         onChanged: (bool? value) {
                //           _controller.changeValue();
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.06,
                  child: InputFiledArea(
                    controller: _controller.txtFullname,
                    keyboardType: TextInputType.text,
                    labelText: StringRes.fullName,
                    border: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.06,
                    child: InputFiledArea(
                      controller: _controller.txtMobileno,
                      keyboardType: TextInputType.text,
                      labelText: StringRes.mobileNumber,
                      border: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.06,
                    child: InputFiledArea(
                      controller: _controller.txtAddress,
                      keyboardType: TextInputType.text,
                      labelText: StringRes.address,
                      border: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: (MediaQuery
                              .of(context)
                              .size
                              .width * 42) / 100,
                          child: InputFiledArea(
                            controller: _controller.txtPincode,
                            keyboardType: TextInputType.text,
                            labelText: StringRes.pinCode,
                            border: 1,
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery
                              .of(context)
                              .size
                              .width * 42) / 100,
                          child: InputFiledArea(
                            controller: _controller.txtLandmark,
                            keyboardType: TextInputType.text,
                            labelText: StringRes.landmark,
                            border: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.06,
                    child: InputFiledArea(
                      controller: _controller.txtType,
                      keyboardType: TextInputType.text,
                      labelText: StringRes.addressType,
                      border: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.1,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ButtonWidgets(
          title: StringRes.continueString,
          voidCallback: () {
        AddressModel a1  =  AddressModel(customerId:_controller.customerModel!.value.customerId, addressFullName: _controller.txtFullname.text,
                addressMobileNo: _controller.txtMobileno.text,
                addressPincode: _controller.txtPincode.text,
                addressDefault: _controller.txtAddress.text,
                addressLandmark: _controller.txtLandmark.text,
                addressType: _controller.txtType.text);

            _controller.addAddressData(addressModel: a1);
          },
          // voidCallback: (_controller.cState.text.trim().isNotEmpty)
          //     ? () {
          //         _controller.myTabController!.index = 2;
          //       }
          //     : null,
          color: COLOR.indigo,
          style: Themes.light.textTheme.displayLarge!.copyWith(
              color: Colors.white),
        ),
      ),
    );
  }
}
