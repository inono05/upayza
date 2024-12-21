import 'package:shared_preferences/shared_preferences.dart';
import 'package:upayza/src/core/models/user.dart';

class AppUserPreferences {
  static AppUserPreferences? _instance;
  static SharedPreferences? _prefs;

  factory AppUserPreferences() {
    if (_instance == null) {
      throw Exception('AppUserTokenPreferences is not initialized. '
          'Please call AppUserTokenPreferences.ensureInitialized before.');
    }
    return _instance!;
  }

  const AppUserPreferences._();

  static ensureInitialized() async {
    _prefs ??= await SharedPreferences.getInstance();
    _instance ??= const AppUserPreferences._();
  }

  static const _tokenKey = 'token';
  static const _userId = 'id';
  static const _countryId = 'countryId';
  static const _user = 'user';

  Future<void> saveToken(String token) async {
    await _prefs!.setString(_tokenKey, token);
  }

  String? token() {
    return (_prefs!.getString(_tokenKey) != null)
        ? "Bearer ${_prefs!.getString(_tokenKey)}"
        : null;
  }

  Future<void> saveUserID(int id) async {
    await _prefs!.setInt(_userId, id);
  }

  int? userId() {
    return (_prefs!.getInt(_userId) != null) ? _prefs!.getInt(_userId) : null;
  }

  Future<void> saveCountryId(int countryId) async {
    await _prefs!.setInt(_countryId, countryId);
  }

  int? countryId() {
    return (_prefs!.getInt(_countryId) != null) ? _prefs!.getInt(_countryId) : null;
  }

  Future<void> storeUser(User user) async {
    String userJson = user.toRawJson();
    await _prefs!.setString(_user, userJson);
  }

  User? getUser() {
    final userFromString = _prefs!.getString(_user);
    if (userFromString != null) {
      return User.fromRawJson(userFromString);
    }
    return null;
  }


  Future<bool> clear() {
    return _prefs!.clear();
  }
}
