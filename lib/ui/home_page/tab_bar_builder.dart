import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_demo/utils/color_helper.dart';

class TabbarBuilder extends StatelessWidget {
  final List<String> tabs;
  final TabController tabController;
  const TabbarBuilder({
    super.key,
    required this.tabs,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 40.h,
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
        unselectedLabelColor: ColorHelper.b6Color,
        labelColor: Colors.black,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }
}
