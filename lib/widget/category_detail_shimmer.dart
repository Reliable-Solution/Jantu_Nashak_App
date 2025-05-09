// import 'package:fixit_user/config.dart';
import 'package:flutter/material.dart';
import 'package:keep_app/widget/service_shimmer.dart';
import 'package:keep_app/widget/spacing.dart';
import 'package:keep_app/widget/widget_extension.dart';

import 'common_skeleton.dart';

class CategoryDetailShimmer extends StatelessWidget {
  const CategoryDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          // const VSpace(Sizes.s),
          const Row(children: [
            CommonSkeleton(height: 40, width: 40, isCircle: true),
            HSpace(48),
            CommonSkeleton(height: 23, width: 138, radius: 12)
          ]),
          const VSpace(25),
          const CommonSkeleton(
            height: 48,
            radius: 20
          ),
          const VSpace(25),
          const CommonSkeleton(height: 16, width: 96).alignment(Alignment.centerLeft),
          const VSpace(20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:  List.generate(8, (index) {
                return const Column(children: [
                  CommonSkeleton(height: 60, width: 60, radius: 10),
                  VSpace(11),
                  CommonSkeleton(height: 13, width: 60, radius: 10)
                ]).padding( bottom: 22,left:  0,right: 15);
              }),
            ),
          ),
          const ServicesShimmer(count: 3),
        ],
      ).width(MediaQuery.of(context).size.width),
    );
  }
}
