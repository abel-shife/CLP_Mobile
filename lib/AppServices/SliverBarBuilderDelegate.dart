import 'package:flutter/material.dart';

class SliverAppBarDelegateBuilder extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color color;

  SliverAppBarDelegateBuilder(this.tabBar, this.color);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
