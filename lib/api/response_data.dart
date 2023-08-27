import 'base_response_data.dart';

class ResponseData extends BaseResponseData {
  ResponseData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['status_message'];
    code = json['status_code'];
  }
}
