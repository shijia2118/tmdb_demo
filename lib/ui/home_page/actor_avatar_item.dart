import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nav_router/nav_router.dart';
import 'package:tmdb_demo/entity/movie_detail_entity.dart';
import 'package:tmdb_demo/ui/home_page/actor_detail_paeg.dart';
import 'package:tmdb_demo/widgets/image_network.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

class ActorAvatarItem extends StatelessWidget {
  final Cast cast;
  const ActorAvatarItem({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => routePush(ActorDetailPage(actorId: cast.id ?? -1)),
      child: Container(
        width: 65.w,
        height: 100.w,
        color: Colors.transparent,
        child: Column(
          children: [
            ImageNetwork(
              cast.profilePath ?? '',
              width: 50.w,
              height: 50.w,
              circle: true,
            ),
            TextCommon(
              cast.name ?? '',
              softWrap: true,
              center: true,
              fontSize: 12.sp,
            ),
          ],
        ),
      ),
    );
  }
}
