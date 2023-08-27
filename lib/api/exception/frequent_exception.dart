///频繁请求的异常。
///场景：频繁请求验证码时，接口会返回null，此时在onResponse中抛出。
class FrequentExcption implements Exception {
  const FrequentExcption();

  @override
  String toString() {
    return 'FrequentExcption';
  }
}
