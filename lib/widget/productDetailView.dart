import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keep_app/controller/productDetailController.dart';
import 'package:keep_app/models/productModel.dart';
import 'package:keep_app/widget/textButtonWidget.dart';
import 'package:keep_app/widget/textWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

import '../Theme/nativeTheme.dart';
import '../constant/app_constant.dart';
import '../constant/colorConst.dart';
import '../controller/homeController.dart';
import '../view/AddtoCard/cartScreen.dart';
import 'alignWidget.dart';
import 'appBarWidget.dart';
import 'buttonWidget.dart';
import 'dividerWidgets.dart';
import 'iconButtonWidget.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel? products;

  ProductDetailScreen({super.key, this.products});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailsController productDetailsController = Get.find();
  productRemove(){
    widget.products!.packInfo![0].isCart = false;
    productDetailsController.update();
  }
  @override
  void initState() {
    productDetailsController.Qty =
        int.parse(widget.products!.packInfo![0].cartqty!);
    productDetailsController.productQty =
        int.parse("${widget.products!.packInfo![0].productdetailQty}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        height: 90,
        appbarPadding: 0,
        action: [
          IconButtonWidget(
            voidCallback: () {
              // Get.to(() => SearchScreen());
            },
            icons: Icons.search,
            color: COLOR.black,
          ),
          IconButtonWidget(
            voidCallback: () {
              // Get.to(() => ShareProductScreen());
            },
            icons: Icons.favorite_border,
            color: COLOR.black,
          ),
          IconButtonWidget(
            voidCallback: () {
              Get.to(() => CartScreen(removeCart: productRemove,));
            },
            icons: Icons.shopping_cart_outlined,
            color: COLOR.black,
          ),
        ],
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: COLOR.greyback,
            size: 20,
          ),
        ),
      ),
      backgroundColor: COLOR.greyLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // Get.to(() => ProductImageScreen(products: products!));
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: (MediaQuery.of(context).size.height * 50) / 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          '$IMAGE_URL${widget.products!.subcategoryImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: COLOR.background,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
                    children: <Widget>[
                      AlignWidget(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8),
                              child: TextWiget(title: 'Similar Products'),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: COLOR.appBaseColor),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '$IMAGE_URL${widget.products!.subcategoryImage}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 5, top: 10),
                                  alignment: Alignment.centerLeft,
                                  child: TextWiget(
                                    title: '${widget.products!.productName}',
                                    style: Themes.light.textTheme.displayLarge!
                                        .copyWith(
                                      color: COLOR.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextWiget(
                                        title:
                                            '₹${widget.products!.packInfo![0].productdetailMrp} ',
                                        style: Themes.dark.textTheme.bodyLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w600)),
                                    TextWiget(
                                        title:
                                            '${widget.products!.packInfo![0].productdetailMrp}',
                                        style: Themes
                                            .dark.textTheme.displayMedium!
                                            .copyWith(
                                          color: COLOR.grey,
                                          fontWeight: FontWeight.normal,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )),
                                    TextWiget(
                                        title: ' 9% off',
                                        style: Themes
                                            .dark.textTheme.displayMedium!
                                            .copyWith(
                                          color: COLOR.green,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            child: GetBuilder<HomeController>(
                              builder: (_controller) => IconButtonWidget(
                                voidCallback: () {
                                  if (widget.products!.isFav == false) {
                                    widget.products!.isFav = true;
                                  } else {
                                    widget.products!.isFav = false;
                                  }

                                  _controller.update();
                                },
                                color: widget.products!.isFav == false
                                    ? COLOR.black
                                    : COLOR.appBaseColor,
                                icons: widget.products!.isFav == false
                                    ? Icons.favorite_border
                                    : Icons.favorite,
                                size: 29,
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                            child: IconButtonWidget(
                              voidCallback: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: Column(
                                        children: [
                                          Text("Images"),
                                          Divider(
                                            color: Colors.black,
                                          ),
                                          Text("Description"),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                List<XFile> files = [];
                                List<String> images = widget.products!
                                        .packInfo![0].productdetailImages ??
                                    [];
                                for (int i = 0; i < images.length; i++) {
                                  final url = Uri.parse(images[i]);
                                  final response = await http.get(url);

                                  var dir = await getTemporaryDirectory();

                                  File file =
                                      await File('${dir.path}/$i\\myItem.png')
                                          .writeAsBytes(response.bodyBytes);

                                  files.add(XFile(file.path));
                                }

                                await Share.shareXFiles(files);
                                // await Share.share("${products!.details.toString()}");
                              },
                              icons: Icons.share_outlined,
                              color: COLOR.black,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: AlignWidget(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: COLOR.greyLight.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextWiget(
                              title: 'Free Delivery',
                              style: Themes.light.textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: AlignWidget(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 6),
                                decoration: BoxDecoration(
                                  color: COLOR.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    TextWiget(
                                      title:
                                          '${widget.products!.packInfo![0].productdetailMrp}',
                                      style: Themes
                                          .light.textTheme.displaySmall!
                                          .copyWith(
                                        color: COLOR.background,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(Icons.star,
                                        size: 13, color: COLOR.background)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: TextWiget(
                                  title: '(28,717)',
                                  style: Themes.light.textTheme.bodyMedium!
                                      .copyWith(color: COLOR.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: COLOR.background,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    AlignWidget(
                      alignment: Alignment.centerLeft,
                      child: TextWiget(
                        title: 'Select Size',
                        style: Themes.dark.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: AlignWidget(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: COLOR.appBaseColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: COLOR.pinkLight,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: FittedBox(
                              child: TextWiget(
                                title: 'Free Size',
                                style: Themes.light.textTheme.displaySmall!
                                    .copyWith(color: COLOR.appBaseColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: COLOR.background,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AlignWidget(
                          alignment: Alignment.centerLeft,
                          child: TextWiget(
                            title: 'Product Details',
                            style:
                                Themes.dark.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final snackBar = SnackBar(
                              content: TextWiget(
                                title: 'Copy Product Details',
                                style: Themes.light.textTheme.displaySmall!
                                    .copyWith(color: COLOR.background),
                              ),
                              action: SnackBarAction(
                                label: 'Undo',
                                textColor: COLOR.appBaseColor,
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: TextWiget(
                            title: 'COPY',
                            style:
                                Themes.light.textTheme.displaySmall!.copyWith(
                              color: COLOR.appBaseColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      widget.products!.productDescription!,
                      style: Themes.light.textTheme.displaySmall!.copyWith(
                        color: COLOR.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: Get.height > 800
            ? MediaQuery.of(context).size.height * 0.1
            : MediaQuery.of(context).size.height * 0.12,
        color: COLOR.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DividerWidget(thickness: 1, height: 0),
            Expanded(
              child: AlignWidget(
                alignment: Alignment.center,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: GetBuilder<ProductDetailsController>(
                        builder: (controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /*widget.products!.packInfo![0].isCart ?? false
                              ? Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: controller.Qty == 1
                                          ? GestureDetector(
                                              onTap: () {
                                                // _removeFromCart();
                                              },
                                              child: controller.isCartRemoveLoading == true
                                                  ? Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration:
                                                          BoxDecoration(
                                                              color: COLOR
                                                                  .appBaseColor,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                          .grey[
                                                                      300]!,
                                                                  blurRadius:
                                                                      2.0,
                                                                ),
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: COLOR
                                                                      .appBaseColor)),
                                                      child: Center(
                                                        child: SizedBox(
                                                          height:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height,
                                                          child: const Center(
                                                              child:
                                                                  SpinKitRipple(
                                                            color:
                                                                Colors.white,
                                                          )),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration:
                                                          BoxDecoration(
                                                              color: COLOR
                                                                  .appBaseColor,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                          .grey[
                                                                      300]!,
                                                                  blurRadius:
                                                                      2.0,
                                                                ),
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: COLOR
                                                                      .appBaseColor)),
                                                      child: const Center(
                                                        child: Icon(
                                                            Icons
                                                                .delete_outline_sharp,
                                                            color:
                                                                Colors.white,
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
                                                width: 30,
                                                height: 30,
                                                child: const Center(
                                                  child: Icon(Icons.remove,
                                                      color: Colors.white,
                                                      size: 20),
                                                ),
                                              ),
                                              onTap: () {
                                                controller.remove();
                                              },
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            "${controller.Qty}",
                                            style:
                                                const TextStyle(fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: InkWell(
                                          onTap: () {
                                            if (controller.Qty.toDouble() <
                                                double.parse(
                                                    "${controller.productQty}")) {
                                              controller.add();
                                            } else {
                                              Fluttertoast.showToast(
                                                msg:
                                                    "Only ${controller.productQty.toStringAsFixed(0)} Available in Stock",
                                                toastLength:
                                                    Toast.LENGTH_SHORT,
                                                gravity:
                                                    ToastGravity.SNACKBAR,
                                                timeInSecForIosWeb: 1,
                                              );
                                            }
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
                                        )),
                                  ],
                                )
                              : */

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextButtonWidget(
                              text: 'Add to Cart',
                              onPressed: () {
                                if(widget.products!.packInfo![0].isCart ?? false){
                                Fluttertoast.showToast(msg: "Already In Cart");
                                }else{
                                  controller.addToCart(widget.products!);
                                  widget.products!.packInfo![0].isCart = true;
                                }
                              },
                              color:
                                  widget.products!.packInfo![0].isCart ?? false
                                      ? COLOR.grey
                                      : COLOR.appBaseColor,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: ButtonWidgets(
                              title: 'Buy Now',
                              voidCallback: () {
                                // Get.to(() => AddToCardScreen());
                              },
                              color: COLOR.appBaseColor,
                              style: Themes.light.textTheme.displayLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openBottomSheetDelivery(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.24,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWiget(
                          title: 'ADD DELIVERY LOCATION',
                          style: Themes.light.textTheme.displaySmall,
                        ),
                        Expanded(
                          child: AlignWidget(
                            alignment: Alignment.topRight,
                            child: IconButtonWidget(
                              voidCallback: () {
                                // Get.back();
                              },
                              icons: Icons.close,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DividerWidget(thickness: 1),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierColor: COLOR.black.withOpacity(0.8),
      isScrollControlled: true,
      backgroundColor: COLOR.background,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }
}
