import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogUtil {
  static final Logger _logger = Logger(
    filter: CustomFilter(),
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
    ),
  );

  /// 日志形式输出
  static print(String content) {
    _logger.d(content);
  }
}

class CustomFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}
