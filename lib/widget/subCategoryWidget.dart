import 'package:flutter/material.dart';
import 'package:keep_app/models/subCategoryModel.dart';
import 'package:keep_app/view/home/subCategoryProductScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../constant/app_constant.dart';
import '../constant/colorConst.dart';

class SubCategoryComponet extends StatelessWidget {
  final SubCategory? categoryModel;

  const SubCategoryComponet({super.key, this.categoryModel});

  @override
  Widget build(BuildContext context) {
    double imageHeight = Get.width > 360
        ? MediaQuery.of(context).size.height * 0.15
        : MediaQuery.of(context).size.height * 0.175;

    return InkWell(
      onTap: () {
        Get.to(SubCategoryProductScreen(subCategory: categoryModel!.subcategoryId!));

        // Navigate to product details if needed
      },
      child: Container(
        color: COLOR.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: '$IMAGE_URL${categoryModel?.subcategoryImage ?? ""}',
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.fitHeight,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: imageHeight,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.broken_image, color: Colors.red, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
