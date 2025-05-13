import 'package:flutter/material.dart';

class TabbarViewWidget extends StatelessWidget {
  final TabController? controller;
  final List<Widget>? children;
  final ScrollPhysics? physics;
  const TabbarViewWidget({
    Key? key,
    @required this.controller,
    @required this.children,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      physics: physics ?? null,
      children: children!,
    );
  }
}
