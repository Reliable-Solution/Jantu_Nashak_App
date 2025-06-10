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
import 'alignWidget.dart';
import 'iconButtonWidget.dart';

class ProductComponent extends StatelessWidget {

  ProductComponent({
    super.key,
    @required this.products,
  });

  final ProductModel? products;
  final ShareProductController controller = Get.find();
  final HomeController homeController = Get.find();
  double calculateDiscount(double mrp, double srp) {
    print('Invalid MRP or SRP values $mrp $srp');
    if (mrp <= 0 ) {
      throw Exception("Invalid MRP or SRP values $mrp $srp");
    }
    double discount = ((mrp - srp) / mrp) * 100;
    return discount;
  }



  @override
  Widget build(BuildContext context) {
    double heightView = (MediaQuery.of(context).size.height * 22) / 100;
    ProductDetailsController productDetailsController = Get.find();

    return InkWell(
      onTap: () {
        Get.to(() => ProductDetailScreen(products: products!,isExpanded: true,));
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: COLOR.background,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             Stack(
               children: [
                 Hero(
                   transitionOnUserGestures: true,
                   tag: "photonew${products!.packInfo?[0].productdetailId}",
                   child: CachedNetworkImage(
                     imageUrl: '$IMAGE_URL${products!.packInfo![0].productdetailImages![0]}',
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
                       child: Icon(Icons.broken_image, color: Colors.red, size: 50),
                     ),
                   ),
                 ),
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                   child: AlignWidget(
                     alignment: Alignment.topRight,
                     child: GetBuilder<HomeController>(
                       builder: (_controller) => CircleAvatar(
                         maxRadius: 15,
                         backgroundColor: COLOR.background.withOpacity(0.8),
                         child: GetBuilder<ShareProductController>(
                           builder:(controller) =>  IconButtonWidget(
                             voidCallback: () {
                               if (products!.isFav == false) {
                                 controller.addWishlist(productId: products!.productId!);
                                 products!.isFav = true;
                                 _controller.update();
                               } else {
                                 controller.removeWishList(productId: products!.productId!);
                                 products!.isFav = false;
                                 _controller.update();
                               }

                               _controller.update();
                             },
                             color:
                             products!.isFav == false ? COLOR.black : COLOR.appBaseColor,
                             icons: products!.isFav == false
                                 ? Icons.favorite_border
                                 : Icons.favorite,
                             size: 20,
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
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
                                title: '${products!.productName}',
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
                                TextWiget(
                                  title:
                                      '₹${products!.packInfo![0].productdetailSrp!} ',
                                  style: Themes.dark.textTheme.displayMedium,
                                ),
                                TextWiget(
                                  title:
                                  '₹${products!.packInfo![0].productdetailMrp!} ',
                                  style: Themes.light.textTheme.bodyMedium!
                                      .copyWith(
                                    color: COLOR.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                TextWiget(
                                  title: '${calculateDiscount(double.parse(products!.packInfo![0].productdetailMrp!), double.parse(products!.packInfo![0].productdetailSrp!)).toInt()} % ${StringRes.off}',
                                style: Themes.dark.textTheme.displayMedium!
                                      .copyWith(
                                    color: COLOR.green,
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
                            showSharingDialog(context);
                            List<XFile> files = [];
                            List<String> images = products!
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

                              productDetailsController.updateProgress((i + 1));
                            }
                            productDetailsController.updateImagesStatus(true);

                            await Share.shareXFiles(files);
                            productDetailsController.startDescriptionSharing();

                            for (int i = 0; i <= 100; i += 10) {
                              await Future.delayed(
                                  Duration(milliseconds: 100));
                              productDetailsController.updateProgress(i / 100);
                            }
                            await Share.share(
                                '${products!.productDescription}');
                            productDetailsController.updateDescriptionStatus(
                                true);
                            productDetailsController
                                .updateProgress(1.0); // Complete progress

                            Future.delayed(Duration(milliseconds: 500),
                                  () {
                                Navigator.pop(
                                    context); // Close popup after sharing
                                productDetailsController.updateImagesStatus(
                                    false);
                                productDetailsController
                                    .updateDescriptionStatus(false);
                              },
                              // icons: Icons.share_outlined,
                            )
                            ;
                          })
    )],

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
