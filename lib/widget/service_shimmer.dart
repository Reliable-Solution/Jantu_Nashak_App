// import 'package:figma_squircle/figma_squircle.dart';
// // import 'package:fixit_user/config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:keep_app/widget/spacing.dart';
//
// import 'common_skeleton.dart';
//
// class ServicesShimmer extends StatelessWidget {
//   final int count;
//   const ServicesShimmer({super.key, this.count = 2});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ...List.generate(count, (index) {
//           return Container(
//               margin: EdgeInsets.symmetric(
//                   horizontal: count > 2 ? 0 : 20, vertical: 15),
//               decoration: ShapeDecoration(
//                   color: Colors.white,
//                   shadows: [
//                     BoxShadow(
//                         color: Colors.white.withOpacity(0.06),
//                         spreadRadius: 2,
//                         blurRadius: 12)
//                   ],
//                   shape: SmoothRectangleBorder(
//                       borderRadius: SmoothBorderRadius(
//                           cornerRadius: 8, cornerSmoothing: 1),
//                       side: BorderSide(color: Color(0xffEDEDED)))),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Row(children: [
//                       CommonSkeleton(height: 30, width: 30, isCircle: true),
//                       HSpace(15),
//                       CommonSkeleton(height: 15, width: 108)
//                     ]).paddingAll(15),
//                     const CommonSkeleton(height: 145, radius: 0),
//                     const VSpace(15),
//                     const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CommonSkeleton(height: 16, width: 155),
//                           VSpace(10),
//                           CommonSkeleton(height: 16, width: 224),
//                           VSpace(10),
//                           CommonSkeleton(height: 16, width: 205),
//                           VSpace(10),
//                           CommonSkeleton(height: 16, width: 175),
//                           VSpace(10)
//                         ]).paddingSymmetric(horizontal: 15)
//                   ]));
//         })
//       ],
//     );
//   }
// }


import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keep_app/widget/spacing.dart';
import 'common_skeleton.dart';

class ServicesShimmer extends StatelessWidget {
  final int count;
  const ServicesShimmer({super.key, this.count = 6}); // Default to 6 items (3x2 grid)

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:[

        Container(
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
                ])),
        GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns as per image
            childAspectRatio: 0.75, // Adjust aspect ratio to match image height/width
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: count,
          physics: NeverScrollableScrollPhysics(), // Prevent scrolling, let parent handle it
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(cornerRadius: 12, cornerSmoothing: 0.8),
                  side: BorderSide(color: Color(0xffEDEDED)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Container(
                    height: 120, // Match approximate image height from the UI
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: CommonSkeleton(height: 120, radius: 0),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title placeholder
                        CommonSkeleton(height: 16, width: 120),
                        VSpace(8),
                        // Price placeholder
                        CommonSkeleton(height: 16, width: 80),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )],
    );
  }
}