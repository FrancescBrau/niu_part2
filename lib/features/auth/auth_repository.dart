import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final SharedPreferences _prefs;

  AuthRepository(this._prefs);

  Future<bool> authenticate(String email) async {
    final storedEmail = _prefs.getString('email');
    return storedEmail != null && storedEmail == email;
  }

  Future<bool> createUser(String email) async {
    final exists = _prefs.containsKey('email');
    if (exists) return false;

    await _prefs.setString('email', email);
    return true;
  }
}
