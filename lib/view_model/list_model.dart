import 'package:tmdb_demo/api/api_service.dart';
import 'package:tmdb_demo/entity/movie_entity.dart';

import '../provider/view_state_list_model.dart';

class ListModel<T> extends ViewStateListModel<T> {
  String? language;
  String? timeWindow;

  @override
  Future<List<T>> loadData() async {
    List<T> result = [];
    switch (T) {
      ///推荐列表
      case MovieEntity:
        timeWindow ??= '/day';
        result = await ApiService.getRecommenList(
          timeWindow: timeWindow!,
          language: language ?? 'zh-CN',
        );
        break;

      default:
        break;
    }
    return result;
  }
}
