import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('userToken');
  return token;
}

Future<String?> getTokenExpiredAt() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('tokenExpired');
  return token;
}

Future setToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userToken', token);
}

Future settokenExpired(String tokenExpired) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('tokenExpired', tokenExpired);
}

Future clearToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
