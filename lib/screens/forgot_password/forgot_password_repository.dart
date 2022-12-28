
import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/users/service/users_service.dart';
import 'package:domain/domain.dart';

import '../../utilities/rest_api_client/api_client.dart';



class ForgotPasswordRepository {
  ForgotPasswordRepository(this.restApiClient);
  final RestAPIClient restApiClient;

  Future<ObjectResponse<ForgotPasswordModel>> forgotPassword({
    String? email,
  }) {
    return UsersService(restApiClient).forgotPassword(email: email);
  }
}
