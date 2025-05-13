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
    return _buildCartItem();
    //   Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.only(top: 3.0, bottom: 3),
    //       child: Card(
    //         elevation: 0,
    //         color: COLOR.background,
    //         child: Container(
    //           decoration: BoxDecoration(
    //               boxShadow: [
    //                 BoxShadow(
    //                     blurRadius: 4, spreadRadius: -2, color: Colors.white)
    //               ],
    //               color: COLOR.background.withOpacity(0.98),
    //               borderRadius: BorderRadius.circular(14),
    //               border: Border.all(width: 0.0, color: COLOR.transparent)),
    //           height: 120,
    //            margin: EdgeInsets.all(4),
    //            // padding: EdgeInsets.all(10),
    //           // color: Colors.white,
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 4.0, bottom: 4),
    //                 child: Image.network(
    //                   IMAGE_URL + (widget.cartData.productdetailImages!),
    //                   width: 100,
    //                   height: 120,
    //                   errorBuilder: (context, exception, stackTrace) {
    //                     return Image.asset("assets/no-image.png",
    //                         height: 120, width: 100);
    //                     // Image.network('http://surti.idnmserver.com/resources/product_no_image.png');
    //                   },
    //                 ),
    //               ),
    //               Expanded(
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Text("${widget.cartData.productName}",
    //                     style:
    //                     Themes.light.textTheme.bodyMedium!.copyWith(
    //                      overflow: TextOverflow.ellipsis,
    //                         fontSize: 14,
    //                         color: COLOR.black,
    //                         fontWeight: FontWeight.w800,
    //                         // decoration: TextDecoration.lineThrough
    //                     )
    //                           // style: const TextStyle(fontSize: 15)
    //                     ),
    //                       RichText(
    //                         text: TextSpan(
    //                             text: StringRes.mrpLabel,
    //                             style: const TextStyle(
    //                                 color: Colors.grey, fontSize: 14),
    //                             children: <TextSpan>[
    //                               TextSpan(
    //                                 text:
    //                                     " Rs.${widget.cartData.productdetailMrp}",
    //
    //                                 style: Themes.dark.textTheme.displayMedium!
    //                                     .copyWith(
    //                                   color: COLOR.grey,
    //                                     decoration: TextDecoration.lineThrough
    //                                 ),
    //                                 // style: const TextStyle(
    //                                 //     color: Colors.grey,
    //                                 //     fontSize: 14,
    //                                 //     decoration: TextDecoration.lineThrough),
    //                               )
    //                             ]),
    //                       ),
    //                       Row(
    //                         children: [
    //                           Expanded(
    //                             child: Text(
    //                                 " Rs."
    //                                 "${widget.cartData.productdetailSrp}",
    //                                 style: const TextStyle(
    //                                     fontSize: 17,
    //                                     color: Colors.black,
    //                                     fontWeight: FontWeight.bold)),
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.only(right: 10.0),
    //                             child: Row(
    //                               children: [
    //                                 Qty == 1
    //                                     ? GestureDetector(
    //                                         onTap: () {
    //                                           cartController.removeFromCart(
    //                                             cartID: widget.cartData.cartId!,
    //                                           );
    //                                           homeController.getDashboardData(homeController.customerModel!.value.customerId);
    //                                           cartController.getCartTotal(cartController.customerModel!.value.customerId!);
    //                                           widget.onRemove!();
    //                                           cartController.update();
    //
    //                                           // homeController.getDashboardData(homeController.customerModel!.value.customerId);
    //                                           // cartController.getCartTotal(cartController.customerModel!.value.customerId!);
    //                                           // cartController.update();
    //
    //                                         },
    //                                         child: isCartRemoveLoading == true
    //                                             ? Container(
    //                                                 width: 30,
    //                                                 height: 30,
    //                                                 decoration: BoxDecoration(
    //                                                     color:
    //                                                         COLOR.appBaseColor,
    //                                                     boxShadow: [
    //                                                       BoxShadow(
    //                                                         color: Colors
    //                                                             .grey[300]!,
    //                                                         blurRadius: 2.0,
    //                                                       ),
    //                                                     ],
    //                                                     borderRadius:
    //                                                         BorderRadius
    //                                                             .circular(4.0),
    //                                                     border: Border.all(
    //                                                         width: 1,
    //                                                         color: COLOR
    //                                                             .appBaseColor)),
    //                                                 child: Center(
    //                                                   child: SizedBox(
    //                                                     height: MediaQuery.of(
    //                                                             context)
    //                                                         .size
    //                                                         .height,
    //                                                     child: const Center(
    //                                                         child:
    //                                                             SpinKitRipple(
    //                                                       color: Colors.white,
    //                                                     )),
    //                                                   ),
    //                                                 ),
    //                                               )
    //                                             : Container(
    //                                                 width: 30,
    //                                                 height: 30,
    //                                                 decoration: BoxDecoration(
    //                                                   color: COLOR.appBaseColor,
    //                                                   boxShadow: [
    //                                                     BoxShadow(
    //                                                       color:
    //                                                           Colors.grey[300]!,
    //                                                       blurRadius: 2.0,
    //                                                     ),
    //                                                   ],
    //                                                   borderRadius:
    //                                                       BorderRadius.circular(
    //                                                           4.0),
    //                                                   border: Border.all(
    //                                                       width: 1,
    //                                                       color: COLOR
    //                                                           .appBaseColor),
    //                                                 ),
    //                                                 child: const Center(
    //                                                   child: Icon(
    //                                                       Icons
    //                                                           .delete_outline_sharp,
    //                                                       color: Colors.white,
    //                                                       size: 20),
    //                                                 ),
    //                                               ),
    //                                       )
    //                                     : InkWell(
    //                                         child: Container(
    //                                           decoration: BoxDecoration(
    //                                               color: COLOR.appBaseColor,
    //                                               boxShadow: [
    //                                                 BoxShadow(
    //                                                   color: Colors.grey[300]!,
    //                                                   blurRadius: 2.0,
    //                                                 ),
    //                                               ],
    //                                               borderRadius:
    //                                                   BorderRadius.circular(
    //                                                       4.0),
    //                                               border: Border.all(
    //                                                   width: 1,
    //                                                   color:
    //                                                       COLOR.appBaseColor)),
    //                                           width: 30,
    //                                           height: 30,
    //                                           child: const Center(
    //                                             child: Icon(Icons.remove,
    //                                                 color: Colors.white,
    //                                                 size: 20),
    //                                           ),
    //                                         ),
    //                                         onTap: () {
    //                                           remove();
    //                                         },
    //                                       ),
    //                                 Padding(
    //                                   padding: const EdgeInsets.only(
    //                                       left: 10.0, right: 10.0),
    //                                   child: Stack(
    //                                     alignment: Alignment.center,
    //                                     children: [
    //                                       Text(
    //                                         "$Qty",
    //                                         style:
    //                                             const TextStyle(fontSize: 20),
    //                                       ),
    //                                       isUpdateLoading == true
    //                                           ? Center(
    //                                               child:
    //                                                   CircularProgressIndicator(
    //                                                 strokeWidth: 1.5,
    //                                                 valueColor:
    //                                                     AlwaysStoppedAnimation<
    //                                                             Color>(
    //                                                         COLOR.appBaseColor),
    //                                               ),
    //                                             )
    //                                           : Container(),
    //                                     ],
    //                                   ),
    //                                 ),
    //                                 Qty.toDouble() <
    //                                         double.parse(
    //                                             "${widget.cartData.productdetailQty}")
    //                                     ? InkWell(
    //                                         onTap: () {
    //                                           add();
    //                                         },
    //                                         child: Container(
    //                                           decoration: BoxDecoration(
    //                                               color: COLOR.appBaseColor,
    //                                               boxShadow: [
    //                                                 BoxShadow(
    //                                                   color: Colors.grey[300]!,
    //                                                   blurRadius: 2.0,
    //                                                 ),
    //                                               ],
    //                                               borderRadius:
    //                                                   BorderRadius.circular(
    //                                                       4.0),
    //                                               border: Border.all(
    //                                                   width: 1,
    //                                                   color:
    //                                                       COLOR.appBaseColor)),
    //                                           width: 30,
    //                                           height: 30,
    //                                           child: const Center(
    //                                             child: Icon(Icons.add,
    //                                                 color: Colors.white,
    //                                                 size: 20),
    //                                           ),
    //                                         ),
    //                                       )
    //                                     : InkWell(
    //                                         onTap: () {
    //                                           Fluttertoast.showToast(
    //                                             msg:
    //                                                 "${StringRes.only} ${productQty!.toStringAsFixed(0)} ${StringRes.availableStock}",
    //                                             toastLength: Toast.LENGTH_SHORT,
    //                                             gravity: ToastGravity.SNACKBAR,
    //                                             timeInSecForIosWeb: 1,
    //                                           );
    //                                         },
    //                                         child: Container(
    //                                           decoration: BoxDecoration(
    //                                               color: COLOR.appBaseColor,
    //                                               boxShadow: [
    //                                                 BoxShadow(
    //                                                   color: Colors.grey[300]!,
    //                                                   blurRadius: 2.0,
    //                                                 ),
    //                                               ],
    //                                               borderRadius:
    //                                                   BorderRadius.circular(
    //                                                       4.0),
    //                                               border: Border.all(
    //                                                   width: 1,
    //                                                   color:
    //                                                       COLOR.appBaseColor)),
    //                                           width: 30,
    //                                           height: 30,
    //                                           child: const Center(
    //                                             child: Icon(Icons.add,
    //                                                 color: Colors.white,
    //                                                 size: 20),
    //                                           ),
    //                                         ),
    //                                       )
    //                               ],
    //                             ),
    //                           )
    //                         ],
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
  Widget _buildCartItem(
      // CartDetailModel item, int index
      ) {
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
                    "${IMAGE_URL + widget.cartData.productdetailImages!}" ??
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
                            ?? "Product Name",
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
                        "Only wrong/defect item returns allowed",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "Size: 'Free Size'",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Quantity : ${Qty}",
                            // "Qty: ${item.categoryId ?? 1}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
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

                              // homeController.getDashboardData(homeController.customerModel!.value.customerId);
                              // cartController.getCartTotal(cartController.customerModel!.value.customerId!);
                              // cartController.update();

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

                      // Row(
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         cartController.removeFromCart(
                      //           cartID: widget.cartData.cartId!,
                      //         );
                      //         homeController.getDashboardData(homeController.customerModel!.value.customerId);
                      //         cartController.getCartTotal(cartController.customerModel!.value.customerId!);
                      //         widget.onRemove!();
                      //         cartController.update();
                      //         // remove();
                      //
                      //         // cartController.removeFromCart(item.cartId);
                      //       },
                      //       child:
                      //       // Row(
                      //       //   children: [
                      //       Row(
                      //         children: [
                      //           Icon(Icons.close,
                      //               size: 16, color: Colors.grey.shade700),
                      //           const SizedBox(width: 4),
                      //           Text(
                      //             "Remove",
                      //             style: TextStyle(
                      //               fontSize: 12,
                      //               color: Colors.grey.shade700,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //
                      //       // ],
                      //       // ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 10.0),
                      //       child: Row(
                      //         children: [
                      //           Qty == 1
                      //               ? GestureDetector(
                      //             onTap: () {
                      //               cartController.removeFromCart(
                      //                 cartID: item.cartId!,
                      //               );
                      //               homeController.getDashboardData(
                      //                   homeController.customerModel!
                      //                       .value.customerId);
                      //               cartController.getCartTotal(
                      //                   cartController.customerModel!
                      //                       .value.customerId!);
                      //               // widget.onRemove!();
                      //               cartController.update();
                      //
                      //               // homeController.getDashboardData(homeController.customerModel!.value.customerId);
                      //               // cartController.getCartTotal(cartController.customerModel!.value.customerId!);
                      //               // cartController.update();
                      //             },
                      //             child: isCartRemoveLoading == true
                      //                 ? Container(
                      //               width: 30,
                      //               height: 30,
                      //               decoration: BoxDecoration(
                      //                   color: COLOR.appBaseColor,
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color:
                      //                       Colors.grey[300]!,
                      //                       blurRadius: 2.0,
                      //                     ),
                      //                   ],
                      //                   borderRadius:
                      //                   BorderRadius.circular(
                      //                       4.0),
                      //                   border: Border.all(
                      //                       width: 1,
                      //                       color: COLOR
                      //                           .appBaseColor)),
                      //               child: Center(
                      //                 child: SizedBox(
                      //                   height:
                      //                   MediaQuery.of(context)
                      //                       .size
                      //                       .height,
                      //                   child: const Center(
                      //                       child: SpinKitRipple(
                      //                         color: Colors.white,
                      //                       )),
                      //                 ),
                      //               ),
                      //             )
                      //                 : Container(
                      //               width: 30,
                      //               height: 30,
                      //               decoration: BoxDecoration(
                      //                 color: COLOR.appBaseColor,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.grey[300]!,
                      //                     blurRadius: 2.0,
                      //                   ),
                      //                 ],
                      //                 borderRadius:
                      //                 BorderRadius.circular(
                      //                     4.0),
                      //                 border: Border.all(
                      //                     width: 1,
                      //                     color:
                      //                     COLOR.appBaseColor),
                      //               ),
                      //               child: const Center(
                      //                 child: Icon(
                      //                     Icons
                      //                         .delete_outline_sharp,
                      //                     color: Colors.white,
                      //                     size: 20),
                      //               ),
                      //             ),
                      //           )
                      //               : InkWell(
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                   color: COLOR.appBaseColor,
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey[300]!,
                      //                       blurRadius: 2.0,
                      //                     ),
                      //                   ],
                      //                   borderRadius:
                      //                   BorderRadius.circular(4.0),
                      //                   border: Border.all(
                      //                       width: 1,
                      //                       color: COLOR.appBaseColor)),
                      //               width: 30,
                      //               height: 30,
                      //               child: const Center(
                      //                 child: Icon(Icons.remove,
                      //                     color: Colors.white, size: 20),
                      //               ),
                      //             ),
                      //             onTap: () {
                      //               remove();
                      //             },
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.only(
                      //                 left: 10.0, right: 10.0),
                      //             child: Stack(
                      //               alignment: Alignment.center,
                      //               children: [
                      //                 Text(
                      //                   "$Qty",
                      //                   style: const TextStyle(fontSize: 20),
                      //                 ),
                      //                 isUpdateLoading == true
                      //                     ? Center(
                      //                   child: CircularProgressIndicator(
                      //                     strokeWidth: 1.5,
                      //                     valueColor:
                      //                     AlwaysStoppedAnimation<
                      //                         Color>(
                      //                         COLOR.appBaseColor),
                      //                   ),
                      //                 )
                      //                     : Container(),
                      //               ],
                      //             ),
                      //           ),
                      //           Qty.toDouble() <
                      //               double.parse("${item.productdetailQty}")
                      //               ? InkWell(
                      //             onTap: () {
                      //               add();
                      //             },
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                   color: COLOR.appBaseColor,
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey[300]!,
                      //                       blurRadius: 2.0,
                      //                     ),
                      //                   ],
                      //                   borderRadius:
                      //                   BorderRadius.circular(4.0),
                      //                   border: Border.all(
                      //                       width: 1,
                      //                       color: COLOR.appBaseColor)),
                      //               width: 30,
                      //               height: 30,
                      //               child: const Center(
                      //                 child: Icon(Icons.add,
                      //                     color: Colors.white, size: 20),
                      //               ),
                      //             ),
                      //           )
                      //               : InkWell(
                      //             onTap: () {
                      //               Fluttertoast.showToast(
                      //                 msg:
                      //                 "${StringRes.only} ${productQty!.toStringAsFixed(0)} ${StringRes.availableStock}",
                      //                 toastLength: Toast.LENGTH_SHORT,
                      //                 gravity: ToastGravity.SNACKBAR,
                      //                 timeInSecForIosWeb: 1,
                      //               );
                      //             },
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                   color: COLOR.appBaseColor,
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey[300]!,
                      //                       blurRadius: 2.0,
                      //                     ),
                      //                   ],
                      //                   borderRadius:
                      //                   BorderRadius.circular(4.0),
                      //                   border: Border.all(
                      //                       width: 1,
                      //                       color: COLOR.appBaseColor)),
                      //               width: 30,
                      //               height: 30,
                      //               child: const Center(
                      //                 child: Icon(Icons.add,
                      //                     color: Colors.white, size: 20),
                      //               ),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),

                // Arrow icon
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
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
                  "Sold by : ${widget.cartData.productName ?? 'Seller'}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                const Text(
                  "Free Delivery",
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

