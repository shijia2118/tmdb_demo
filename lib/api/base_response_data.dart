abstract class BaseResponseData {
  bool? success;
  int? code;
  String? message;

  BaseResponseData({
    this.success,
    this.code,
    this.message,
  });

  @override
  String toString() {
    return 'BaseRespData{success:$success,status_code: $code,status_message:$message}';
  }
}
