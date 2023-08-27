/// token过期或无效,需要跳转到登录页
class LostTokenException implements Exception {
  const LostTokenException();
  @override
  String toString() {
    return 'LostTokenException';
  }
}
