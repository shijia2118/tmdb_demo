import 'package:tmdb_demo/api/api_service.dart';
import 'package:tmdb_demo/entity/actor_detail_entity.dart';
import 'package:tmdb_demo/entity/movie_detail_entity.dart';

import '../provider/view_state_model.dart';

class ViewModel extends ViewStateModel {
  MovieDetailEntity? detailEntity;
  ActorDetailEntity? actorDetailEntity;

  /// 电影详情
  Future getDetail({required int id, String? appendToResponse, String? language = 'zh-CN'}) async {
    setBusy();
    try {
      detailEntity = await ApiService.getDetail(
        id: id,
        language: language,
        appendToResponse: appendToResponse,
      );
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  /// 获取演员详情
  Future getActorDetail({required int id, String? appendToResponse, String? language = 'zh-CN'}) async {
    setBusy();
    try {
      actorDetailEntity = await ApiService.getActorDetail(
        id: id,
        language: language,
        appendToResponse: appendToResponse,
      );
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}
