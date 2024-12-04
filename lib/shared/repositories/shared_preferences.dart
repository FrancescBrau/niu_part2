import 'package:shared_preferences/shared_preferences.dart';
import 'database_repository.dart';

class SharedPreferencesRepository extends DatabaseRepository {
  final SharedPreferences _prefs;

  SharedPreferencesRepository(this._prefs);

  Future<void> saveUser(
      {required String email, String? phone, String? address}) async {
    await _prefs.setString('email', email);
    if (phone != null) await _prefs.setString('phone', phone);
    if (address != null) await _prefs.setString('address', address);
  }

  Future<Map<String, String?>> getUser() async {
    return {
      'email': _prefs.getString('email'),
      'phone': _prefs.getString('phone'),
      'address': _prefs.getString('address'),
    };
  }

  // Elimina los datos de usuario
  Future<void> deleteUser() async {
    await _prefs.remove('email');
    await _prefs.remove('phone');
    await _prefs.remove('address');
  }

  // Comprueba si un usuario está registrado
  Future<bool> isUserRegistered() async {
    return _prefs.containsKey('email');
  }

  @override
  Future<void> save(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<String?> load(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> delete(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<bool> contains(String key) async {
    return _prefs.containsKey(key);
  }
}
