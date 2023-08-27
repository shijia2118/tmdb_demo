import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_demo/entity/movie_entity.dart';
import 'package:tmdb_demo/utils/color_helper.dart';
import 'package:tmdb_demo/widgets/image_network.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

class RepresentativeWorkItem extends StatelessWidget {
  final MovieEntity movieEntity;
  const RepresentativeWorkItem({super.key, required this.movieEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Stack(
        children: [
          //图片
          ImageNetwork(
            movieEntity.posterPath ?? '',
            width: 150.w,
            height: 230.w,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8.r),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              width: 150.sw,
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.r)),
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
                    fontSize: 12.sp,
                    color: ColorHelper.b6Color,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
