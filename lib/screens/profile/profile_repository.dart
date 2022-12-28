
import 'package:api/api_client/response_type/response_type.dart';
import 'package:domain/domain.dart';
import 'package:api/users/service/users_service.dart';

import '../../utilities/rest_api_client/api_client.dart';

class ProfileReponstory {
  ProfileReponstory(this.restApiClient);
  final RestAPIClient restApiClient;
  Future<ObjectResponse<ProfileModel>> getProfile() {
    return UsersService(restApiClient).getProfile();
  }

  Future<ObjectResponse<ProfileModel>> changeProfile(
       String? fullName, String? role,String phoneNumber) {
    return UsersService(restApiClient)
        .changeProfile( fullName, role, phoneNumber);
  }
}
