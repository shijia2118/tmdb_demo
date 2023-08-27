import 'package:tmdb_demo/entity/movie_entity.dart';

import '../api/api_service.dart';
import '../provider/view_state_refresh_list_model.dart';

class RefreshModel<T> extends ViewStateRefreshListModel<T> {
  String? movieType;
  String? query;
  @override
  Future<List<T>> loadData({int pageNum = 1}) async {
    late List<T> result;

    switch (T) {
      /// 电影列表
      case MovieEntity:
        Map<String, dynamic> map = {
          'page': pageNum,
          'language': 'zh-CN',
        };

        if (movieType != null) {
          result = await ApiService.getMovies(map, movieType: movieType!);
        } else {
          map['query'] = query;
          result = await ApiService.search(map);
        }

        break;

      default:
        break;
    }
    return result;
  }
}
