class ErrorMessage {
  static String getMsg(int? code) {
    String message = '未知错误';
    switch (code) {
      case 400:
        message = '请求语法错误';
        break;
      case 401:
        message = '没有权限';
        break;
      case 403:
        message = '服务器拒绝执行';
        break;
      case 404:
        message = '无法连接服务器';
        break;
      case 415:
        message = '不支持的媒体类型';
        break;
      case 405:
        message = '请求方法被禁止';
        break;
      case 500:
        message = '服务器内部错误';
        break;
      case 502:
        message = '无效的请求';
        break;
      case 503:
        message = '服务器挂了';
        break;
      case 505:
        message = '不支持HTTP协议请求';
        break;
      default:
        break;
    }

    return message;
  }
}
