import 'package:api/users/request/users_request.dart';
import 'package:domain/models/models.dart';

import '../../api_client/api_client.dart';
import '../../api_client/response_type/response_type.dart';

class UsersService {
  UsersService(this.restApiClient);
  final APIClient restApiClient;
  Future<ObjectResponse<ForgotPasswordModel>> forgotPassword({String? email}) async {
    final request = UsersRequest.forgotPassword(email: email);
    final response = await restApiClient.execute(request: request);
    return ObjectResponse(object: ForgotPasswordModel.fromJson(response.data ?? {'': ''}));
  }

  Future<ObjectResponse<ProfileModel>> getProfile() async {
    final request = UsersRequest.getProfile();
    final response = await restApiClient.execute(request: request);
    return ObjectResponse(object: ProfileModel.fromJson(response.data));
  }

  Future<ObjectResponse<ProfileModel>> changeProfile(
      String? fullName, String? role, String phoneNumber) async {
    final request = UsersRequest.changeProfile(fullName, role, phoneNumber);
    final response = await restApiClient.execute(request: request);
    return ObjectResponse(object: ProfileModel.fromJson(response.data));
  }

  Future<ObjectResponse<UpdatePasswordModel>> updatePassword({String? currentPassword, String? newPassword, String? newPasswordConfirmation}) async {
    final request = UsersRequest.updatePassword(currentPassword: currentPassword, newPassword: newPassword, newPasswordConfirmation: newPasswordConfirmation);
    final response = await restApiClient.execute(request: request);
    return ObjectResponse(object: UpdatePasswordModel.fromJson(response.data ?? {'': ''}));
  }
}
