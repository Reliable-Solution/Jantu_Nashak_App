import 'package:flutter/material.dart';
import 'package:keep_app/view/home/priceStroescreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:keep_app/models/categoryModel.dart';
import '../constant/app_constant.dart';
import '../constant/colorConst.dart';

class CategoryComponent extends StatelessWidget {
  final CategoryModel? categoryModel;

  const CategoryComponent({super.key, this.categoryModel});

  @override
  Widget build(BuildContext context) {
    double imageHeight = Get.width > 360
        ? MediaQuery.of(context).size.height * 0.15
        : MediaQuery.of(context).size.height * 0.17;

    return InkWell(
      onTap: () {
        Get.to(SubCategoryScreen(category: categoryModel!.categoryId));
        // Navigate to product details if needed
      },
      child: Container(
        color: COLOR.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: '$IMAGE_URL${categoryModel?.categoryImage ?? ""}',
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
