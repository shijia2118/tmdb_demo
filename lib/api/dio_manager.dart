import 'package:dio/dio.dart';
import 'package:tmdb_demo/ui/constant.dart';
import 'interceptor/request_interceptor.dart';

class DioManager {
  ///静态属性实例
  static final DioManager _instance = DioManager._internal();
  Dio? _dio;

  Dio? get dio => _dio;

  factory DioManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  DioManager._internal() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: kBaseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      );
      _dio!.interceptors.add(RequestInterceptor());
      _dio!.options.headers.addAll({
        'content-type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $kAccessToken',
      });
    }
  }

  ///动态域名
  static DioManager getInstance({String? baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //默认域名
  DioManager _normal() {
    if (_dio != null) {
      if (_dio!.options.baseUrl != kBaseUrl) {
        _dio!.options.baseUrl = kBaseUrl;
      }
    }
    return this;
  }

  //指定域名
  DioManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio!.options.baseUrl = baseUrl;
    }
    return this;
  }

  ///************************************************常规请求封装**************************************************///

  ///同一个CancelToken可以用于多个请求，当一个CancelToken取消时，
  ///所有使用该CancelToken的请求都会被取消，一个页面对应一个CancelToken。
  static final CancelToken _cancelToken = CancelToken(); //实例化"取消请求对象"

  /// 取消请求
  void cancelRequests({required CancelToken token}) {
    _cancelToken.cancel("cancelled");
  }

  ///GET请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false, //以下4个参数与缓存相关
    String? cacheKey,
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        "refresh": refresh,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      },
    );
    return await _dio!.get(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
  }

  ///POST请求
  Future post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio!.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  ///PUT请求
  Future put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio!.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  ///PATCH请求
  Future patch(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio!.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  ///DELETE请求
  Future delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio!.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
