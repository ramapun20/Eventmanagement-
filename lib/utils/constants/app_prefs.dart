import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  SharedPreferences _sharedPreferences;
  AppPreference(this._sharedPreferences);

  Future<String?> getAccessToken() async {
    String? accessToken = _sharedPreferences.getString("accessToken");
    return accessToken;
  }

  Future<void> saveAccessToken(String accessToken) async {
    _sharedPreferences.setString("accessToken", accessToken);
  }

  Future<String?> getUser() async {
    String? name = _sharedPreferences.getString("user");
    return name;
  }

  Future<void> saveUser(String name) async {
    _sharedPreferences.setString("user", name);
  }

  Future<void> clear() async {
    _sharedPreferences.clear();
  }
}
