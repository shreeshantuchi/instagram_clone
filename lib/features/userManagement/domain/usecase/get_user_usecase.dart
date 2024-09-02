import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:login_token_app/features/userManagement/domain/repository/user_management_repository.dart';

class GetProfileUsecase {
  final UserManagementRepository userManagementRepository;

  GetProfileUsecase({required this.userManagementRepository});
  Future<ProfileEntity> call(String uid) async {
    final profile = await userManagementRepository.getProfile(uid);
    return profile;
  }
}
