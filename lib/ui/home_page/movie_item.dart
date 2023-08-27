import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav_router/nav_router.dart';
import 'package:tmdb_demo/entity/movie_entity.dart';
import 'package:tmdb_demo/ui/common/circular_progress.dart';
import 'package:tmdb_demo/ui/home_page/movie_detail_page.dart';
import 'package:tmdb_demo/utils/color_helper.dart';
import 'package:tmdb_demo/widgets/image_network.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

class MovieItem extends StatelessWidget {
  final MovieEntity movieEntity;
  const MovieItem({super.key, required this.movieEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => routePush(MovieDetailPage(movieId: movieEntity.id ?? -1)),
      child: Stack(
        children: [
          //图片
          ImageNetwork(
            movieEntity.posterPath ?? '',
            width: 0.5.sw,
            height: 0.8.sw,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8.r),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              width: 0.5.sw,
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(5.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //标题
                  TextCommon(
                    movieEntity.title ?? '',
                    bold: true,
                    maxLines: 1,
                  ),
                  SizedBox(height: 5.w),
                  //上映时间
                  TextCommon(
                    movieEntity.releaseDate ?? '',
                  ),
                ],
              ),
            ),
          ),
          //评分
          Positioned(
            bottom: 60.w,
            child: CircularProgress(
              progress: ((movieEntity.voteAverage ?? 0) * 10).toDouble(),
              backgroundColor: ColorHelper.eaColor,
            ),
          ),
        ],
      ),
    );
  }
}
