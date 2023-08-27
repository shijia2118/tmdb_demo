import 'package:dio/dio.dart';
import 'package:tmdb_demo/utils/log_util.dart';
import '../exception/not_success_exeption.dart';
import '../response_data.dart';

class RequestInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String baseUrl = options.baseUrl;
    String path = options.path;
    var data = options.data;

    if (options.data is FormData) data = data.fields;
    LogUtil.print(
      '**************************************************请求信息***********************************************************\n'
      'name-----> ${options.path}\n'
      'header---> ${options.headers}\n'
      'url------> $baseUrl$path'
      ' data: $data'
      ' queryParameters: ${options.queryParameters}'
      ' extra: ${options.extra}',
    );
    return handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    LogUtil.print(
      '**************************************************响应结果***********************************************************\n'
      'name-----> ${response.requestOptions.path}\n'
      'result---> ${response.data}',
    );

    if (response.data['status_code'] != null) {
      ResponseData respData = ResponseData.fromJson(response.data);
      throw NotSuccessException.fromRespData(respData);
    } else {
      //请求成功
      return handler.resolve(response);
    }
  }

  @override
  onError(DioException err, handler) async {
    //向上抛出异常.具体而言，就是抛给viewmodel，使其catch异常，然后再进入setError（）方法.
    return handler.reject(err);
  }
}
