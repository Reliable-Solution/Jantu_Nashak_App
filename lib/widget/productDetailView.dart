import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_app/controller/productDetailController.dart';
import 'package:keep_app/models/productModel.dart';
import 'package:keep_app/widget/textButtonWidget.dart';
import 'package:keep_app/widget/textWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../Theme/nativeTheme.dart';
import '../constant/app_constant.dart';
import '../constant/colorConst.dart';
import '../controller/cartController.dart';
import '../controller/homeController.dart';
import '../controller/shareProductsController.dart';
import '../utils/string_res.dart';
import '../view/AddtoCard/cartScreen.dart';
import '../view/wishlist/wishlist_screen.dart';
import 'alignWidget.dart';
import 'appBarWidget.dart';
import 'buttonWidget.dart';
import 'dividerWidgets.dart';
import 'iconButtonWidget.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel? products;
  final bool? isExpanded;

  ProductDetailScreen({super.key, this.products,this.isExpanded});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailsController productDetailsController = Get.find();
  ShareProductController shareProductController = Get.find();
  HomeController homeController = Get.find();

  double calculateDiscount(double mrp, double srp) {
    if (mrp <= 0 || srp > mrp) {
      throw Exception("Invalid MRP or SRP values");
    }
    double discount = ((mrp - srp) / mrp) * 100;
    return discount;
  }

  productRemove() {
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
    print("ProductWidget name: ${homeController.customerModel!.value?.customerName}");

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: MyCustomAppBar(
          actionPadding: 10,
          height: 90,
          appbarPadding: 0,
          action: [
            // Stack(
            //   children: [
            //     IconButtonWidget(
            //       voidCallback: () {
            //         Get.to(() => CartScreen(
            //               removeCart: productRemove,
            //             ));
            //       },
            //       icons: Icons.shopping_cart_outlined,
            //       color: COLOR.black,
            //     ),
            //     Positioned(
            //       right: 0,
            //       top: 0,
            //       // alignment: Alignment(5, 5),
            //       child: GetBuilder<CartController>(builder: (cartController) {
            //         int cartCount = cartController.cartList.length;
            //         return cartCount > 0
            //             ? Container(
            //                 padding: EdgeInsets.all(5),
            //                 alignment: Alignment.centerLeft,
            //                 decoration: BoxDecoration(
            //                   color: Colors.red,
            //                   shape: BoxShape.circle,
            //                 ),
            //                 child: Text(
            //                   cartCount.toString(),
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               )
            //             : SizedBox();
            //         // IconButtonWidget(
            //         //   voidCallback: () {
            //         //     Get.to(LoginScreen());
            //         //   },
            //         //   icons: Icons.login,
            //         //   color: COLOR.black,
            //         // ),
            //         // IconButtonWidget(
            //         //   voidCallback: () {
            //         //  Get.to(LoginScreen());
            //         //   },
            //         //   icons: Icons.login,
            //         //   color: COLOR.black,
            //         // ),
            //         // IconButton(
            //         //     onPressed: () {
            //         //       Navigator.push(
            //         //           context,
            //         //           MaterialPageRoute(
            //         //             builder: (context) => LoginScreen(),
            //         //           ));
            //         //     },
            //         //     icon: Icon(Icons.login)),
            //         // IconButton(
            //         //     onPressed: () {
            //         //       Navigator.push(
            //         //           context,
            //         //           MaterialPageRoute(
            //         //             builder: (context) => WishlistScreen(),
            //         //           ));
            //         //     },
            //         //     icon: Icon(Icons.favorite));
            //       }),
            //     ),
            //   ],
            // ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistScreen(),
                      ));
                },
                icon: Icon(Icons.favorite_border)),
            Stack(
              children: [
                IconButtonWidget(
                  voidCallback: () {
                    Get.to(() => CartScreen(
                      removeCart: productRemove,
                    ));
                  },
                  icons: Icons.shopping_cart_outlined,
                  color: COLOR.black,
                ),
                Positioned(
                  right: 0,
                  top: -05,
                  // alignment: Alignment(5, 5),
                  child: GetBuilder<CartController>(builder: (cartController) {
                    int cartCount = cartController.cartList.length;
                    return cartCount > 0
                        ? Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cartCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                        : SizedBox();
                    // IconButtonWidget(
                    //   voidCallback: () {
                    //     Get.to(LoginScreen());
                    //   },
                    //   icons: Icons.login,
                    //   color: COLOR.black,
                    // ),
                    // IconButtonWidget(
                    //   voidCallback: () {
                    //  Get.to(LoginScreen());
                    //   },
                    //   icons: Icons.login,
                    //   color: COLOR.black,
                    // ),
                    // IconButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => LoginScreen(),
                    //           ));
                    //     },
                    //     icon: Icon(Icons.login)),
                    // IconButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => WishlistScreen(),
                    //           ));
                    //     },
                    //     icon: Icon(Icons.favorite));
                  }),
                ),
              ],
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
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: "photonew${widget.products!.packInfo![0].productdetailId}",
                      child: AnimatedContainer(
                        // duration:
                        duration: Duration(milliseconds: 500),
                        width: widget.isExpanded! ? 200 : 100,
                        height: widget.isExpanded! ? 200 : 100,
                        child: widget.products == null? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: (MediaQuery.of(context).size.height * 50) / 100,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        )
                            :
                        Container(
                          padding: EdgeInsets.all(15),
                          height: (MediaQuery.of(context).size.height * 50) / 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            // color: Colors.yellow,
                            image: DecorationImage(
                              image: NetworkImage(
                                '$IMAGE_URL${widget.products!.packInfo![0].productdetailImages![0]}',
                              ),
                              fit: BoxFit.fitHeight,

                            ),
                          ),
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
                                child:
                                    TextWiget(title: StringRes.similarProducts),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: COLOR.appBaseColor),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '$IMAGE_URL${widget.products!.packInfo![0].productdetailImages![0]}',
                                    ),
                                    fit: BoxFit.fitHeight,
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
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: COLOR.grey,
                                      // style: Themes.light.textTheme.displayLarge!
                                      //     .copyWith(
                                      //   color: COLOR.grey,
                                      //   fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      TextWiget(
                                          title:
                                              '₹${widget.products!.packInfo![0].productdetailSrp} ',
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
                                          title: ' ${calculateDiscount(double.parse(widget.products!.packInfo![0].productdetailMrp!), double.parse(widget.products!.packInfo![0].productdetailSrp!)).toInt()} % ${StringRes.off}',
                                          // title: ' 9% off',
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
                                      shareProductController.addWishlist(
                                          productId: widget.products!.productId!);
                                    } else {
                                      widget.products!.isFav = false;
                                      shareProductController.removeWishList(
                                          productId: widget.products!.productId!);
                                      homeController.getDashboardData(
                                          homeController
                                              .customerModel!.value.customerId);
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
                            GetBuilder<ProductDetailsController>(
                                builder: (controller) {
                              return Container(
                                width: 30,
                                child: IconButtonWidget(
                                  voidCallback: () async {
                                    showSharingDialog(context);
                                    List<XFile> files = [];
                                    List<String> images = widget.products!
                                            .packInfo![0].productdetailImages ??
                                        [];
                                    for (int i = 0; i < images.length; i++) {
                                      final url =
                                          Uri.parse('$IMAGE_URL${images[i]}');
                                      final response = await http.get(url);

                                      var dir = await getTemporaryDirectory();

                                      File file =
                                          await File('${dir.path}/$i\\myItem.png')
                                              .writeAsBytes(response.bodyBytes);

                                      files.add(XFile(file.path));

                                      controller.updateProgress((i + 1));
                                    }
                                    controller.updateImagesStatus(true);

                                    await Share.shareXFiles(files);
                                    controller.startDescriptionSharing();

                                    for (int i = 0; i <= 100; i += 10) {
                                      await Future.delayed(
                                          Duration(milliseconds: 100));
                                      controller.updateProgress(i / 100);
                                    }
                                    await Share.share(
                                        '${widget.products!.productDescription}');
                                    controller.updateDescriptionStatus(true);
                                    controller
                                        .updateProgress(1.0); // Complete progress

                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      Navigator.pop(
                                          context); // Close popup after sharing
                                      controller.updateImagesStatus(false);
                                      controller.updateDescriptionStatus(false);
                                    });
                                  },
                                  icons: Icons.share_outlined,
                                  color: COLOR.black,
                                ),
                              );
                            })
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
                                title: StringRes.freeDelivery,
                                style: Themes.light.textTheme.displayMedium!
                                    .copyWith(fontWeight: FontWeight.w400,color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10, bottom: 15),
                        //   child: AlignWidget(
                        //     alignment: Alignment.centerLeft,
                        //     child: Row(
                        //       children: [
                        //         Container(
                        //           padding: EdgeInsets.symmetric(
                        //               vertical: 5, horizontal: 6),
                        //           decoration: BoxDecoration(
                        //             color: COLOR.green,
                        //             borderRadius: BorderRadius.circular(5),
                        //           ),
                        //           child: Row(
                        //             children: [
                        //               TextWiget(
                        //                 title:
                        //                     '${widget.products!.packInfo![0].productdetailMrp}',
                        //                 style: Themes
                        //                     .light.textTheme.displaySmall!
                        //                     .copyWith(
                        //                   color: COLOR.background,
                        //                   fontWeight: FontWeight.w500,
                        //                 ),
                        //               ),
                        //               Icon(Icons.star,
                        //                   size: 13, color: COLOR.background)
                        //             ],
                        //           ),
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.only(left: 4),
                        //           child: TextWiget(
                        //             title: '(28,717)',
                        //             style: Themes.light.textTheme.bodyMedium!
                        //                 .copyWith(color: COLOR.grey),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
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
                          title: StringRes.selectSize,
                          style: Themes.dark.textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16
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
                                  title: StringRes.freeSize,
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
                              title: StringRes.productDetails,
                              // style: GoogleFonts.poppins(
                              //   fontSize: 14,
                              //   fontWeight: FontWeight.w600,
                              // )
                              style:
                                  Themes.dark.textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                    fontSize: 14,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                                SelectableText(widget.products!.productDescription!);

                                Clipboard.setData(new ClipboardData(text: widget.products!.productDescription!));

                                final snackBar = SnackBar(
                                content: TextWiget(
                                  title: StringRes.copyProductDetails,
                                  style: Themes.light.textTheme.displaySmall!
                                      .copyWith(color: COLOR.background),
                                ),
                                action: SnackBarAction(
                                  label: StringRes.undo,
                                  textColor: COLOR.appBaseColor,
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: TextWiget(
                              title: StringRes.copy,
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )
                              // style:
                              //     Themes.light.textTheme.displaySmall!.copyWith(
                              //   color: COLOR.appBaseColor,
                              //   fontWeight: FontWeight.w600,
                              // ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        widget.products!.productDescription!,
                        // style: GoogleFonts.poppins(
                        //
                        //   fontSize: 14,
                        //   fontWeight: FontWeight.w400,
                        //   color: Colors.black45,
                        // ),
                        style: Themes.light.textTheme.displaySmall!.copyWith(
                          // color: COLOR.black,
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
              ? MediaQuery.of(context).size.height * 0.06
              : MediaQuery.of(context).size.height * 0.12,
          color: Color(0xffffedfe),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DividerWidget(thickness: 1, height: 0),
              Expanded(
                child: GetBuilder<ProductDetailsController>(
                    builder: (controller) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                     width: MediaQuery.of(context).size.width ,
                    child: ButtonWidgets(
                      style: Themes.light.textTheme.displayLarge!
                              .copyWith(color: Colors.white),
                      // text: StringRes.addtoCart,
                      // onPressed: () {
                      //   if (widget.products!.packInfo![0].isCart ??
                      //       false) {
                      //     Fluttertoast.showToast(
                      //         msg: StringRes.alreadyInCart);
                      //   } else {
                      //     controller.addToCart(widget.products!);
                      //     widget.products!.packInfo![0].isCart = true;
                      //     Get.find<CartController>().getCartDetails(
                      //       Get.find<CartController>()
                      //           .customerModel!
                      //           .value
                      //           .customerId!,
                      //     );
                      //   }
                      title: StringRes.addtoCart,
                      voidCallback: () {
                        if (widget.products!.packInfo![0].isCart ??
                            false) {
                          Fluttertoast.showToast(
                              msg: StringRes.alreadyInCart);
                        } else {
                          controller.addToCart(widget.products!);
                          widget.products!.packInfo![0].isCart = true;
                          Get.find<CartController>().getCartDetails(
                            Get.find<CartController>()
                                .customerModel!
                                .value
                                .customerId!,
                          );
                        }
                      },
                      color:
                          widget.products!.packInfo![0].isCart ?? false
                              ? COLOR.grey
                              : COLOR.appBaseColor,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildImageShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.all(15),
        height: 200,
        width: double.infinity,
        color: Colors.white,
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
                          title: StringRes.addDeliveryLocation,
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

void showSharingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return GetBuilder<ProductDetailsController>(
        builder: (controller) => AlertDialog(
          backgroundColor: COLOR.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringRes.sharingImages,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                      controller.isImagesDownloaded
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: controller.isImagesDownloaded
                          ? Colors.green
                          : Colors.grey),
                  SizedBox(width: 8),
                  Text(StringRes.images),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                      controller.isDescriptionShared
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: controller.isDescriptionShared
                          ? Colors.green
                          : Colors.grey),
                  SizedBox(width: 8),
                  Text(StringRes.description),
                ],
              ),
              SizedBox(height: 16),
              LinearProgressIndicator(
                value: controller.downloadProgress,
                color: COLOR.appBaseColor,
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(height: 16),
              Text(
                controller.isSharingDescription
                    ? StringRes.sharingDescription
                    : StringRes.sharingImagesDialog,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
            ],
          ),
        ),
      );
    },
  );
}
