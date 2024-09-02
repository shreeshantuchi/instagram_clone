import 'package:login_token_app/features/userManagement/domain/repository/user_management_repository.dart';

class SetProfileUsecase {
  final UserManagementRepository userManagementRepository;

  SetProfileUsecase({required this.userManagementRepository});

  Future<void> call() async {
    userManagementRepository.setProfile();
  }
}
