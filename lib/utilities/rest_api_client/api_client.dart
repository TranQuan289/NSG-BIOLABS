import 'package:api/api.dart';
import 'package:dio/dio.dart';

import 'api_interceptor.dart';

class RestAPIClient extends APIClient {
  RestAPIClient._();
  static final RestAPIClient _instance = RestAPIClient._();
  factory RestAPIClient() => _instance;
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: BaseURLs.development.schemes + BaseURLs.development.basePath,
    ),
  )..interceptors.add(APIInterceptor());

  @override
  Future<APIResponse> execute({required APIRequest request}) async {
    try {
      final options = Options(
        method: request.method.value,
        headers: request.headers,
        contentType: request.contentType,
      );
      Response response = await dio.request(
        request.path,
        options: options,
        queryParameters: request.parameters,
        data: request.body,
      );
      return APIResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw e.response?.data['message'] ?? '';
      // if (e.type == DioErrorType.response) {
      //   log('Cannot get data from server');
      // }
      // if (e.type == DioErrorType.connectTimeout) {
      //   log('Check your connection');
      // }
      // if (e.type == DioErrorType.receiveTimeout) {
      //   log('Unable to connect to the server');
      // }
      // if (e.type == DioErrorType.other) {
      //   log('Something were wrong');
      // }
    } catch (e) {
      rethrow;
    }
  }
}
