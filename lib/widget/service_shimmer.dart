import 'package:figma_squircle/figma_squircle.dart';
// import 'package:fixit_user/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/widget/spacing.dart';

import 'common_skeleton.dart';

class ServicesShimmer extends StatelessWidget {
  final int count;
  const ServicesShimmer({super.key,  this.count =2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ ...List.generate(count, (index) {
        return Container(
            margin:  EdgeInsets.symmetric(
                horizontal:count >2?0: 20, vertical: 15),
            decoration: ShapeDecoration(
                color: Colors.white,
                shadows: [
                  BoxShadow(
                      color:  Colors.white.withOpacity(0.06),
                      spreadRadius: 2,
                      blurRadius: 12)
                ],
                shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                        cornerRadius: 8, cornerSmoothing: 1),
                    side:
                    BorderSide(color: Color(0xffEDEDED)))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [
                    CommonSkeleton(
                        height: 30, width: 30, isCircle: true),
                    HSpace(15),
                    CommonSkeleton(height: 15, width: 108)
                  ])
                      .paddingAll(15),
                  const CommonSkeleton(height: 145, radius: 0),
                  const VSpace(15),
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonSkeleton(height: 16, width: 155),
                        VSpace(10),
                        CommonSkeleton(height: 16, width: 224),
                        VSpace(10),
                        CommonSkeleton(height: 16, width: 205),
                        VSpace(10),
                        CommonSkeleton(height: 16, width: 175),
                        VSpace(10)
                      ]).paddingSymmetric(horizontal: 15)
                ]));
      })],
    );
  }
}
