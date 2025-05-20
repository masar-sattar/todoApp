import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasorce {
  void saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? toke = prefs.getString('token');
    return toke;
  }
}
