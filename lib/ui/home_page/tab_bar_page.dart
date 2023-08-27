import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tmdb_demo/entity/movie_entity.dart';
import 'package:tmdb_demo/provider/provider_widget.dart';
import 'package:tmdb_demo/provider/view_state_widget.dart';
import 'package:tmdb_demo/ui/home_page/movie_item.dart';
import 'package:tmdb_demo/view_model/refresh_model.dart';

class TabbarPage extends StatefulWidget {
  final int tabIndex;
  const TabbarPage({
    super.key,
    required this.tabIndex,
  });

  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> with AutomaticKeepAliveClientMixin {
  RefreshModel<MovieEntity> model = RefreshModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ProviderWidget<RefreshModel<MovieEntity>>(
      model: model,
      onModelReady: (model) => _initData(),
      builder: (context, model, _) {
        return viewStateBuilder(model, () => _initData()) ??
            SmartRefresher(
              controller: model.refreshController,
              enablePullUp: model.list.length >= 20,
              onRefresh: () => model.refresh(),
              onLoading: () => model.loadMore(),
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                itemCount: model.list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.w,
                  crossAxisSpacing: 6.w,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  return MovieItem(movieEntity: model.list[index]);
                },
              ),
            );
      },
    );
  }

  ///初始化数据
  void _initData() async {
    String? movieType;
    if (widget.tabIndex == 0) {
      movieType = 'popular';
    } else if (widget.tabIndex == 1) {
      movieType = 'now_playing';
    } else if (widget.tabIndex == 2) {
      movieType = 'upcoming';
    } else if (widget.tabIndex == 3) {
      movieType = 'top_rated';
    }
    model.movieType = movieType;
    await model.initData();
  }

  @override
  bool get wantKeepAlive => true;
}
