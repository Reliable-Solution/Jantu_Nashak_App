import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keep_app/constant/app_constant.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/homeController.dart';
import 'package:keep_app/models/cartDetailModel.dart';

import '../Theme/nativeTheme.dart';
import '../constant/colorConst.dart';
import '../utils/services/services.dart';
import '../utils/string_res.dart';

class MyCartComponent extends StatefulWidget {
  CartDetailModel cartData;

  Function? onRemove, onQtyUpdate;

  MyCartComponent({required this.cartData, this.onRemove, this.onQtyUpdate});

  @override
  _MyCartComponentState createState() => _MyCartComponentState();
}

class _MyCartComponentState extends State<MyCartComponent> {
  bool isCartRemoveLoading = false;
  bool isUpdateLoading = false;
  CartController cartController = Get.find();
  HomeController homeController = Get.find();
  int Qty = 0;

  void add() {
    setState(() {
      Qty++;
    });
    cartController.updateCartQty(widget.cartData.cartId!, Qty.toString());
  }

  void remove() {
    if (Qty != 0) {
      setState(() {
        Qty--;
      });
      cartController.updateCartQty(widget.cartData.cartId!, Qty.toString());
    }
  }

  double? productQty;

  @override
  void initState() {
    setState(() {
      productQty =
          double.parse("${widget.cartData.packInfo![0].productdetailQty}");
      Qty = int.parse("${widget.cartData.cartQuantity}");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("CartWidget image: ${widget.cartData.productdetailImages![0]!.toString()}");

    return _buildCartItem();
  }
  Widget _buildCartItem(
      // CartDetailModel item, int index
      ) {
    print("CartWidget name: ${homeController.customerModel!.value?.customerName}");

    return Container(
        decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    "${IMAGE_URL + widget.cartData.packInfo![0].productdetailImages![0]!}" ??
                        'http://surti.idnmserver.com/resources/product_no_image.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/images/noInternet.jpg");
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // Product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // item.productName
                        widget.cartData.productName
                            ?? StringRes.productName,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹${widget.cartData.productdetailSrp ?? 0}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        // item.isEasyReturn == 1
                        //     ? "All issue easy returns allowed"
                        //     :
                        StringRes.onlyWrongDefectItemReturnsAllowed,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "${StringRes.size}: ${widget.cartData.productSize ?? '${StringRes.size}'}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "${StringRes.quantity} : ${Qty}",
                            // "Qty: ${item.categoryId ?? 1}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${StringRes.color}: ${widget.cartData.productColor ?? '${StringRes.color}'}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Qty == 1
                              ? GestureDetector(
                            onTap: () {
                              cartController.removeFromCart(
                                cartID: widget.cartData.cartId!,
                              );
                              homeController.getDashboardData(homeController.customerModel!.value.customerId);
                              cartController.getCartTotal(cartController.customerModel!.value.customerId!);
                              widget.onRemove!();
                              cartController.update();
                            },
                            child: isCartRemoveLoading == true
                                ? Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color:
                                  COLOR.appBaseColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors
                                          .grey[300]!,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                  borderRadius:
                                  BorderRadius
                                      .circular(4.0),
                                  border: Border.all(
                                      width: 1,
                                      color: COLOR
                                          .appBaseColor)),
                              child: Center(
                                child: SizedBox(
                                  height: MediaQuery.of(
                                      context)
                                      .size
                                      .height,
                                  child: const Center(
                                      child:
                                      SpinKitRipple(
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            )
                                : Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: COLOR.appBaseColor,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    Colors.grey[300]!,
                                    blurRadius: 2.0,
                                  ),
                                ],
                                borderRadius:
                                BorderRadius.circular(
                                    4.0),
                                border: Border.all(
                                    width: 1,
                                    color: COLOR
                                        .appBaseColor),
                              ),
                              child: const Center(
                                child: Icon(
                                    Icons
                                        .delete_outline_sharp,
                                    color: Colors.white,
                                    size: 20),
                              ),
                            ),
                          )
                              : InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: COLOR.appBaseColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                  borderRadius:
                                  BorderRadius.circular(
                                      4.0),
                                  border: Border.all(
                                      width: 1,
                                      color:
                                      COLOR.appBaseColor)),
                              width: 30,
                              height: 30,
                              child: const Center(
                                child: Icon(Icons.remove,
                                    color: Colors.white,
                                    size: 20),
                              ),
                            ),
                            onTap: () {
                              remove();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  "$Qty",
                                  style:
                                  const TextStyle(fontSize: 20),
                                ),
                                isUpdateLoading == true
                                    ? Center(
                                  child:
                                  CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    valueColor:
                                    AlwaysStoppedAnimation<
                                        Color>(
                                        COLOR.appBaseColor),
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          ),
                          Qty.toDouble() <
                              double.parse(
                                  "${widget.cartData.productdetailQty}")
                              ? InkWell(
                            onTap: () {
                              add();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: COLOR.appBaseColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                  borderRadius:
                                  BorderRadius.circular(
                                      4.0),
                                  border: Border.all(
                                      width: 1,
                                      color:
                                      COLOR.appBaseColor)),
                              width: 30,
                              height: 30,
                              child: const Center(
                                child: Icon(Icons.add,
                                    color: Colors.white,
                                    size: 20),
                              ),
                            ),
                          )
                              : InkWell(
                            onTap: () {
                              Fluttertoast.showToast(
                                msg:
                                "${StringRes.only} ${productQty!.toStringAsFixed(0)} ${StringRes.availableStock}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: COLOR.appBaseColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                  borderRadius:
                                  BorderRadius.circular(
                                      4.0),
                                  border: Border.all(
                                      width: 1,
                                      color:
                                      COLOR.appBaseColor)),
                              width: 30,
                              height: 30,
                              child: const Center(
                                child: Icon(Icons.add,
                                    color: Colors.white,
                                    size: 20),
                              ),
                            ),
                          )
                        ],
                      )

                    ],
                  ),
                ),

                // Arrow icon
                // Icon(
                //   Icons.chevron_right,
                //   color: Colors.grey.shade400,
                // ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${StringRes.soldBy} : ${widget.cartData.productName ?? '${StringRes.seller}'}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                 Text(
                  StringRes.freeDelivery,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}

