import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  final SharedPreferences _sharedPreferences;
  SharedPreferencesServices._(this._sharedPreferences);

  static const String _isloggedInKey = 'is_logged_in';
  Future<void> setLoggedIn(bool value) async {
    await _sharedPreferences.setBool(_isloggedInKey, value);
  }

  bool isLoggedIn() {
    return _sharedPreferences.getBool(_isloggedInKey) ?? false;
  }

  Future<void> clearAuthData() async {
    await _sharedPreferences.remove(_isloggedInKey);
  }

  static SharedPreferencesServices init(SharedPreferences sharedPreferences) {
    return SharedPreferencesServices._(sharedPreferences);
  }
}
