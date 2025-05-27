import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasorce {
  void saveAccessToken(String x) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', x);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? toke = prefs.getString('accessToken');
    return toke;
  }

  void saveRefreshToken(String x) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', x);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? toke = prefs.getString('refreshToken');
    return toke;
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
