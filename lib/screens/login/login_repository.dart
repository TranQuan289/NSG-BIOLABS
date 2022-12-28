import 'package:api/api_client/response_type/response_type.dart';
import 'package:domain/domain.dart';
import 'package:api/sessions/service/sessions_service.dart';

import '../../utilities/rest_api_client/api_client.dart';
class LoginRepository {
  LoginRepository(this.restApiClient);
  final RestAPIClient restApiClient;

  Future<ObjectResponse<LoginModel>> loginWithEmail({
    required String? email,
    required String? password,
  }) {
    return SessionsService(restApiClient).loginWithEmail(email: email, password: password);
  }
}
