import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/exception/error_message.dart';
import '../api/exception/frequent_exception.dart';
import '../api/exception/lost_token_exception.dart';
import '../api/exception/not_success_exeption.dart';
import 'view_state.dart';
export 'view_state.dart';

class ViewStateModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState;

  /// 根据状态构造
  ///
  /// 子类可以在构造函数指定需要的页面状态
  /// FooModel():super(viewState:ViewState.busy);
  ViewStateModel({
    ViewState? viewState,
  }) : _viewState = viewState ?? ViewState.idle {
    // debugPrint('ViewStateModel---constructor--->$runtimeType');
  }

  /// ViewState
  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
  }

  /// ViewStateError
  ViewStateError? _viewStateError;

  ViewStateError? get viewStateError => _viewStateError;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  bool get isBusy => viewState == ViewState.busy;

  bool get isIdle => viewState == ViewState.idle;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;

  /// set
  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  /// [e]分为Error和Exception两种
  void setError(e, stackTrace, {String? message}) async {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;

    /// 见https://github.com/flutterchina/dio/blob/master/README-ZH.md#dioerrortype
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        //超时
        errorType = ViewStateErrorType.networkTimeOutError;
        message = '请求超时';
      } else if (e.type == DioExceptionType.badResponse) {
        ///这里是服务器返回的错误信息，包括502，401
        errorType = ViewStateErrorType.unauthorizedError;
        message = ErrorMessage.getMsg(e.response?.statusCode);
      } else if (e.type == DioExceptionType.cancel) {
        message = '请求取消';
      } else {
        String msg = e.message ?? '';
        e = e.error;
        // dio将原error重新套了一层
        if (e is LostTokenException) {
          //token失效,需要重新登录
          stackTrace = null;
          message = '登录过期';
          errorType = ViewStateErrorType.lostTokenError;
        } else if (e is NotSuccessException) {
          //服务器返回的code!=0
          stackTrace = null;
          message = e.message;
        } else if (e is SocketException) {
          //网络异常
          errorType = ViewStateErrorType.networkError;
          message = e.message;
        } else if (e is FrequentExcption) {
          //频繁请求
          errorType = ViewStateErrorType.frequentError;
          message = '请务频繁操作';
        } else {
          message = msg;
        }
      }
    }
    viewState = ViewState.error;
    _viewStateError = ViewStateError(
      errorType,
      message: message ?? "",
      errorMessage: e.toString(),
    );
    printErrorStack(e, stackTrace);
    onError(_viewStateError!);
  }

  void onError(ViewStateError viewStateError) {}

  /// 显示错误消息
  showErrorMessage({String? message}) {
    if (viewStateError != null || message != null) {
      if (viewStateError?.isNetworkTimeOut) {
        message = "网络超时";
      } else if (viewStateError?.isNetworkError) {
        message = '当前网络不可用，请检查您的网络';
      } else {
        message = viewStateError?.message;
      }
      Future.microtask(() {
        Fluttertoast.showToast(msg: message ?? '未知错误', gravity: ToastGravity.CENTER);
      });
    }
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _viewStateError: $_viewStateError}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    // debugPrint('view_state_model dispose -->$runtimeType');
    super.dispose();
  }
}

/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
  debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
$e
<-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
  if (s != null) {
    debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
$s
<-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
    ''');
  }
}
