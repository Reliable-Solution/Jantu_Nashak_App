  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:keep_app/models/orderDetailModel.dart';
import 'package:keep_app/view/dashboard/dashboardScreen.dart';

  import '../../constant/app_constant.dart';
  import '../../controller/orderController.dart';

  class Orderdetailscreen extends StatefulWidget {
    const Orderdetailscreen({super.key});

    @override
    State<Orderdetailscreen> createState() => _OrderdetailscreenState();
  }

  class _OrderdetailscreenState extends State<Orderdetailscreen> {
    @override
    OrderController orderController = Get.find();

    Widget build(BuildContext context) {
      return orderDetailsScreen(context);
    }
  }

  Widget orderDetailsScreen(BuildContext context) {
    OrderController orderController = Get.find();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('ORDER DETAILS'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.help, color: Colors.purple),
        //     onPressed: () {}, // Help functionality
        //   ),
        // ],
        ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (orderController.isDetailLoading.value) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }


          if (orderController.orderDetailList.isEmpty == null) {
            return Center(child: Text("No Order Found"));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              OrderSummary(ordersDetailsList: orderController.orderDetailList),
              // orderSummary(context),

              SizedBox(height: 20),
              // Order Tracking
              orderTracking(context),

              SizedBox(height: 20),
              // Cancel Order Button
              cancelOrderButton(context),

              SizedBox(height: 20),
              // Delivery Address
              deliveryAddress(context),

              SizedBox(height: 20),

              // Payment Details
              paymentDetails(context),
              SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  Widget orderTracking(BuildContext context) {
    OrderController orderController = Get.find();

    return orderController.orderDetailList[0].otherDetail![0].orderStage == "PlaceOrder"?Container(
      width: MediaQuery.sizeOf(context).width,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Placed", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Delivery by ${orderController.orderDetailList[0].otherDetail![0].orderDate}", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              trackingStep("Ordered", "${orderController.orderDetailList[0].otherDetail![0].orderDate}", true),
              trackingStep("Shipped", "", false),
              trackingStep("Out for Delivery", "", false),
              trackingStep("Delivery", "${orderController.orderDetailList[0].otherDetail![0].orderDeliveryDate}", false),
            ],
          ),
        ],
      ),
    )
    :SizedBox();
  }

  // ✅ Tracking Step Widget
  Widget trackingStep(String title, String date, bool completed) {
    OrderController orderController = Get.find();

    return  orderController.orderDetailList[0].otherDetail![0].orderStage == "PlaceOrder"?Column(
      children: [
        Icon(
          completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: completed ? Colors.green : Colors.grey,
        ),
        Text(title, style: TextStyle(fontSize: 12)),
        Text(date, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    )
    :SizedBox();
  }

  // ✅ Cancel Order Button
  Widget cancelOrderButton(BuildContext context) {
    OrderController orderController = Get.find();

    return
      orderController.orderDetailList[0].otherDetail![0].orderStage == "PlaceOrder"
          ? GetBuilder<OrderController>(
          builder: (orderController) =>  Container(
                  width: MediaQuery.sizeOf(context).width,
                  color: Colors.white,
                  padding: EdgeInsets.all( 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
            Expanded(child: Text("Cancellation available till shopping",)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                orderController.cancelOrder(
                    orderController.customerModel!.value.customerId,
                    orderController.orderDetailList[0].otherDetail![0].orderId);
                orderController.getOrder(orderController
                    .customerModel!.value.customerId);
                orderController.getOrderDetail( orderController.orderDetailList[0].otherDetail![0].orderId);
                orderController.update();
              },
              child: Text("Cancel Order", style: TextStyle(color: Colors.white)),
            ),
                    ],
                  ),
                ),
          )
          : cancelOrder(context);
  }

  // ✅ Delivery Address Widget
  Widget deliveryAddress(BuildContext context) {
    OrderController orderController = Get.find();

    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Delivery Address",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Text("${orderController.orderDetailList[0].shippingDetail![0].addressFullName}", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("${orderController.orderDetailList[0].shippingDetail![0].addressColony},\n${orderController.orderDetailList[0].shippingDetail![0].city} ${orderController.orderDetailList[0].shippingDetail![0].state}, ${orderController.orderDetailList[0].shippingDetail![0].pincode}"),
        ],
      ),
    );
  }

  // ✅ Recently Viewed Items
  Widget recentlyViewed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recently Viewed", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(3, (index) => recentlyViewedItem()),
          ),
        ),
      ],
    );
  }

  // ✅ Recently Viewed Item
  Widget recentlyViewedItem() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 100,
      child: Column(
        children: [
          Image.network('https://via.placeholder.com/100',
              width: 100, height: 100),
          Text("Shirt", style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // ✅ Payment Details
  Widget paymentDetails(BuildContext context) {
    OrderController orderController = Get.find();

    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Product Price ₹${orderController.orderDetailList[0].otherDetail![0].total}",
              style: TextStyle(fontWeight: FontWeight.bold)),
          // Text("You saved ₹30", style: TextStyle(color: Colors.green)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.credit_card, color: Colors.grey),
                  SizedBox(width: 5),
                  Text("${orderController.orderDetailList[0].otherDetail![0].orderPaymentMethod}"),
                ],
              ),
              Text("₹${orderController.orderDetailList[0].otherDetail![0].total}", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ Order Summary Component
  class OrderSummary extends StatelessWidget {
    final List<OrderDetailData> ordersDetailsList;

    const OrderSummary({Key? key, required this.ordersDetailsList}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Container(
          color: Colors.white,
        // margin: EdgeInsets.symmetric(vertical: 2),
        // padding: EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: ordersDetailsList.length,
          itemBuilder: (context, index) {

            var orderDetail = ordersDetailsList[index].orders;
            if (orderDetail != null && orderDetail.isNotEmpty) {
              return OrderCard(order: orderDetail);
            } else {
              return Center(child: Text("No Order Details Available"));
            }
            // return OrderCard(order: orders[0].orderDetailData![0].orders![index]);
          },
        ),
      );
    }
  }

  // ✅ Reusable Order Card Component
  class OrderCard extends StatelessWidget {
    final List<Orders> order;

    const OrderCard({Key? key, required this.order}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: order.length,
          itemBuilder: (context, index) {
            print("order dat detailsw ${order[index].productName}");
            return Container(
               // padding: EdgeInsets.all(10),
              // margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
              Image.network(
                          IMAGE_URL + (order[index].productdetailImages!),
                          width: 60,
                          height: 60,
                          errorBuilder: (context, exception, stackTrace) {
                            return Image.asset("assets/images/noInternet.jpg",
                                height: 50, width: 50);
                          },
                        ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order ${order[index].orderdetailId}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(order[index].productName!,
                            style: TextStyle(color: Colors.grey)),
                        Text(" Cash ₹${order[index]
                            .productdetailSrp}",
                            style: TextStyle(color: Colors.black)),
                        Text("All issue easy returns",
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                ],
              ),
            );
          }
      );

    }
  }
  Widget cancelOrder(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.close, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cancelled',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'As per your request on Tue, 18 Mar',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.purple),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: () {
              Get.offAll(DashboardScreen(pageIndex: 0));
              // Navigate to Dashboard
              // Navigator.pushNamed(context, '/dashboard');
            },
            child: const Text(
              'GO TO DASHBOARD',
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
