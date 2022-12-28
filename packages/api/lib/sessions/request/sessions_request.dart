import 'package:api/api_client/http_method.dart';
import 'package:dio/dio.dart';

import '../../api_client/api_request.dart';

class SessionsRequest {
  SessionsRequest._();

  static APIRequest loginWithEmail({required String? email, required String? password}) {
    return APIRequest(
      method: HTTPMethods.post,
      path: '/sessions/authorize',
      body: FormData.fromMap({'email': email, 'password': password}),
    );
  }

  static APIRequest refreshToken({String? refreshToken}) {
    return APIRequest(
      method: HTTPMethods.post,
      path: '/sessions/refresh_token',
      body: {
        'refresh_token': refreshToken,
      },
    );
  }
}
