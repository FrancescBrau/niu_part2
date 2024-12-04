import 'package:niu_part2/features/profile/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_repository.dart';

class ProfileSharedPreferences implements ProfileRepository {
  final SharedPreferences _prefs;

  ProfileSharedPreferences(this._prefs);

  @override
  Future<void> saveUserProfile(UserProfile profile) async {
    await _prefs.setString('email', profile.email);
    await _prefs.setString('phone', profile.phone);
    await _prefs.setString('address', profile.address);
  }

  @override
  Future<UserProfile?> loadUserProfile() async {
    String? email = _prefs.getString('email');
    String? phone = _prefs.getString('phone');
    String? address = _prefs.getString('address');

    if (email != null && phone != null && address != null) {
      return UserProfile(
        email: email,
        phone: phone,
        address: address,
      );
    }
    return null;
  }

  @override
  Future<void> deleteUserProfile() async {
    await _prefs.remove('email');
    await _prefs.remove('phone');
    await _prefs.remove('address');
  }
}
