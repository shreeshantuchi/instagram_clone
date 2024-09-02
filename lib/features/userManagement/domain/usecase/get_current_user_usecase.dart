import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:login_token_app/features/userManagement/domain/repository/user_management_repository.dart';

class GetCurrentUserUsecase {
  final UserManagementRepository userManagementRepository;

  GetCurrentUserUsecase({required this.userManagementRepository});

  Future<ProfileEntity> call() async {
    return await userManagementRepository.getCurrentUSer();
  }
}
