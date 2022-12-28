import 'package:domain/models/models.dart';
import '../../api_client/api_client.dart';
import '../../api_client/response_type/response_type.dart';
import '../request/sessions_request.dart';

class SessionsService {
  SessionsService(this.restApiClient);

  final APIClient restApiClient;

  Future<ObjectResponse<LoginModel>> loginWithEmail({
    required String? email,
    required String? password,
  }) async {
    final request = SessionsRequest.loginWithEmail(email: email, password: password);
    final response = await restApiClient.execute(request: request);
    final object = LoginModel.fromJson(response.data);
    return ObjectResponse(object: object);
  }

  Future<ObjectResponse<LoginModel>> refreshToken({
    String? refreshToken,
  }) async {
    final request = SessionsRequest.refreshToken(refreshToken: refreshToken);
    final response = await restApiClient.execute(request: request);
    final object = LoginModel.fromJson(response.data);
    return ObjectResponse(object: object);
  }
}
