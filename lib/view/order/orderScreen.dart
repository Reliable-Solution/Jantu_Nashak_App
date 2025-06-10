import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:keep_app/models/orderModel.dart';
import 'package:keep_app/view/orderDetail/orderDetailScreen.dart';

import '../../Theme/nativeTheme.dart';
import '../../constant/colorConst.dart';
import '../../constant/imagesConst.dart';
import '../../controller/orderController.dart';
import '../../utils/string_res.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/textButtonWidget.dart';
import '../../widget/textWidget.dart';
import '../dashboard/dashboardScreen.dart';
import '../webView/webView_screen.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        actionPadding: 10,
        height: 90,
        appbarPadding: 0,
        elevation: 1,
        title: TextWiget(
          title: "Orders",
          style: Themes.light.textTheme.displayLarge,
        ),
      ),
      // backgroundColor: COLOR.background.withOpacity(),
      backgroundColor: Colors.white,

      body: GetBuilder<OrderController>(
        builder: (orderController) => RefreshIndicator(
          onRefresh: () {
            return orderController
                .getOrder(orderController.customerModel!.value.customerId);
          },
          child: Obx(
            () {
              if (orderController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (orderController.orderList.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 250,
                      child: Image.asset(Images.orderScreen),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextWiget(
                        title: "Your Orders is empty",
                        style: Themes.light.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButtonWidget(
                        text: StringRes.viewProducts,
                        onPressed: () {
                          Get.to(() => DashboardScreen(pageIndex: 0));
                        }),
                  ],
                );

                // return Center(child: Text("No orders found"));
              } else {
                // return Text("hello");
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: orderController.orderList.length,
                  itemBuilder: (context, index) {
                    return OrderCard(
                      order: orderController.orderList[index],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderDataModel order;
  final OrderController orderController = Get.find();

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    // if (order.orderDataModel == null || order.orderDataModel!.isEmpty) {
    //   return SizedBox.shrink(); // Return an empty widget if data is missing
    // }

    var orderData = order; // Safely access first item
    print("Orders data ${orderData}");

    return InkWell(
      onTap: () {
        orderController.getOrderDetail(order.orderId);
        Get.to(Orderdetailscreen());
        print("Order data id is ${order.orderId}");
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.6),
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Center(
                          child: Container(
                              height: 28,
                              width: 28,
                              child: Image.asset(
                                Images.ship,
                                // color: Colors.black,
                                // width: 2,
                              ))),
                      SizedBox(
                        width: 08,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStageDropDown ?? "N/A",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "${order.orderDate ?? "N/A"}",
                              style:
                                  Themes.light.textTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(12),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    )),
              ],
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Image.asset(
                        height: 20, width: 20,
                        Images.tag,
                      ),
                      SizedBox(
                        width: 08,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                            Text(
                              "${order.orderId ?? "N/A"}",
                              style:
                                  Themes.light.textTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Center(
                          child: Container(
                              height: 22,
                              width: 22,
                              child: Image.asset(
                                Images.calendar,
                              ))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shipping Date",
                              style: TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            Text(
                              "${order.orderDeliveryDate ?? "N/A"}",
                              style:
                                  Themes.light.textTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                order.orderStageDropDown == "PlaceOrder"
                    ? Align(
                        alignment: Alignment.topLeft,
                        child:
                        ElevatedButton(
                          // onPressed: () {},
                          onPressed: () {
                            orderController.cancelOrder(
                                orderController.customerModel!.value.customerId,
                                order.orderId);
                            orderController.getOrder(
                                orderController.customerModel!.value.customerId);
                          },
                          style: ElevatedButton.styleFrom(elevation: 0,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                  bottom: Radius.circular(20),
                                ),
                              ),
                              backgroundColor: Colors.red.shade400),
                          child: Text(
                            "Cancel Order",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),

                order.ordertrackingLink != null ? ElevatedButton(
                  // onPressed: () {},
                  onPressed: () {
                       Get.to(WebViewScreen(url: "${order.ordertrackingLink}"));

                       print("Order Tracking ${order.ordertrackingLink}");
                    // orderController.cancelOrder(
                    //     orderController.customerModel!.value.customerId,
                    //     order.orderId);
                    // orderController.getOrder(
                    //     orderController.customerModel!.value.customerId);
                  },
                  style: ElevatedButton.styleFrom(elevation: 0,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                          bottom: Radius.circular(20),
                        ),
                      ),
                      backgroundColor: Colors.blue.shade400),
                  child: Text(
                    "Track Order",
                    style: TextStyle(color: Colors.white),
                  ),
                ):SizedBox.shrink(),

              ],
            ),
            // ElevatedButton(onPressed: () {
            //
            //    Get.to(WebViewScreen(url: "${order.ordertrackingLink}"));
            //
            //    print("Order Tracking ${order.ordertrackingLink}");
            // }, child: Text("Track Order"))
          ],
        ),
      ),
    );
  }
}
