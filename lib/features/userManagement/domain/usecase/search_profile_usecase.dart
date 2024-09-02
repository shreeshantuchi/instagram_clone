import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:login_token_app/features/userManagement/domain/repository/user_management_repository.dart';

class SearchProfileUsecase {
  final UserManagementRepository userManagementRepository;

  SearchProfileUsecase({required this.userManagementRepository});

  Future<List<ProfileEntity>> call(String searchText) async {
    final searchedList =
        await userManagementRepository.searchProfile(searchText);
    return searchedList;
  }
}
