import 'package:login_token_app/features/userManagement/data/datasource/fireabse_usermanagement_datasource.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:login_token_app/features/userManagement/domain/repository/user_management_repository.dart';

class UserManagementRepositoryImp implements UserManagementRepository {
  final FireabseUsermanagementDatasource dataSource;

  UserManagementRepositoryImp({required this.dataSource});
  @override
  Future<ProfileEntity> getCurrentUSer() async {
    final profileModel = await dataSource.getCurrentUser();
    final profileEntity = ProfileEntity.fromProfileModel(profileModel);
    return profileEntity;
  }

  @override
  Future<void> setProfile() async {
    await dataSource.setProfile();
  }

  @override
  Future<List<ProfileEntity>> searchProfile(String search) async {
    await dataSource.getAllUser();
    final profileList = dataSource.profileModelList;
    print(profileList);

    final filteredList = profileList.where((profile) {
      final matchesEmail = profile.email.contains(search);
      final matchesUsername = profile.username.contains(search);

      return matchesEmail || matchesUsername;
    }).toList();
    return filteredList.map((element) {
      return ProfileEntity.fromProfileModel(element);
    }).toList();
  }

  @override
  Future<void> getAllProfile() async {
    await dataSource.getAllUser();
  }

  @override
  Future<ProfileEntity> getProfile(String uid) async {
    final profile = await dataSource.getProfile(uid);
    return profile;
  }
}
