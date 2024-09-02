import 'package:login_token_app/features/userManagement/domain/repository/user_management_repository.dart';

class GetAllProfileUsecase {
  final UserManagementRepository userManagementRepository;

  GetAllProfileUsecase({required this.userManagementRepository});

  Future<void> call() async {
    await userManagementRepository.getAllProfile();
  }
}
