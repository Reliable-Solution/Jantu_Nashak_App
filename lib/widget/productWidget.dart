import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:keep_app/models/productModel.dart';
import 'package:keep_app/utils/string_res.dart';
import 'package:keep_app/widget/productDetailView.dart';
import 'package:keep_app/widget/textWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../Theme/nativeTheme.dart';
import '../constant/app_constant.dart';
import '../constant/colorConst.dart';
import '../controller/homeController.dart';
import '../controller/productDetailController.dart';
import '../controller/shareProductsController.dart';
import '../utils/services/api_services.dart';
import 'alignWidget.dart';
import 'iconButtonWidget.dart';

class ProductComponent extends StatefulWidget {
  Color color;

  ProductComponent({
    super.key,
    @required this.products,
    this.color = Colors.white,
  });

  final ProductModel? products;

  @override
  State<ProductComponent> createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {
  Color? color;

  final ShareProductController controller = Get.find();

  final HomeController homeController = Get.find();
  bool isShareLoad = false;

  double calculateDiscount(double mrp, double srp) {
    print('Invalid MRP or SRP values $mrp $srp');
    if (mrp <= 0) {
      throw Exception("Invalid MRP or SRP values $mrp $srp");
    }
    double discount = ((mrp - srp) / mrp) * 100;
    return discount;
  }

  void changeSearchLoader(bool value) {
    setState(() => isShareLoad = value);
  }

  @override
  Widget build(BuildContext context) {
    double heightView = (MediaQuery.of(context).size.height * 18) / 100;
    ProductDetailsController productDetailsController = Get.find();

    return InkWell(
      onTap: () {
        Get.to(
          () => ProductDetailScreen(
            products: widget.products!,
            isExpanded: true,
            fromDeepLink: false,
          ),
          transition: Transition.rightToLeftWithFade,
        );
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width *
            0.5, // 👈 Must give width if inside horizontal ListView

        alignment: Alignment.center,
        // decoration: BoxDecoration(gradient: LinearGradient(colors: Colors.),
        //   boxShadow: [
        //     // BoxShadow(
        //     //   color: Colors.amber.withOpacity(0.2),
        //     //   blurRadius: 10,
        //     //   offset: Offset(0, 0),
        //     //   blurStyle: BlurStyle.inner,
        //     //   spreadRadius: -1,
        //     // ),
        //     BoxShadow(
        //       color: Colors.black.withOpacity(0.2),
        //       blurRadius: 10,
        //       // offset: Offset(0, 10),
        //       blurStyle: BlurStyle.outer,
        //       spreadRadius: -1,
        //     )
        //   ],
        //   // color: COLOR.background,
        //   borderRadius: BorderRadius.circular(0),
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: heightView,
              // color: Colors.black,
              child: Stack(
                children: [
                  // Container(
                  //   width: 120, // Adjust size as needed
                  //   height: 20, // Height of pedestal base
                  //   decoration: BoxDecoration(
                  //     color: Colors.black, // Pedestal color
                  //     borderRadius: BorderRadius.vertical(
                  //       top: Radius.circular(20), // Circular top edge
                  //     ),
                  //   ),
                  // ),
                  Hero(
                    transitionOnUserGestures: true,
                    tag:
                        "photonew${widget.products!.packInfo?[0].productdetailId}",
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            stops: [0.5, 2],
                            end: Alignment.topCenter,
                            colors: [
                              Colors.white70,
                              widget.color
                              // color:
                              // Colors.green.withOpacity(0.6),
                              // Color(0xFFF5E6F5),
                              // Light purple/pink background similar to screenshot

                              // Colors.amber.withOpacity(0.2),
                              // Colors.transparent.withOpacity(0.0)
                            ]),
                        // boxShadow: [
                        //   // BoxShadow(
                        //   //   color: Colors.amber.withOpacity(0.2),
                        //   //   blurRadius: 10,
                        //   //   offset: Offset(0, 0),
                        //   //   blurStyle: BlurStyle.inner,
                        //   //   spreadRadius: -1,
                        //   // ),
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.2),
                        //     blurRadius: 10,
                        //     // offset: Offset(0, 10),
                        //     blurStyle: BlurStyle.outer,
                        //     spreadRadius: -1,
                        //   )
                        // ],
                        // color: COLOR.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            '$IMAGE_URL${widget.products!.packInfo![0].productdetailImages![0]}',
                        height: heightView,
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: heightView,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.broken_image,
                              color: Colors.red, size: 50),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //   child: AlignWidget(
                  //     alignment: Alignment.topRight,
                  //     child: GetBuilder<HomeController>(
                  //       builder: (_controller) => CircleAvatar(
                  //         maxRadius: 15,
                  //         backgroundColor: COLOR.background.withOpacity(0.8),
                  //         child: GetBuilder<ShareProductController>(
                  //           builder: (controller) => IconButtonWidget(
                  //             voidCallback: () {
                  //               if (products!.isFav == false) {
                  //                 controller.addWishlist(
                  //                     productId: products!.productId!);
                  //                 products!.isFav = true;
                  //                 _controller.update();
                  //               } else {
                  //                 controller.removeWishList(
                  //                     productId: products!.productId!);
                  //                 products!.isFav = false;
                  //                 _controller.update();
                  //               }
                  //
                  //               _controller.update();
                  //             },
                  //             color: products!.isFav == false
                  //                 ? COLOR.black
                  //                 : COLOR.appBaseColor,
                  //             icons: products!.isFav == false
                  //                 ? Icons.favorite_border
                  //                 : Icons.favorite,
                  //             size: 20,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 5),
                              alignment: Alignment.centerLeft,
                              child: TextWiget(
                                title: '${widget.products!.productName}',
                                style:
                                    Themes.light.textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: COLOR.black,
                                  fontWeight: FontWeight.w800,
                                  //     fontFamily: 'GentiumPlus'
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: TextWiget(
                                      title:
                                          '₹${widget.products!.packInfo![0].productdetailSrp!} ',
                                      style: Themes
                                          .dark.textTheme.displayMedium!
                                          .copyWith(
                                        overflow: TextOverflow
                                            .ellipsis, // Handle overflow),
                                      )),
                                ),
                                Flexible(
                                  child: TextWiget(
                                    title:
                                        '₹${widget.products!.packInfo![0].productdetailMrp!} ',
                                    style: Themes.light.textTheme.bodyMedium!
                                        .copyWith(
                                      color: COLOR.grey,
                                      decoration: TextDecoration.lineThrough,
                                      overflow: TextOverflow
                                          .ellipsis, // Handle overflow
                                    ),
                                  ),
                                ),
                                if(widget.products!.packInfo![0].productdetailMrp != widget.products!.packInfo![0].productdetailSrp!)
                                Flexible(
                                  child: TextWiget(
                                    title:
                                        '${calculateDiscount(double.parse(widget.products!.packInfo![0].productdetailMrp!), double.parse(widget.products!.packInfo![0].productdetailSrp!)).toInt()} % ${StringRes.off}',
                                    style: Themes.dark.textTheme.displayMedium!
                                        .copyWith(
                                      color: COLOR.green,
                                      overflow: TextOverflow
                                          .ellipsis, // Handle overflow
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: 30,
                          child: IconButtonWidget(
                            icons: Icons.share_outlined,
                            voidCallback: () async {
                              changeSearchLoader(true);
                              // showSharingDialog(context);
                              List<XFile> files = [];
                              // List<String> images = widget.products!.packInfo
                              //         ?.map((e) => e.productdetailImages?.join(', ') ?? '').toList() ??
                              //     [];


                              final allImages = widget.products?.packInfo
                                  ?.expand((e) => e.productdetailImages ?? [])
                                  .toList() ??
                                  [];

                              final uniqueImages = allImages.toSet().toList();

                              print("===>>> Total images: ${allImages.length}");
                              print("===>>> Unique images: ${uniqueImages.length}");
                              // List<String> images = widget.products!.packInfo![0].productdetailImages??[];
                              print("===>>> images.length ${uniqueImages.length}");
                              for (int i = 0; i < uniqueImages.length; i++) {
                                final url = Uri.parse('$IMAGE_URL${uniqueImages[i]}');
                                final response = await http.get(url);

                                var dir = await getTemporaryDirectory();

                                File file =
                                    await File('${dir.path}/$i\\myItem.png')
                                        .writeAsBytes(response.bodyBytes);

                                files.add(XFile(file.path));

                                // controller.updateProgress((i + 1));
                              }
                              // controller.updateImagesStatus(true);

                              final productId =
                                  widget.products?.productId ?? '123';
                              // final deepLink =
                              //     'jantunashak://product/$productId';
                              final webLink = '${ApiService.baseUrl}check_product/$productId';

                              // Uri newLink =  Uri.parse(deepLink);
                              final playStoreLink =
                                  'https://play.google.com/store/apps/details?id=com.reliable.jantunashak';

                              final text =
                                  'Check out this product: $webLink\n\nInstall the app: $playStoreLink';

                              // Share.share(
                              //   'Check out this product: $deepLink\nInstall app: $playStoreLink',
                              // );

                              await Share.shareXFiles(
                                files,
                                text: text,
                                subject: 'JantuNashak Product',
                                // files,
                                //     text:
                                //         "Check out this product: $deepLink\nInstall app: $playStoreLink",
                                //     subject: "Data"
                              ).then(
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
                            // voidCallback: () async {
                            //   showSharingDialog(context);
                            //   List<XFile> files = [];
                            //   List<String> images = widget.products!
                            //           .packInfo![0].productdetailImages ??
                            //       [];
                            //   for (int i = 0; i < images.length; i++) {
                            //     final url =
                            //         Uri.parse('$IMAGE_URL${images[i]}');
                            //     final response = await http.get(url);
                            //
                            //     var dir = await getTemporaryDirectory();
                            //
                            //     File file =
                            //         await File('${dir.path}/$i\\myItem.png')
                            //             .writeAsBytes(response.bodyBytes);
                            //
                            //     files.add(XFile(file.path));
                            //
                            //     productDetailsController
                            //         .updateProgress((i + 1));
                            //   }
                            //   productDetailsController
                            //       .updateImagesStatus(true);
                            //
                            //   await Share.shareXFiles(files);
                            //   productDetailsController
                            //       .startDescriptionSharing();
                            //
                            //   for (int i = 0; i <= 100; i += 10) {
                            //     await Future.delayed(
                            //         Duration(milliseconds: 100));
                            //     productDetailsController
                            //         .updateProgress(i / 100);
                            //   }
                            //   // await Share.share(
                            //   //     '${products!.productDescription}');
                            //   // productDetailsController
                            //   //     .updateDescriptionStatus(true);
                            //   // productDetailsController
                            //   //     .updateProgress(1.0); // Complete progress
                            //
                            //
                            //   final productId = widget.products?.productId ?? '123';
                            //   final deepLink = 'jantunashak://product/$productId';
                            //   final playStoreLink = 'https://play.google.com/store/apps/details?id=com.reliable.jantunashak';
                            //
                            //   Share.share(
                            //     'Check out this product: $deepLink\nInstall app: $playStoreLink',
                            //   );
                            //
                            //   Future.delayed(
                            //     Duration(milliseconds: 500),
                            //     () {
                            //       Navigator.pop(
                            //           context); // Close popup after sharing
                            //       productDetailsController
                            //           .updateImagesStatus(false);
                            //       productDetailsController
                            //           .updateDescriptionStatus(false);
                            //     },
                            //     // icons: Icons.share_outlined,
                            //   );
                            // }
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
