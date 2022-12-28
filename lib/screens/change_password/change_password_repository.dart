import 'package:api/api_client/response_type/response_type.dart';
import 'package:api/users/service/users_service.dart';
import 'package:domain/models/users/update_password_model.dart';

import '../../utilities/rest_api_client/api_client.dart';

class ChangePasswordRepository {
  ChangePasswordRepository(this.restApiClient);
  final RestAPIClient restApiClient;

  Future<ObjectResponse<UpdatePasswordModel>> updatePassword({
    String? currentPassword,
    String? newPassword,
    String? newPasswordConfirmation,
  }) {
    return UsersService(restApiClient).updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation);
  }
}
