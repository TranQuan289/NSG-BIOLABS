import 'http_method.dart';

class APIRequest {
  APIRequest({
    required this.method,
    required this.path,
    this.parameters,
    this.body,
    this.headers,
    this.contentType,
  });

  HTTPMethod method;
  String path;
  dynamic parameters;
  dynamic body;
  dynamic headers;
  dynamic contentType;
}
