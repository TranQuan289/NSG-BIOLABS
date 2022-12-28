import 'package:api/api_client/api_request.dart';
import 'package:api/api_client/http_method.dart';
import 'package:dio/dio.dart';

class UsersRequest {
  UsersRequest._();
  static APIRequest forgotPassword({String? email}) {
    return APIRequest(
      method: HTTPMethods.post,
      path: '/users/forgot_password',
      body: {
        'email': email,
      },
    );
  }

  static APIRequest getProfile() {
    return APIRequest(
      method: HTTPMethods.get,
      path: '/users/profile',
      body: {},
    );
  }

  static APIRequest changeProfile(String? fullName, String? role, String? phoneNumber) {
    return APIRequest(
      method: HTTPMethods.put,
      path: '/users',
      body: FormData.fromMap({'full_name': fullName, 'role': role, 'phone_number': phoneNumber}),
    );
  }

  static APIRequest updatePassword(
      {String? currentPassword, String? newPassword, String? newPasswordConfirmation}) {
    return APIRequest(
      method: HTTPMethods.put,
      path: '/users/update_password',
      body: FormData.fromMap({
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation
      }),
    );
  }
}
