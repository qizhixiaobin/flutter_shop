
import 'package:flutter/material.dart';

class Guess extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Text("猜你喜欢"),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}