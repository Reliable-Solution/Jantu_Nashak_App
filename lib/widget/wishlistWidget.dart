import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keep_app/constant/app_constant.dart';
import 'package:keep_app/controller/cartController.dart';
import 'package:keep_app/controller/shareProductsController.dart';
import 'package:keep_app/models/cartDetailModel.dart';
import 'package:keep_app/models/wishlistModel.dart';
import 'package:keep_app/utils/string_res.dart';

import '../constant/colorConst.dart';
import '../utils/services/services.dart';

class MyWishComponet extends StatefulWidget {
  WishlistModel wishdata;

  Function? onRemove, onQtyUpdate;

  MyWishComponet({required this.wishdata, this.onRemove, this.onQtyUpdate});

  @override
  _MyWishComponetState createState() => _MyWishComponetState();
}

class _MyWishComponetState extends State<MyWishComponet> {
  bool isCartRemoveLoading = false;
  bool isUpdateLoading = false;
  ShareProductController shareProductController = Get.find();
  int Qty = 0;

  void add() {
    setState(() {
      Qty++;
    });
    shareProductController.removeWishList(
        productId: widget.wishdata.productId!);
  }

  void remove() {
    if (Qty != 0) {
      setState(() {
        Qty--;
      });
      shareProductController.removeWishList(
          productId: widget.wishdata.productId!);
    }
  }

  double? productQty;
  @override
  void initState() {
    setState(() {
      productQty =
          double.parse("${widget.wishdata.packInfo![0].productdetailQty}");
      Qty = int.parse("${widget.wishdata.packInfo![0].productdetailQty}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3),
          child: Container(
            height: 120,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                      child: Image.network(
                        IMAGE_URL +
                            (widget
                                .wishdata.packInfo![0].productdetailImages![0]),
                        width: 100,
                        height: 120,
                        errorBuilder: (context, exception, stackTrace) {
                          return Image.asset("assets/no-image.png",
                              height: 120, width: 100);
                        },
                      ),
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${widget.wishdata.productName}",
                            style: const TextStyle(fontSize: 15)),
                        RichText(
                          text: TextSpan(
                              text: StringRes.mrpLabel,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "${StringRes.inr} ${widget.wishdata.packInfo![0].productdetailMrp}",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough),
                                )
                              ]),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  " ${StringRes.inr} "
                                  "${widget.wishdata.packInfo![0].productdetailSrp}",
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: [
                                  Qty == 1
                                      ? GestureDetector(
                                          onTap: () {
                                            shareProductController
                                                .removeWishList(
                                              productId:
                                                  widget.wishdata.productId!,
                                            );
                                            widget.onRemove!();
                                          },
                                          child: isCartRemoveLoading == true
                                              ? Container(
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
                                                              .appBaseColor)),
                                                  child: Center(
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      child: const Center(
                                                          child: SpinKitRipple(
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
                                                              .appBaseColor)),
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
                                                    BorderRadius.circular(4.0),
                                                border: Border.all(
                                                    width: 1,
                                                    color: COLOR.appBaseColor)),
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
                                          style: const TextStyle(fontSize: 20),
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
                                              "${widget.wishdata.packInfo![0].productdetailQty}")
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
                                                    BorderRadius.circular(4.0),
                                                border: Border.all(
                                                    width: 1,
                                                    color: COLOR.appBaseColor)),
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
                                                  "${StringRes.only} ${productQty!.toStringAsFixed(0)}${StringRes.availableStock}",
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
                                                    BorderRadius.circular(4.0),
                                                border: Border.all(
                                                    width: 1,
                                                    color: COLOR.appBaseColor)),
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
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
