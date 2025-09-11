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
import '../../widget/appBarWidget.dart';
import '../../widget/buttonWidget.dart';
import '../../widget/inputWidget.dart';
import '../../widget/textWidget.dart';

class PickupAddressScreen extends StatelessWidget {
  final AddressController _controller = Get.find<AddressController>();
  final _formKey = GlobalKey<FormState>();
  final AddressModel? address;
  List name = ["hello"];

  PickupAddressScreen({super.key, this.address}) {
    if (address != null) {
      _controller.txtFullname.text = address!.addressFullName!;
      _controller.txtMobileno.text = address!.addressMobileNo!;
      _controller.txtPincode.text = address!.addressPincode!;
      _controller.txtAddress.text = address!.addressColony!;
      _controller.txtLandmark.text = address!.addressLandmark!;
      _controller.selectedType.value = address!.addressType!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MyCustomAppBar(
          actionPadding: 10,
          height: 100,
          appbarPadding: 0,
          elevation: 1,
          title: TextWiget(
            title: StringRes.addAddress,
            style: Themes.light.textTheme.headlineLarge,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  InputFiledArea(
                    controller: _controller.txtFullname,
                    keyboardType: TextInputType.text,
                    labelText: StringRes.fullName,
                    validator: (value) {
                      if (value!.isEmpty) return StringRes.fullNameRequired;
                      if (value.length < 3) return StringRes.fullNameInvalid;
                      return null;
                    },
                    border: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InputFiledArea(
                      controller: _controller.txtMobileno,
                      keyboardType: TextInputType.number,
                      labelText: StringRes.mobileNumber,
                      counterText: "",
                      maxlength: 10,
                      validator: (value) {
                        if (value!.isEmpty) return StringRes.mobileRequired;
                        if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                          return StringRes.mobileInvalid;
                        }
                        return null;
                      },
                      border: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InputFiledArea(
                      maxlength: 100,
                      counterText: "",
                      controller: _controller.txtAddress,
                      keyboardType: TextInputType.text,
                      labelText: StringRes.address,
                      validator: (value) {
                        if (value!.isEmpty) return StringRes.addressRequired;
                        if (value.length < 5) return StringRes.addressInvalid;
                        if (value.length >= 100)
                          return "This can't be more than 100 characters";
                        return null;
                      },
                      border: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width * 42) / 100,
                          child: InputFiledArea(
                            controller: _controller.txtPincode,
                            keyboardType: TextInputType.number,
                            labelText: StringRes.pinCode,
                            counterText: "",
                            maxlength: 6,
                            validator: (value) {
                              if (value!.isEmpty)
                                return StringRes.pinCodeRequired;
                              if (value.length != 6) {
                                return StringRes.pinCodeSixDigits;
                              }
                              if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                                return StringRes.pinCodeInvalid;
                              }
                              return null;
                            },
                            border: 1,
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width * 42) / 100,
                          child: InputFiledArea(
                            controller: _controller.txtLandmark,
                            keyboardType: TextInputType.text,
                            labelText: StringRes.landmark,
                            validator: (value) {
                              if (value!.isEmpty)
                                return StringRes.landmarkRequired;
                              return null;
                            },
                            border: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            dropdownColor: COLOR.background,
                            value: _controller.selectedType.value.isEmpty
                                ? null
                                : _controller.selectedType.value,
                            decoration: InputDecoration(
                              fillColor: COLOR.background,
                              hintText: StringRes.addressType,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            isExpanded: true,
                            items: _controller.types.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _controller.setType(value);
                            },
                          ),
                          if (_controller.showError.value)
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 4),
                              child: Text(
                                StringRes.selectAddressType,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ButtonWidgets(
            title: StringRes.continueString,
            voidCallback: () {
              if (_controller.validate()) {
                // Proceed with form submission
                print(
                    "Address type selected: ${_controller.selectedType.value}");
              }

              AddressModel addressModel = AddressModel();
              if (_formKey.currentState!.validate()) {
                addressModel = AddressModel(
                    customerId: _controller.customerModel!.value.customerId,
                    addressFullName: _controller.txtFullname.text,
                    addressMobileNo: _controller.txtMobileno.text,
                    addressPincode: _controller.txtPincode.text,
                    addressColony: _controller.txtAddress.text,
                    addressLandmark: _controller.txtLandmark.text,
                    addressType: _controller.selectedType.value);

                if (address == null) {
                  // ✅ Add New Address
                  _controller.addAddressData(addressModel: addressModel);
                  _controller.getAllAddress();
                } else {
                  print(
                      "========== Address Screen ${_controller.txtType.text}");
                  print("========== Address Screen Id ${address!.addressId}");
                  // ✅ Update Existing Address
                  addressModel = AddressModel(
                      customerId: _controller.customerModel!.value.customerId,
                      addressFullName: _controller.txtFullname.text,
                      addressMobileNo: _controller.txtMobileno.text,
                      addressPincode: _controller.txtPincode.text,
                      addressColony: _controller.txtAddress.text,
                      addressLandmark: _controller.txtLandmark.text,
                      addressType: _controller.selectedType.value);
                  print(
                      "========== Address Screen Id  in App ${address!.addressId}");

                  _controller.updateAddressData(
                      addressId: address!.addressId,
                      addressModel: addressModel);
                  print(
                    "${_controller.customerModel!.value.customerId}\n${_controller.txtFullname.text}\n${_controller.txtMobileno.text}\n${_controller.txtLandmark.text}\n\n${_controller.txtPincode.text}\n${_controller.txtType.text}\n",
                  );
                  _controller.getAllAddress();
                }
              }
            },
            color: COLOR.appBaseColor,
            style: Themes.light.textTheme.displayLarge!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
