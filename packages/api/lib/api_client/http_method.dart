class HTTPMethod {
  final String value;
  const HTTPMethod._(this.value);
}

class HTTPMethods {
  HTTPMethods._();
  static const get = HTTPMethod._('GET');
  static const post = HTTPMethod._('POST');
  static const put = HTTPMethod._('PUT');
  static const delete = HTTPMethod._('DELETE');
}
