import 'dart:developer';

import 'package:api/api_client/api_response.dart';
import 'package:api/sessions/request/sessions_request.dart';
import 'package:codebase/utilities/rest_api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:domain/models/sessions/login_model.dart';

import '../shared_preferences/shared_preferences.dart';

class APIInterceptor extends QueuedInterceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await getToken();
    options.headers.addAll({'Authorization': token});
    if (token != null) {
      final String? tokenExpiredAt = await getTokenExpiredAt();
      if (tokenExpiredAt != null) {
        final DateTime timeExpired = DateTime.parse(
            '${tokenExpiredAt.substring(0, 10)} ${tokenExpiredAt.substring(11, 23)}');
        final DateTime dateTimeNow = DateTime.now();

        if (timeExpired.compareTo(dateTimeNow) > 0) {
          try {
            final accessToken = await getToken();
            final request = SessionsRequest.refreshToken(refreshToken: accessToken);
            final baseUrl = RestAPIClient().dio.options.baseUrl;
            final dio = Dio(BaseOptions(baseUrl: baseUrl));
            final response = await dio.request(
              request.path,
              queryParameters: request.parameters,
              data: request.body,
              options: Options(
                method: request.method.value,
                contentType: Headers.jsonContentType,
              ),
            );
            final apiResponse = APIResponse.fromJson(response.data);
            final object = LoginModel.fromJson(apiResponse.data);

            await setToken(object.token?? '');
          } catch (e) {
            log('token refesh failed!');
          }
          final String? accessToken = await getToken();
          options.headers.addAll({'Authorization': accessToken});
        }
      }
    }
    log('=> REQUEST METHOD: ${options.method}');
    log('=> PATH: ${options.baseUrl}${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('=> RESPONSE CODE: ${response.statusCode}');
    log('=> PATH: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
    log('=> RESPONSE DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('=> ERROR ${err.response?.statusCode}');
    log('=> PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
