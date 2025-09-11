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
    // Fixed width for horizontal list items
    const double itemWidth = 80.0;
    // Dynamic height based on screen size
    double imageHeight = Get.width > 360
        ? MediaQuery.of(context).size.height * 0.10
        : MediaQuery.of(context).size.height * 0.12;

    return InkWell(
      onTap: () {
        if (categoryModel?.categoryId != null) {
          print("=========> CateGory id ${categoryModel!.categoryId}");
          Get.to(
            SubCategoryScreen(category: categoryModel!.categoryId),
            transition: Transition.zoom,
          );
        }
      },
      child: Container(
        width: itemWidth, // Fixed width for horizontal list
        color: COLOR.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              child: CachedNetworkImage(
                imageUrl: '$IMAGE_URL${categoryModel?.categoryImage ?? ""}',
                height: imageHeight,
                width: itemWidth,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: imageHeight,
                    width: itemWidth,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(Icons.broken_image, color: Colors.red, size: 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
