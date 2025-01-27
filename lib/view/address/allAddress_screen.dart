import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keep_app/controller/addressController.dart';
import 'package:keep_app/view/address/pickupAddressScreen.dart';

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
        appBar: AppBar(
          title: Text("All Address"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.txtAddress.clear();
            controller.txtFullname.clear();
            controller.txtLandmark.clear();
            controller.txtMobileno.clear();
            controller.txtPincode.clear();
            controller.txtType.clear();
            Get.to(()=> PickupAddressScreen());
          },
          child: Icon(Icons.add),
        ),
        body: Obx(() {
          if (controller.allAddressList.isNotEmpty) {
            if (controller.isAddress.value) {
              return ListView.builder(
                itemCount: controller.allAddressList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15.0,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.teal,
                                  size: 28,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  "${controller.allAddressList[index].addressFullName}",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            // Address
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.teal,
                                  size: 28,
                                ),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Text(
                                    '${controller.allAddressList[index].addressColony}\n${controller.allAddressList[index].cityName}, ${controller.allAddressList[index].stateName} ${controller.allAddressList[index].addressPincode}\n${controller.allAddressList[index].addressLandmark}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black54,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            // Phone
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.teal,
                                  size: 28,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  "${controller.allAddressList[index].customerPhoneNo}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            // Action Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Add navigation or edit functionality
                                  },
                                  icon: Icon(Icons.edit),
                                  label: Text('Edit'),
                                  style: ElevatedButton.styleFrom(
                                    // primary: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    controller.deleteAddressData(
                                        customerId: controller.allAddressList[index].customerId,
                                        addressId: controller.allAddressList[index].addressId);
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  label: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.red),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
              child: Text("No data found"),
            );
          }
        }));
  }
}
