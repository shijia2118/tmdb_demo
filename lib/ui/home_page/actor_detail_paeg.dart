import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_demo/entity/actor_detail_entity.dart';
import 'package:tmdb_demo/entity/movie_entity.dart';
import 'package:tmdb_demo/provider/provider_widget.dart';
import 'package:tmdb_demo/provider/view_state_widget.dart';
import 'package:tmdb_demo/ui/home_page/representative_work_item.dart';
import 'package:tmdb_demo/view_model/view_model.dart';
import 'package:tmdb_demo/widgets/app_bar_common.dart';
import 'package:tmdb_demo/widgets/image_network.dart';
import 'package:tmdb_demo/widgets/text_common.dart';

class ActorDetailPage extends StatefulWidget {
  final int actorId;
  const ActorDetailPage({super.key, required this.actorId});

  @override
  State<ActorDetailPage> createState() => _ActorDetailPageState();
}

class _ActorDetailPageState extends State<ActorDetailPage> {
  ViewModel model = ViewModel();

  String sex = ''; //性别
  String birth = ''; //出生日期
  String placeOfBirth = ''; //出生地
  String alsoKnownAs = '无'; //又名
  String biography = '无'; //简介
  List<MovieEntity> representativeWorks = [];

  @override
  Widget build(BuildContext context) {
    ///头像
    Widget avatar = ImageNetwork(
      model.actorDetailEntity?.profilePath ?? '',
      width: 100.w,
      height: 100.w,
      avatar: true,
      circle: true,
    );

    ///名字
    Widget nameWidget = TextCommon(
      model.actorDetailEntity?.name ?? '',
      softWrap: true,
      bold: true,
      fontSize: 16.sp,
      center: true,
    );

    Widget itemRow({required String title, required String subTitle}) {
      return SizedBox(
        width: 0.5.sw,
        child: Row(
          children: [
            SizedBox(
              width: 60.w,
              child: TextCommon('$title:', bold: true),
            ),
            Expanded(
              child: TextCommon(
                subTitle,
                softWrap: true,
              ),
            ),
          ],
        ),
      );
    }

    ///个人简介(标题)
    Widget profileTitle = Padding(
      padding: EdgeInsets.only(top: 20.w, bottom: 5.w),
      child: TextCommon(
        '个人简介:',
        fontSize: 16.sp,
        bold: true,
      ),
    );

    ///个人简介(内容)
    Widget profileContent = TextCommon(
      biography,
      softWrap: true,
    );

    ///代表作(标题)
    Widget representativeWorkTitle = Padding(
      padding: EdgeInsets.only(top: 20.w, bottom: 5.w),
      child: TextCommon(
        '代表作:',
        fontSize: 16.sp,
        bold: true,
      ),
    );

    ///代表作(水平滑动)
    Widget representativeWorkView = SizedBox(
      height: 230.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: representativeWorks.length,
        itemBuilder: (context, index) {
          return RepresentativeWorkItem(
            movieEntity: representativeWorks[index],
          );
        },
      ),
    );

    return Scaffold(
      appBar: const AppBarCommon(title: '演员详情'),
      body: ProviderWidget<ViewModel>(
        model: model,
        onModelReady: (model) => getActorDetail(),
        builder: (context, model, _) {
          return viewStateBuilder(model, getActorDetail) ??
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(15.w, 10.w, 15.w, 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 0.4.sw,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                avatar,
                                SizedBox(height: 10.w),
                                nameWidget,
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              itemRow(title: '性别', subTitle: sex),
                              SizedBox(height: 8.w),
                              itemRow(title: '出生日期', subTitle: birth),
                              SizedBox(height: 8.w),
                              itemRow(title: '出生地', subTitle: placeOfBirth),
                              SizedBox(height: 8.w),
                              itemRow(title: '又名', subTitle: alsoKnownAs),
                            ],
                          ),
                        ],
                      ),
                    ),
                    profileTitle,
                    profileContent,
                    representativeWorkTitle,
                    representativeWorkView,
                  ],
                ),
              );
        },
      ),
    );
  }

  ///初始化数据
  Future<void> getActorDetail() async {
    await model.getActorDetail(id: widget.actorId);
    ActorDetailEntity? detailEntity = model.actorDetailEntity;
    if (detailEntity != null) {
      if (detailEntity.gender != null) {
        if (detailEntity.gender == 1) {
          sex = '女';
        } else if (detailEntity.gender == 2) {
          sex = '男';
        }
      }
      if (detailEntity.birthday != null) {
        birth = detailEntity.birthday!;
      }
      if (detailEntity.placeOfBirth != null) {
        placeOfBirth = detailEntity.placeOfBirth!;
      }
      if (detailEntity.alsoKnownAs != null && detailEntity.alsoKnownAs!.isNotEmpty) {
        alsoKnownAs = detailEntity.alsoKnownAs!.join(',');
      }
      if (detailEntity.biography != null && detailEntity.biography!.isNotEmpty) {
        biography = detailEntity.biography!;
      }
      if (detailEntity.movieCredits?.cast != null) {
        representativeWorks = detailEntity.movieCredits!.cast!;
      }
      if (mounted) setState(() {});
    }
  }
}
