import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav_router/nav_router.dart';
import 'package:tmdb_demo/ui/home_page/search_page.dart';
import 'package:tmdb_demo/ui/home_page/tab_bar_builder.dart';
import 'package:tmdb_demo/ui/home_page/tab_bar_page.dart';
import 'package:tmdb_demo/utils/color_helper.dart';
import 'package:tmdb_demo/widgets/app_bar_common.dart';
import 'package:tmdb_demo/widgets/image_asset.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  List<String> tabs = ['热门电影', '正在上映', '即将上映', '高分'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///搜索框
    Widget searchBar = GestureDetector(
      onTap: () => routePush(const SearchPage()),
      child: Container(
        width: 1.sw,
        height: 40.h,
        margin: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 5.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
          border: Border.all(width: 0, color: Colors.transparent),
        ),
        child: Row(
          children: [
            ImageAsset(
              'search',
              width: 18.w,
              height: 18.w,
            ),
            SizedBox(width: 10.w),
            const TextCommon('请输入标题搜索', color: ColorHelper.c8Color),
          ],
        ),
      ),
    );

    ///tabbar
    Widget tabBar = TabbarBuilder(
      tabController: tabController,
      tabs: tabs,
    );

    return Scaffold(
      backgroundColor: ColorHelper.eaColor,
      appBar: AppBarCommon(
        title: '电影demo',
        hasBack: false,
        bottom: Column(
          children: [
            searchBar,
            tabBar,
          ],
        ),
        bottomHeight: 90.h,
      ),
      body: TabBarView(
          controller: tabController,
          children: tabs.map((e) {
            int index = tabs.indexOf(e);
            return TabbarPage(tabIndex: index);
          }).toList()),
    );
  }
}
