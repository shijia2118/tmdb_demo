import 'package:tmdb_demo/api/dio_manager.dart';
import 'package:tmdb_demo/entity/actor_detail_entity.dart';
import 'package:tmdb_demo/entity/movie_detail_entity.dart';
import 'package:tmdb_demo/entity/movie_entity.dart';

class ApiService {
  /// 热门电影
  static Future getMovies(Map<String, dynamic> map, {required String movieType}) async {
    var res = await DioManager.getInstance().get('/movie/$movieType', queryParameters: map);
    if (res.data['results'] is List) {
      return (res.data['results'] as List).map((e) => MovieEntity.fromJson(e)).toList();
    }
    return <MovieEntity>[];
  }

  /// 搜索推荐列表
  static Future getRecommenList({required String timeWindow, String? language = 'zh-CN'}) async {
    Map<String, dynamic> map = {
      'language': language,
    };

    var res = await DioManager.getInstance().get('/trending/all$timeWindow', queryParameters: map);
    if (res.data['results'] is List) {
      return (res.data['results'] as List).map((e) => MovieEntity.fromJson(e)).toList();
    }
    return <MovieEntity>[];
  }

  /// 根据名称搜索
  static Future search(Map<String, dynamic> map) async {
    var res = await DioManager.getInstance().get('/search/movie', queryParameters: map);
    if (res.data['results'] is List) {
      return (res.data['results'] as List).map((e) => MovieEntity.fromJson(e)).toList();
    }
    return <MovieEntity>[];
  }

  /// 获取电影详情
  static Future getDetail({required int id, String? appendToResponse, String? language = 'zh-CN'}) async {
    Map<String, dynamic> map = {
      'language': language,
      'append_to_response': appendToResponse,
    };
    var res = await DioManager.getInstance().get('/movie/$id', queryParameters: map);
    return MovieDetailEntity.fromJson(res.data);
  }

  /// 获取电影详情
  static Future getActorDetail({required int id, String? appendToResponse, String? language = 'zh-CN'}) async {
    Map<String, dynamic> map = {
      'language': language,
      'append_to_response': appendToResponse ?? 'movie_credits',
    };
    var res = await DioManager.getInstance().get('/person/$id', queryParameters: map);
    return ActorDetailEntity.fromJson(res.data);
  }
}
