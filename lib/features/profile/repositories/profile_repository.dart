import 'package:niu_part2/features/profile/models/user_model.dart';

abstract class ProfileRepository {
  Future<void> saveUserProfile(UserProfile profile);
  Future<UserProfile?> loadUserProfile();
  Future<void> deleteUserProfile();
}
