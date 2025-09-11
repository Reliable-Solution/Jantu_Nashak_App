import 'package:flutter/material.dart';

import '../../constant/imagesConst.dart';
import 'app_common_text.dart';
import 'app_style.dart';
// import 'package:suratjugaad/a_structure/constant/app_common_text.dart';
// import 'package:suratjugaad/a_structure/constant/app_styles.dart';
// import 'package:suratjugaad/a_structure/constant/image_const.dart';

class SearchDropUiWidget extends StatelessWidget {
  final String label;
  final Function() onTap;
  final String title;
  final bool isValueSelected;
  final bool isDropDownDisable;
  final Widget suffixIcons;

  const SearchDropUiWidget(
      {super.key,
      required this.label,
      required this.title,
      required this.onTap,
      this.isDropDownDisable = false,
      this.isValueSelected = false,
      required this.suffixIcons});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Row(
                children: [
                  textSemiBold(text: label, fontSize: 14),
                ],
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppStyles.greyBorderDD)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textRegular(
                        text: title,
                        fontSize: 14,
                        fontColor: isValueSelected == true
                            ? AppStyles.grey71
                            : AppStyles.primaryColor,
                      ),
                      isValueSelected == true
                          ? suffixIcons
                          : Image.asset(
                              Images.arrowDownPNG,
                              height: 18,
                            )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isDropDownDisable == true)
          Container(
            height: 43,
            width: size.width,
            decoration: BoxDecoration(
              color: AppStyles.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
          )
        else
          const SizedBox()
      ],
    );
  }
}
