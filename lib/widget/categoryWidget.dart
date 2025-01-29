import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/models/categoryModel.dart';
import '../constant/app_constant.dart';
import '../constant/colorConst.dart';

class CategoryComponent extends StatelessWidget {
  const CategoryComponent({
    super.key,
    @required this.categoryModel,
  });

  final CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.to(() => ProductDetailScreen(products: products!));
      },
      child: Container(
        color: COLOR.background,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          children: [
            Container(
              height: Get.width > 360
                  ? MediaQuery.of(context)
                  .size
                  .height *
                  0.15
                  : MediaQuery.of(context)
                  .size
                  .height *
                  0.175,
              decoration: BoxDecoration(
                color: COLOR.amber,
                image: DecorationImage(
                  image: NetworkImage(
                    '$IMAGE_URL${categoryModel!.categoryImage}',
                  ),
                  fit: BoxFit.fitHeight,
                ),
                // border: Border.all(width: 5)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
