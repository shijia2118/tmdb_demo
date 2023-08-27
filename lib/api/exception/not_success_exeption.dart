import '../base_response_data.dart';

/// statusCode=200,但code!=0,属于DioErrorType.other
class NotSuccessException implements Exception {
  String? message;

  NotSuccessException.fromRespData(BaseResponseData respData) {
    message = respData.message;
  }

  @override
  String toString() {
    return 'NotExpectedException{message: $message}';
  }
}
