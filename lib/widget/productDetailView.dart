import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_app/controller/productDetailController.dart';
import 'package:keep_app/models/productModel.dart';
import 'package:keep_app/utils/services/api_services.dart';
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
  ProductModel? products;
  final bool? isExpanded;
  final bool? fromDeepLink;

  ProductDetailScreen(
      {super.key, this.products, this.isExpanded, this.fromDeepLink});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailsController productDetailsController = Get.find();
  ShareProductController shareProductController = Get.find();
  HomeController homeController = Get.find();
  int _currentIndex = 0;
  int _selectedIndex = 0;
  int _selectedColorIndex = 0;
  List<PackInfo> productListOFPackInfo = [];
  PackInfo? packInfoOfSelected;

  final CartController cartController = Get.put(CartController());

  bool isNewPack = false;

  bool isShareLoad = false;

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

  void changeSearchLoader(bool value) {
    setState(() => isShareLoad = value);
  }

  @override
  void initState() {
    if (widget.fromDeepLink!) {
      // homeController.getProductData(widget.products?.productId);

      final productId = widget.products?.productId;
      if (productId != null) {
        final homeController = Get.find<HomeController>();
        homeController.getProductData(productId).then((_) {
          if (homeController.productList.isNotEmpty) {
            setState(() {
              widget.products = homeController.productList.first;
            });
          }
        });
      }
      // final productId = widget.products?.productId;
      //
      // if (productId != null) {
      //   homeController.getProductData(productId).then((_) {
      //     if (homeController.productList.isNotEmpty) {
      //       final product = homeController.productList.first;
      //
      //       // Override all local data with API data
      //       productDetailsController.Qty =
      //           int.parse(product.packInfo![0].cartqty!);
      //       productDetailsController.productQty =
      //           int.parse(product.packInfo![0].productdetailQty!);
      //       productListOFPackInfo = product.packInfo!;
      //
      //       if (product.qty!.isNotEmpty) {
      //         _selectedIndex = 0;
      //         getProductInfo(qtySize: product.qty![0]);
      //       }
      //
      //       setState(() {});
      //     }
      //   });
      // }

      else {
        // Fallback if no productId (should not happen in deep-link)
        throw Exception("Product ID missing in deep-link");
      }
    }

    productDetailsController.Qty =
        int.parse(widget.products!.packInfo![0].cartqty!);
    productDetailsController.productQty =
        int.parse("${widget.products!.packInfo![0].productdetailQty}");
    productListOFPackInfo = widget.products!.packInfo!;

    // Set default size and color if available
    if (widget.products!.qty!.isNotEmpty) {
      _selectedIndex = 0; // Default to first size
    }
    getProductInfo(
      qtySize: widget.products!.qty!.isNotEmpty ? widget.products!.qty![0] : "",
    );
    _currentIndex = 0; // Ensure first image is shown initially

    super.initState();
  }

  getProductInfo({required String qtySize}) {
    for (int i = 0; i < widget.products!.packInfo!.length; i++) {
      if (widget.products!.packInfo![i].productQty == qtySize
          // &&
          // widget.products!.packInfo![i].productColor == colorValue
          ) {
        packInfoOfSelected = widget.products!.packInfo![i];
        isNewPack = true;
      }
    }
    setState(() {
      _currentIndex = 0; // Reset to first image when pack changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: MyCustomAppBar(
          actionPadding: 10,
          height: 90,
          appbarPadding: 0,
          action: [
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => WishlistScreen(),
            //           ));
            //     },
            //     icon: Icon(
            //       Icons.favorite_border,
            //       color: Colors.white,
            //     )),
            Stack(
              children: [
                IconButtonWidget(
                  voidCallback: () {
                    cartController.getCartDetails(
                        cartController.customerModel!.value.customerId!);
                    cartController.getCartTotal(
                        cartController.customerModel!.value.customerId!);

                    Get.to(() => CartScreen(
                          removeCart: productRemove,
                        ));
                  },
                  icons: Icons.shopping_cart_outlined,
                  color: COLOR.background,
                ),
                Positioned(
                  right: 0,
                  top: -05,
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
              color: COLOR.background,
              size: 20,
            ),
          ),
        ),
        backgroundColor: COLOR.greyLight,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: CarouselSlider.builder(
                  itemCount: isNewPack
                      ? packInfoOfSelected!.productdetailImages!.length
                      : widget
                          .products!.packInfo![0].productdetailImages!.length,
                  itemBuilder: (context, index, realIndex) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductImageScreen(
                              imageUrls: isNewPack
                                  ? packInfoOfSelected!.productdetailImages!
                                  : widget.products!.packInfo![0]
                                      .productdetailImages!,
                              initialIndex: index,
                            ),
                          ),
                        );
                      },
                      child: InteractiveViewer(
                        // boundaryMargin: EdgeInsets.all(20),
                        minScale: 1,
                        // Minimum zoom-out scale
                        maxScale: 2,
                        // Maximum zoom-in scale
                        scaleEnabled: true,
                        // Enable pinch-to-zoom
                        constrained: true,
                        // Respect parent constraints
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: COLOR.background, // Updated to ColorConst
                              image: DecorationImage(
                                image: NetworkImage(isNewPack
                                    ? '$IMAGE_URL${packInfoOfSelected!.productdetailImages![_currentIndex]}'
                                    : '$IMAGE_URL${widget.products!.packInfo![0].productdetailImages![0]}'),
                                fit: BoxFit
                                    .contain, // Changed to contain for better zoom
                              ),
                            ),
                            height:
                                (MediaQuery.of(context).size.height * 25) / 100,
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.38,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
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
                            padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                            child: TextWiget(title: StringRes.productImages),
                          ),
                          SizedBox(
                            height: 70,
                            child: ListView.builder(
                                itemCount: isNewPack
                                    ? packInfoOfSelected!
                                        .productdetailImages!.length
                                    : widget.products!.packInfo![0]
                                        .productdetailImages!.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.all(15),
                                    height: 50,
                                    width: 50,
                                    margin: EdgeInsets.all(02),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(05),
                                      border: Border.all(
                                        color: _currentIndex == index
                                            ? COLOR.appBaseColor
                                            : COLOR.appBaseColor
                                                .withOpacity(0.5),
                                        width:
                                            _currentIndex == index ? 2.0 : 1.0,
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          isNewPack
                                              ? '$IMAGE_URL${packInfoOfSelected!.productdetailImages![index]}'
                                              : '$IMAGE_URL${widget.products!.packInfo![0].productdetailImages![index]}',
                                        ),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  );
                                }),
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
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  TextWiget(
                                      title: isNewPack
                                          ? '₹${packInfoOfSelected!.productdetailSrp!}'
                                          : '₹${widget.products!.packInfo![0].productdetailSrp} ',
                                      style: Themes.dark.textTheme.bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w600)),
                                  TextWiget(
                                      title: isNewPack
                                          ? packInfoOfSelected!
                                              .productdetailMrp!
                                          : '${widget.products!.packInfo![0].productdetailMrp}',
                                      style: Themes
                                          .dark.textTheme.displayMedium!
                                          .copyWith(
                                        color: COLOR.grey,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.lineThrough,
                                      )),
                                 if( packInfoOfSelected!.productdetailMrp !=packInfoOfSelected!.productdetailSrp! || widget.products!.packInfo![0].productdetailMrp! != widget.products!.packInfo![0].productdetailSrp!)
                                  TextWiget(
                                      title:
                                          ' ${calculateDiscount(double.parse(isNewPack ? packInfoOfSelected!.productdetailMrp! : widget.products!.packInfo![0].productdetailMrp!), double.parse(isNewPack ? packInfoOfSelected!.productdetailSrp! : widget.products!.packInfo![0].productdetailSrp!)).toInt()} % ${StringRes.off}',
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
                        // SizedBox(
                        //   width: 30,
                        //   child: GetBuilder<HomeController>(
                        //     builder: (_controller) => IconButtonWidget(
                        //       voidCallback: () {
                        //         if (widget.products!.isFav == false) {
                        //           widget.products!.isFav = true;
                        //           shareProductController.addWishlist(
                        //               productId: widget.products!.productId!);
                        //         } else {
                        //           widget.products!.isFav = false;
                        //           shareProductController.removeWishList(
                        //               productId: widget.products!.productId!);
                        //           homeController.getDashboardData(homeController
                        //               .customerModel!.value.customerId);
                        //         }
                        //
                        //         _controller.update();
                        //       },
                        //       color: widget.products!.isFav == false
                        //           ? COLOR.black
                        //           : COLOR.appBaseColor,
                        //       icons: widget.products!.isFav == false
                        //           ? Icons.favorite_border
                        //           : Icons.favorite,
                        //       size: 29,
                        //     ),
                        //   ),
                        // ),
                        GetBuilder<ProductDetailsController>(
                            builder: (controller) {
                          return isShareLoad
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14, left: 4, right: 4),
                                  child: SizedBox.square(
                                      dimension: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      )),
                                )
                              : IconButtonWidget(
                                  voidCallback: () async {
                                    changeSearchLoader(true);
                                    // showSharingDialog(context);
                                    List<XFile> files = [];
                                    // List<String> images = widget.products!.packInfo?.map((e) => e.productdetailImages?.join(', ') ?? '').toList() ??
                                    //     [];
                                    final allImages = widget.products?.packInfo
                                        ?.expand((e) => e.productdetailImages ?? [])
                                        .toList() ??
                                        [];

                                    final uniqueImages = allImages.toSet().toList();

                                    print("===>>> images.length ${uniqueImages.length}");
                                    for (int i = 0; i < uniqueImages.length; i++) {
                                      final url =
                                          Uri.parse('$IMAGE_URL${uniqueImages[i]}');
                                      final response = await http.get(url);

                                      var dir = await getTemporaryDirectory();

                                      File file = await File(
                                              '${dir.path}/$i\\myItem.png')
                                          .writeAsBytes(response.bodyBytes);

                                      files.add(XFile(file.path));

                                      // controller.updateProgress((i + 1));
                                    }
                                    // controller.updateImagesStatus(true);

                                    final productId =
                                        widget.products?.productId ?? '123';
                                    // final deepLink =
                                    //     'jantunashak://product/$productId';


                                    // final webLink = 'https://jantunashak.com/product/$productId';
                                    final webLink = '${ApiService.baseUrl}check_product/$productId';

                                    final playStoreLink =
                                        'https://play.google.com/store/apps/details?id=com.reliable.jantunashak';

                                    final text =
                                        'Check out this product: $webLink\n'
                                    // 'Or open directly in app: $deepLink'
                                        // 'Check out this product: $deepLink'
                                        '\nInstall the app: $playStoreLink';

                                    // Share.share(
                                    //   'Check out this product: $deepLink\nInstall app: $playStoreLink',
                                    // );
// await Share.share(text);
                                    await Share.shareXFiles(
                                        files,
                                        text: text,
                                        subject: 'JantuNashak Product',
                                        // files,
                                        //     text:
                                        //         "Check out this product: $deepLink\nInstall app: $playStoreLink",
                                        //     subject: "Data"
                                    )
                                        .then(
                                      (value) {
                                        // Share.share(
                                        //   'Check out this product: $deepLink\nInstall app: $playStoreLink',
                                        // );

                                        changeSearchLoader(false);
                                      },
                                    );
                                    // controller.startDescriptionSharing();

                                    // for (int i = 0; i <= 100; i += 10) {
                                    //   await Future.delayed(
                                    //       Duration(milliseconds: 100));
                                    //   controller.updateProgress(i / 100);
                                    // }
                                    // // await Share.share(
                                    // //     '${widget.products!.productDescription}');
                                    // // controller.updateDescriptionStatus(true);
                                    // // controller.updateProgress(1.0);

                                    // Future.delayed(Duration(milliseconds: 500), () {
                                    //   Navigator.pop(context);
                                    //   controller.updateImagesStatus(false);
                                    //   controller.updateDescriptionStatus(false);
                                    // });
                                  },
                                  icons: Icons.share_outlined,
                                  color: COLOR.black,
                                );
                          //   Container(
                          //   width: 30,
                          //   child: IconButtonWidget(
                          //     voidCallback: () async {
                          //       changeSearchLoader(true);
                          //       // showSharingDialog(context);
                          //       List<XFile> files = [];
                          //       // showSharingDialog(context);
                          //       // List<XFile> files = [];
                          //       // List<String> images = widget.products!
                          //       //         .packInfo![0].productdetailImages ??
                          //       //     [];
                          //       // for (int i = 0; i < images.length; i++) {
                          //       //   final url =
                          //       //       Uri.parse('$IMAGE_URL${images[i]}');
                          //       //   final response = await http.get(url);
                          //       //
                          //       //   var dir = await getTemporaryDirectory();
                          //       //
                          //       //   File file =
                          //       //       await File('${dir.path}/$i\\myItem.png')
                          //       //           .writeAsBytes(response.bodyBytes);
                          //       //
                          //       //   files.add(XFile(file.path));
                          //       //
                          //       //   controller.updateProgress((i + 1));
                          //       // }
                          //       // controller.updateImagesStatus(true);
                          //
                          //       List<String> images = widget
                          //           .products!.packInfo
                          //           ?.map((e) =>
                          //       e.productdetailImages
                          //           ?.join(', ') ??
                          //           '')
                          //           .toList() ??
                          //           [];
                          //
                          //       print(
                          //           "===>>> images.length ${images.length}");
                          //       for (int i = 0; i < images.length; i++) {
                          //         final url =
                          //         Uri.parse('$IMAGE_URL${images[i]}');
                          //         final response = await http.get(url);
                          //
                          //         var dir = await getTemporaryDirectory();
                          //
                          //         File file = await File(
                          //             '${dir.path}/$i\\myItem.png')
                          //             .writeAsBytes(response.bodyBytes);
                          //
                          //         files.add(XFile(file.path));
                          //
                          //         controller.updateProgress((i + 1));
                          //       }
                          //       controller.updateImagesStatus(true);
                          //
                          //       await Share.shareXFiles(files).then(
                          //             (value) {
                          //           changeSearchLoader(false);
                          //         },
                          //       );
                          //       // await Share.shareXFiles(files);
                          //       // controller.startDescriptionSharing();
                          //       //
                          //       // for (int i = 0; i <= 100; i += 10) {
                          //       //   await Future.delayed(
                          //       //       Duration(milliseconds: 100));
                          //       //   controller.updateProgress(i / 100);
                          //       // }
                          //       // Generate deep link for home screen
                          //       // final deepLink = 'https://staging-jantunashak.reliablesolution.in/Admin/Ajax/';
                          //       // final fallbackUrl = 'https://play.google.com/store/apps/details?id=com.reliable.jantunashak';
                          //       // await Share.share(
                          //       //     '${widget.products!.productDescription}''${widget.products!.productDescription}\nCheck out JantuNashak: $deepLink\nGet the app: $fallbackUrl',
                          //       //   );
                          //
                          //       final productId = widget.products?.productId ?? '123';
                          //       final deepLink = 'jantunashak://product/$productId';
                          //       final playStoreLink = 'https://play.google.com/store/apps/details?id=com.reliable.jantunashak';
                          //
                          //       Share.share(
                          //         'Check out this product: $deepLink\nInstall app: $playStoreLink',
                          //       );
                          //
                          //
                          //       // controller.updateDescriptionStatus(true);
                          //       // controller.updateProgress(1.0);
                          //
                          //       // Future.delayed(Duration(milliseconds: 500), () {
                          //       //   Navigator.pop(context);
                          //       //   // controller.updateImagesStatus(false);
                          //       //   // controller.updateDescriptionStatus(false);
                          //       // });
                          //     },
                          //     icons: Icons.share_outlined,
                          //     color: COLOR.black,
                          //   ),
                          // );
                        })
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: AlignWidget(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: COLOR.greyLight.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextWiget(
                            title: StringRes.freeDelivery,
                            style: Themes.light.textTheme.displayMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.products!.qty!.length > 1) ...[
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
                            title: StringRes.selectQuantity,
                            style: Themes.dark.textTheme.displayMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                              itemCount: widget.products!.qty!.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(left: 8),
                              itemBuilder: (BuildContext context, int index) {
                                final size = widget.products!.qty![index];
                                final isSelected = _selectedIndex == index;
                                return Padding(
                                  padding: EdgeInsets.only(top: 08, left: 2),
                                  child: AlignWidget(
                                    alignment: Alignment.centerLeft,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedIndex = index;
                                          getIndex(_selectedIndex,
                                              _selectedColorIndex);
                                          getProductInfo(
                                              qtySize:
                                                  widget.products!.qty![index]);
                                          // sizeValue:
                                          //     widget.products!.size![index],
                                          // colorValue: widget.products!
                                          //     .color![_selectedColorIndex]);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: isSelected
                                                  ? COLOR.appBaseColor
                                                  : COLOR.background),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor: isSelected
                                            ? COLOR.appBaseColor
                                            : COLOR.background,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: FittedBox(
                                          child: TextWiget(
                                            title:
                                                "${widget.products!.qty![index]}",
                                            style: Themes
                                                .light.textTheme.displaySmall!
                                                .copyWith(
                                                    color: isSelected ? COLOR.background :COLOR.appBaseColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              // if (widget.products!.color!.length > 1) ...[
              //   Padding(
              //     padding: const EdgeInsets.only(top: 5),
              //     child: Container(
              //       width: MediaQuery.of(context).size.width,
              //       color: COLOR.background,
              //       padding: EdgeInsets.all(15),
              //       child: Column(
              //         children: <Widget>[
              //           AlignWidget(
              //             alignment: Alignment.centerLeft,
              //             child: TextWiget(
              //               title: StringRes.selectColor,
              //               style: Themes.dark.textTheme.displayMedium!
              //                   .copyWith(
              //                       fontWeight: FontWeight.w600, fontSize: 16),
              //             ),
              //           ),
              //           SizedBox(
              //             height: 70,
              //             child: ListView.builder(
              //                 itemCount: widget.products!.color!.length,
              //                 scrollDirection: Axis.horizontal,
              //                 itemBuilder: (BuildContext context, int index) {
              //                   final isSelected = _selectedColorIndex == index;
              //                   return Padding(
              //                     padding: EdgeInsets.only(top: 15, left: 5),
              //                     child: AlignWidget(
              //                       alignment: Alignment.centerLeft,
              //                       child: ElevatedButton(
              //                         onPressed: () {
              //                           setState(() {
              //                             _selectedColorIndex = index;
              //                             getIndex(_selectedIndex,
              //                                 _selectedColorIndex);
              //                             getProductInfo(
              //                                 sizeValue: widget.products!
              //                                     .size![_selectedIndex],
              //                                 colorValue: widget.products!
              //                                     .color![_selectedColorIndex]);
              //                           });
              //                         },
              //                         style: ElevatedButton.styleFrom(
              //                           shape: RoundedRectangleBorder(
              //                             side: BorderSide(
              //                                 color: isSelected
              //                                     ? COLOR.appBaseColor
              //                                     : COLOR.background),
              //                             borderRadius:
              //                                 BorderRadius.circular(10),
              //                           ),
              //                           backgroundColor: isSelected
              //                               ? COLOR.pinkLight
              //                               : COLOR.background,
              //                         ),
              //                         child: Padding(
              //                           padding: const EdgeInsets.all(0),
              //                           child: FittedBox(
              //                             child: TextWiget(
              //                               title:
              //                                   "${widget.products!.color![index]}",
              //                               style: Themes
              //                                   .light.textTheme.displaySmall!
              //                                   .copyWith(
              //                                       color: COLOR.appBaseColor),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   );
              //                 }),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ],
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
                              style:
                                  Themes.dark.textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              SelectableText(
                                  widget.products!.productDescription!);

                              Clipboard.setData(new ClipboardData(
                                  text: widget.products!.productDescription!));

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
                                )),
                          )
                        ],
                      ),
                      Text(
                        widget.products!.productDescription!,
                        style: Themes.light.textTheme.displaySmall!.copyWith(),
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
            children: [
              DividerWidget(thickness: 1, height: 0),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: GetBuilder<ProductDetailsController>(
                          builder: (controller) {
                        return controller.isLoader.value == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.pink),
                                ),
                              )
                            : SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                child: ButtonWidgets(
                                  style: Themes.light.textTheme.displayLarge!
                                      .copyWith(color: Colors.white),
                                  title: StringRes.addtoCart,
                                  voidCallback: () {
                                    print('isAdd To Cart $isNewPack');
                                    // print(packInfoOfSelected!.isCart);
                                    print(widget.products!.packInfo![0].isCart);
                                    if (isNewPack
                                        ? packInfoOfSelected!.isCart ?? false
                                        : widget.products!.packInfo![0]
                                                .isCart ??
                                            false) {
                                      Fluttertoast.showToast(
                                          msg: StringRes.alreadyInCart);
                                    } else {
                                      // controller.isLoader = true.obs;
                                      controller.addToCart(
                                          widget.products!,
                                          isNewPack
                                              ? packInfoOfSelected!
                                                  .productdetailId!
                                              : widget.products!.packInfo![0]
                                                  .productdetailId!);
                                      if (isNewPack) {
                                        packInfoOfSelected!.isCart = true;
                                      } else {
                                        widget.products!.packInfo![0].isCart =
                                            true;
                                      }
                                      Get.find<CartController>().getCartDetails(
                                        Get.find<CartController>()
                                            .customerModel!
                                            .value
                                            .customerId!,
                                      );
                                    }
                                  },
                                  color: (isNewPack
                                          ? packInfoOfSelected!.isCart ?? false
                                          : widget.products!.packInfo![0]
                                                  .isCart ??
                                              false)
                                      ? COLOR.grey // Grey if in cart
                                      : COLOR.appBaseColor,
                                  // isNewPack ? packInfoOfSelected!.isCart ?? false
                                  //     : widget.products!.packInfo![0].isCart ?? false
                                  //     ? COLOR.appBaseColor : COLOR.appBaseColor,
                                ),
                              );
                      }),
                    ),
                    GetBuilder<ProductDetailsController>(
                      builder: (controller) => Container(
                        width: MediaQuery.of(context).size.width * 0.49,
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: FittedBox(
                              child: TextWiget(
                                title: StringRes.buyNow,
                                style: TextStyle(
                                    color: COLOR.appBaseColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          onPressed: () {
                            print(widget.products!.packInfo![0].isCart);
                            if (isNewPack
                                ? packInfoOfSelected!.isCart ?? false
                                : widget.products!.packInfo![0].isCart ??
                                    false) {
                              Fluttertoast.showToast(
                                  msg: StringRes.alreadyInCart);
                            } else {
                              // controller.isLoader = true.obs;
                              controller.addToCart(
                                  widget.products!,
                                  isNewPack
                                      ? packInfoOfSelected!.productdetailId!
                                      : widget.products!.packInfo![0]
                                          .productdetailId!);
                              if (isNewPack) {
                                packInfoOfSelected!.isCart = true;
                              } else {
                                widget.products!.packInfo![0].isCart = true;
                              }
                              Get.find<CartController>().getCartDetails(
                                Get.find<CartController>()
                                    .customerModel!
                                    .value
                                    .customerId!,
                              );
                            }
                            Get.to(CartScreen());
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: COLOR.appBaseColor, width: 3)))
                              // ElevatedButton.styleFrom(
                              //
                              //
                              //   padding: EdgeInsets.all(10) ,
                              //   backgroundColor: COLOR.background,
                              //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              //     RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(18.0),
                              //         side: BorderSide(color: Colors.red)
                              //     )
                              // )

                              // shape: RoundedRectangleBorder(
                              //
                              //   borderRadius: BorderRadius.circular(10),side: BorderSide(color: COLOR.appBaseColor)
                              // ),
                              ),
                          // title: 'Buy Now',
                          // voidCallback: () {
                          //   // Get.to(() => AddToCardScreen());
                          // },
                          // color: COLOR.background,
                          // style: TextStyle()
                        ),
                      ),
                    ),
                  ],
                ),
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

  void getIndex(int sizeIndex, int colorIndex) {
    setState(() {
      print("Hello size ${sizeIndex}");
      print("Hello color ${colorIndex}");
    });
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
// bottomNavigationBar: GetBuilder<ProductDetailsController>(
// builder: (productDetailsController) {
// final productDetailId = isNewPack
// ? packInfoOfSelected!.productdetailId!
//     : widget.products!.packInfo![0].productdetailId!;
// final isInCart = isProductInCart(productDetailId);
//
// return Container(
// height: Get.height > MediaQuery.of(context).size.height * 0.8
// ? MediaQuery.of(context).size.height * 0.06
//     : MediaQuery.of(context).size.height * 0.12,
// color: Color(0xffffedfe),
// child: Column(
// children: [
// DividerWidget(thickness: 1, height: 0),
// Expanded(
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// // Add to Cart Button
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.5,
// child: productDetailsController.isLoader.value
// ? const Center(
// child: CircularProgressIndicator(
// valueColor: AlwaysStoppedAnimation<Color>(
// Colors.pink),
// ),
// )
//     : _buildAddToCartButton(
// context,
// productDetailsController,
// isInCart,
// productDetailId,
// ),
// ),
// // Buy Now Button
// _buildBuyNowButton(context, productDetailsController,
// isInCart, productDetailId),
// ],
// ),
// ),
// ],
// ),
// );
// },
// ),


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

class ProductImageScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ProductImageScreen({
    Key? key,
    required this.imageUrls,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<ProductImageScreen> createState() => _ProductImageScreenState();
}

class _ProductImageScreenState extends State<ProductImageScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final TransformationController _transformationController =
      TransformationController();
  final double _zoomScale = 2.0;

  late List<TransformationController> _controllers;

  late AnimationController animationController;
  Animation<Matrix4>? animation;
  TapDownDetails? tapDownDetails;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controllers = List.generate(
        widget.imageUrls.length, (_) => TransformationController());

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(
            () {
              // _transformationController.value = animation!.value;
              _controllers[_currentIndex].value = animation!.value;
            },
          );
  }

  void _handleDoubleTap(int index) {
    final controller = _controllers[index];
    final position = tapDownDetails?.localPosition ?? Offset.zero;
    final scale = 2.5;

    final zoomed = Matrix4.identity()
      ..translate(-position.dx * (scale - 1), -position.dy * (scale - 1))
      ..scale(scale);

    final endMatrix =
        controller.value.isIdentity() ? zoomed : Matrix4.identity();

    animation = Matrix4Tween(
      begin: controller.value,
      end: endMatrix,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    animationController.forward(from: 0);
  }

  // final TransformationController _transformationController = TransformationController();
  // final double _zoomScale = 2.0;
  //
  // List<TransformationController> _controllers = [];
  //
  // late AnimationController animationController;
  // Animation<Matrix4>? animation;
  // TapDownDetails? tapDownDetails;

  // void _handleDoubleTap() {
  //   final currentMatrix = _transformationController.value;
  //
  //   if (currentMatrix != Matrix4.identity()) {
  //     _transformationController.value = Matrix4.identity(); // zoom out
  //   } else {
  //     _transformationController.value = Matrix4.identity()
  //       ..scale(_zoomScale); // zoom in
  //   }
  //   // animationController.forward(from: 0);
  // }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    // _transformationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        height: 90,
        appbarPadding: 0,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: COLOR.background,
            size: 20,
          ),
        ),
      ),
      backgroundColor: COLOR.greyLight,
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: widget.imageUrls.length,

                itemBuilder: (context, index, realIndex) {
                  return StatefulBuilder(
                    builder: (context, setLocalState) {
                      return GestureDetector(
                        onDoubleTapDown: (details) => tapDownDetails = details,
                        onDoubleTap: () => _handleDoubleTap(index),
                        // {
                        //   final scale = 2.5;
                        //   final position = tapDownDetails?.localPosition ?? Offset.zero;
                        //
                        //   final zoomed = Matrix4.identity()
                        //     ..translate(-position.dx * (scale - 1), -position.dy * (scale - 1))
                        //     ..scale(scale);
                        //
                        //   final endMatrix = _controllers[index].value.isIdentity()
                        //       ? zoomed
                        //       : Matrix4.identity();
                        //
                        //   animation = Matrix4Tween(
                        //     begin: _controllers[index].value,
                        //     end: endMatrix,
                        //   ).animate(CurvedAnimation(
                        //     parent: animationController,
                        //     curve: Curves.easeInOut,
                        //   ));
                        //
                        //   animationController.forward(from: 0);
                        // },
                        child: InteractiveViewer(
                          transformationController: _controllers[index],
                          panEnabled: true,
                          scaleEnabled: true,
                          minScale: 1,
                          maxScale: 4,
                          constrained: true,
                          child: Image.network(
                            '$IMAGE_URL${widget.imageUrls[index]}',
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  );
                },

                //   itemBuilder: (context, index, realIndex) {
                //   return StatefulBuilder(
                //     builder: (context, setLocalState) {
                //       return GestureDetector(
                //         onDoubleTapDown: (details) {
                //           tapDownDetails = details;
                //         },
                //         onDoubleTap: () {
                //           final scale = 2.5;
                //           final position = tapDownDetails?.localPosition ?? Offset.zero;
                //
                //           final zoomed = Matrix4.identity()
                //             ..translate(-position.dx * (scale - 1), -position.dy * (scale - 1))
                //             ..scale(scale);
                //
                //           final endMatrix = _transformationController.value.isIdentity()
                //               ? zoomed
                //               : Matrix4.identity();
                //
                //           animation = Matrix4Tween(
                //             begin: _transformationController.value,
                //             end: endMatrix,
                //           ).animate(CurvedAnimation(
                //             parent: animationController,
                //             curve: Curves.easeInOut,
                //           ));
                //
                //           animationController.forward(from: 0);
                //         },
                //         child: InteractiveViewer(
                //           transformationController: _transformationController,
                //           panEnabled: true,
                //           scaleEnabled: true,
                //           minScale: 1,
                //           maxScale: 4,
                //           constrained: true,
                //           child: Image.network(
                //             '$IMAGE_URL${widget.imageUrls[index]}',
                //             fit: BoxFit.contain,
                //           ),
                //         ),
                //       );
                //     },
                //   );
                // },
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height,
                  initialPage: widget.initialIndex,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                      for (var c in _controllers) {
                        c.value = Matrix4.identity(); // Reset zoom on all
                      }
                      // _controllers[_currentIndex].value = Matrix4.identity();

                      // _transformationController.value = Matrix4.identity();
                    });
                  },
                ),
              )

              // CarouselSlider.builder(
              //   itemCount: widget.imageUrls.length,
              //   itemBuilder: (context, index, realIndex) {
              //     return GestureDetector(
              //       onDoubleTapDown: (details) {
              //         tapDownDetails = details;
              //       },
              //       // onDoubleTapDown: (details) => tapDownDetails,
              //       onDoubleTap: () {
              //         final scale = 2.5;
              //         final position = tapDownDetails?.localPosition ?? Offset.zero;
              //
              //         // final position = tapDownDetails?.localPosition ?? Offset.zero;
              //
              //         final zoomed = Matrix4.identity()
              //           ..translate(-position.dx * (scale - 1), -position.dy * (scale - 1))
              //           ..scale(scale);
              //
              //         final endMatrix = _transformationController.value.isIdentity()
              //             ? zoomed
              //             : Matrix4.identity();
              //
              //         animation = Matrix4Tween(
              //           begin: _transformationController.value,
              //           end: endMatrix,
              //         ).animate(
              //           CurvedAnimation(
              //             parent: animationController,
              //             curve: Curves.easeInOut,
              //           ),
              //         );
              //
              //         animationController.forward(from: 0);
              //
              //         // animationController.forward(from: 0);
              //          _handleDoubleTap();
              //         // final scale = 5;
              //         //
              //         // final position = tapDownDetails!.localPosition;
              //         // final x = -position.dx *(scale - 1);
              //         // final y = -position.dy *(scale - 1);
              //         // // final scale = 3;
              //         //
              //         // final zoomed = Matrix4.identity()
              //         //   ..translate(x,y)
              //         //   ..scale(scale);
              //         // final end = _transformationController.value.isIdentity() ?zoomed
              //         //     // ? Matrix4.identity()
              //         //     : Matrix4.identity();
              //         // animation = Matrix4Tween(
              //         //   begin: _transformationController.value,
              //         //   end: end,
              //         // ).animate(CurveTween(curve: Curves.easeOut)
              //         //     .animate(animationController));
              //         // animationController.forward(from: 0);
              //       },
              //       child: InteractiveViewer(
              //         transformationController: _transformationController,
              //
              //         panEnabled: true,
              //         // Optional: Allow panning (dragging)
              //         // scaleEnabled: true,
              //         // boundaryMargin: EdgeInsets.all(double.infinity),
              //         // minScale: 1,
              //         maxScale: 4.0,
              //         clipBehavior: Clip.none,
              //         trackpadScrollCausesScale: true,
              //         scaleEnabled: true,
              //         constrained: true,
              //         child: Container(
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //               image: _currentIndex == index
              //                   ? NetworkImage(
              //                   '$IMAGE_URL${widget.imageUrls[index]}')
              //                   : NetworkImage(
              //                   '$IMAGE_URL${widget.imageUrls[index]}'),
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              //   options: CarouselOptions(
              //     padEnds: true,
              //     initialPage: widget.initialIndex,
              //     height: MediaQuery
              //         .of(context)
              //         .size
              //         .height * 0.75,
              //     viewportFraction: 1,
              //     // enlargeCenterPage: true,
              //     autoPlay: false,
              //     onPageChanged: (index, reason) {
              //       setState(() {
              //         _currentIndex = index;
              //         _transformationController.value = Matrix4.identity();
              //
              //       });
              //     },
              //   ),
              // ),
              ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      for (var controller in _controllers) {
                        controller.value = Matrix4.identity();
                      }
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 50,
                    width: 50,
                    child: Image.network(
                      '$IMAGE_URL${widget.imageUrls[index]}',
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, size: 50, color: Colors.red),
                              SizedBox(height: 8),
                              Text(StringRes.failedToLoadImage),
                            ],
                          ),
                        );
                      },
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index ? COLOR.pink : COLOR.grey,
                      ),

                      // image: DecorationImage(
                      //   image: NetworkImage(
                      //       '$IMAGE_URL${widget.imageUrls[index]}'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
