import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_demo/entity/movie_detail_entity.dart';
import 'package:tmdb_demo/provider/provider_widget.dart';
import 'package:tmdb_demo/provider/view_state_widget.dart';
import 'package:tmdb_demo/ui/home_page/actor_avatar_item.dart';
import 'package:tmdb_demo/view_model/view_model.dart';
import 'package:tmdb_demo/widgets/app_bar_common.dart';
import 'package:tmdb_demo/widgets/image_network.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  ViewModel model = ViewModel();

  List<Cast> actors = [];

  @override
  Widget build(BuildContext context) {
    /// 电影海报
    Widget posterWidget = Container(
      alignment: Alignment.center,
      width: 1.sw,
      height: 250.w,
      color: Colors.black,
      child: ImageNetwork(
        (model.detailEntity?.posterPath) ?? '',
        height: 250.w,
        fit: BoxFit.fitHeight,
      ),
    );

    /// 电影名称
    Widget titleWidget = Container(
      padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 20.w),
      child: TextCommon(
        model.detailEntity?.title ?? '',
        bold: true,
        fontSize: 24.sp,
      ),
    );

    ///发行时间
    Widget releaseWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          SizedBox(
            width: 70.w,
            child: const TextCommon('发行时间:'),
          ),
          TextCommon(model.detailEntity?.releaseDate ?? 'yyyy-mm-dd'),
        ],
      ),
    );

    ///播放时长
    Widget playTimeWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
      child: Row(
        children: [
          SizedBox(
            width: 70.w,
            child: const TextCommon('播放时长:'),
          ),
          TextCommon('${model.detailEntity?.runtime ?? 0}分钟'),
        ],
      ),
    );

    ///简介
    Widget introWidget = Padding(
      padding: EdgeInsets.fromLTRB(10.w, 15.w, 10.w, 0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextCommon(
            '电影简介',
            fontSize: 16.sp,
            bold: true,
          ),
          SizedBox(height: 5.w),
          TextCommon(
            model.detailEntity?.overview ?? '',
            softWrap: true,
          ),
        ],
      ),
    );

    ///演员标题
    Widget actorTitle = Padding(
      padding: EdgeInsets.fromLTRB(10.w, 20.w, 10.w, 5.w),
      child: TextCommon(
        '主演',
        fontSize: 16.sp,
        bold: true,
      ),
    );

    ///演员列表
    Widget actorView = SizedBox(
      height: 100.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            return ActorAvatarItem(
              cast: actors[index],
            );
          }),
    );

    return Scaffold(
      appBar: const AppBarCommon(title: '电影详情'),
      body: ProviderWidget<ViewModel>(
        model: model,
        onModelReady: (model) => getMovieDetail(),
        builder: (context, model, _) {
          return viewStateBuilder(model, getMovieDetail) ??
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    posterWidget,
                    titleWidget,
                    releaseWidget,
                    playTimeWidget,
                    introWidget,
                    actorTitle,
                    actorView,
                  ],
                ),
              );
        },
      ),
    );
  }

  ///初始化参数
  void getMovieDetail() async {
    await model.getDetail(id: widget.movieId, appendToResponse: 'credits');
    if (model.detailEntity?.credits?.cast != null) {
      actors = model.detailEntity!.credits!.cast!;
      if (mounted) setState(() {});
    }
  }
}
