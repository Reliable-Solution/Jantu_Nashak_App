import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
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
            style: Themes.light.textTheme.headlineLarge,
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
          child: Icon(
            Icons.add,
            color: COLOR.background,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return controller.getAllAddress();
          },
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.searchController,
                          textInputAction: TextInputAction.search,
                          style: GoogleFonts.lato(color: COLOR.appBaseColor),
                          cursorColor: COLOR.appBaseColor,
                          decoration: InputDecoration(
                            hintText: 'Search Help',
                            hintStyle: const TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: controller.searchCategory,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller
                            .searchCategory(controller.searchController.text),
                        child: const Icon(Icons.search, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isSearching.value ||
                      controller.isAddress.value == true) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.filteredList.isEmpty) {
                    return Center(child: Text(StringRes.noDataFound));
                  } else if (controller.filteredList.isNotEmpty) {
                    return ListView.builder(
                      itemCount: controller.filteredList.length,
                      itemBuilder: (context, index) {
                        final address = controller.filteredList[index];
                        // final address = controller.filteredList[index];
                        return Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(),
                              ),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 10.0),
                                          Text(
                                            "${address.addressFullName}",
                                            style: Themes
                                                .light.textTheme.displayMedium!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.0),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 10.0),
                                          Expanded(
                                            child: Text(
                                              '${address.addressColony} ${address.addressPincode} ${address.addressLandmark} \n ${address.addressType}',
                                              style: Themes
                                                  .light.textTheme.bodyMedium!
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.0),
                                      Row(
                                        children: [
                                          SizedBox(width: 10.0),
                                          Text(
                                            "+91 ${address.addressMobileNo}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              print(
                                                  "Address Id ${address.addressId}");
                                              Get.to(PickupAddressScreen(
                                                  address: address));
                                            },
                                            icon: Icon(Icons.edit,
                                                color: COLOR.background),
                                            label: Text(StringRes.edit,
                                                style: TextStyle(
                                                    color: COLOR.background)),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  COLOR.appBaseColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          OutlinedButton.icon(
                                            onPressed: () {
                                              controller.deleteAddressData(
                                                customerId: address.customerId,
                                                addressId: address.addressId,
                                              );
                                              controller.getAllAddress();
                                            },
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            label: Text(StringRes.delete,
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            style: OutlinedButton.styleFrom(
                                              side:
                                                  BorderSide(color: Colors.red),
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
                  }

                  else {
                    return Center(child: Text(StringRes.noDataFound));
                  }
                }),
              ),
            ],
          ),
        ));
  }
}
