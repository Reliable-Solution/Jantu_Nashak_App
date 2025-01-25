import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:keep_app/controller/addressController.dart';
import 'package:keep_app/view/home/pickupAddressScreen.dart';

class AlladdressScreen extends StatefulWidget {
  const AlladdressScreen({super.key});

  @override
  State<AlladdressScreen> createState() => _AlladdressScreenState();
}

class _AlladdressScreenState extends State<AlladdressScreen> {
  // AddressController controller = Get.put(AddressController());
  final AddressController controller = Get.put(AddressController());

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // readData();
  //   // controller.getAllAddress();
  //   super.initState();
  // }
  //  void readData(){
  //   controller.getPrefs();
  // //   controller.getAllAddress();
  //  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Address"),
        ),
        body: Obx(
                () {
              if (controller.allAddressList.isNotEmpty) {
                if (controller.isAddress.value) {
                return  ListView.builder(
                    itemCount: controller.allAddressList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        // decoration: BoxDecoration(
                        //   gradient: LinearGradient(
                        //     colors: [Colors.teal.shade400, Colors.teal.shade800],
                        //     begin: Alignment.topCenter,
                        //     end: Alignment.bottomCenter,
                        //   ),
                        // ),
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
                                // Profile Picture Placeholder
                                // Center(
                                //   child: CircleAvatar(
                                //     radius: 40.0,
                                //     backgroundColor: Colors.teal.shade100,
                                //     child: Icon(
                                //       Icons.person,
                                //       size: 40,
                                //       color: Colors.teal,
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(height: 20.0),
                                // Name
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.teal,
                                      size: 28,
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      "${controller.allAddressList[index]
                                          .addressFullName}",
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
                                        '${controller.allAddressList[index]
                                            .addressColony}\n${controller
                                            .allAddressList[index]
                                            .cityName}, ${controller
                                            .allAddressList[index]
                                            .stateName} ${controller
                                            .allAddressList[index]
                                            .addressPincode}\n${controller
                                            .allAddressList[index]
                                            .addressLandmark}',
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
                                      "${controller.allAddressList[index]
                                          .customerPhoneNo}",
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
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
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                    ),
                                    OutlinedButton.icon(
                                      onPressed: () {
                                        // Add delete functionality
                                      },
                                      icon: Icon(
                                          Icons.delete, color: Colors.red),
                                      label: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Colors.red),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
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
                }
                else {
                  return Center(child: Text("No data found"),);
                }
              }
              else {
                return Center(child: CircularProgressIndicator(),);
              }
            })
    );
  }
}
