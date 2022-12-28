class LoginModel {
  LoginModel({
    this.token,
    this.tokenExpiredAt,
  });

  String? token;
  String? tokenExpiredAt;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json['token'],
        tokenExpiredAt: json['token_expired_at'],
      );
}