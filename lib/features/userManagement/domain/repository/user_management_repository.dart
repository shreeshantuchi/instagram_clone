import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

abstract class UserManagementRepository {
  Future<ProfileEntity> getCurrentUSer();
  Future<void> setProfile();
  Future<void> getAllProfile();
  Future<List<ProfileEntity>> searchProfile(String search);
  Future<ProfileEntity> getProfile(String uid);
}
