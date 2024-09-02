import 'package:login_token_app/features/userManagement/data/datasource/fireabse_usermanagement_datasource.dart';
import 'package:login_token_app/features/userManagement/data/repository/user_management_repository_imp.dart';
import 'package:login_token_app/features/userManagement/domain/usecase/get_all_profile_usecase.dart';
import 'package:login_token_app/features/userManagement/domain/usecase/get_current_user_usecase.dart';
import 'package:login_token_app/features/userManagement/domain/usecase/get_user_usecase.dart';
import 'package:login_token_app/features/userManagement/domain/usecase/search_profile_usecase.dart';
import 'package:login_token_app/features/userManagement/domain/usecase/set_profile_usecase.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';

Future<UserManagementBloc> createUserManagementBloc() async {
  final userManagementDatasource = FireBaseUserManagementDatasourceImpl();

  final userManagementRepository =
      UserManagementRepositoryImp(dataSource: userManagementDatasource);

  final getCurrentUserUsecase =
      GetCurrentUserUsecase(userManagementRepository: userManagementRepository);
  final setProfileUsecase =
      SetProfileUsecase(userManagementRepository: userManagementRepository);
  final searchProfileUsecase =
      SearchProfileUsecase(userManagementRepository: userManagementRepository);
  final getAllProfileUsecase =
      GetAllProfileUsecase(userManagementRepository: userManagementRepository);
  final getProfileUsecase =
      GetProfileUsecase(userManagementRepository: userManagementRepository);

  // localRepository: localRepository,
  // isConnected: isConnected,

  return UserManagementBloc(
      getProfileUsecase: getProfileUsecase,
      getAllProfileUsecase: getAllProfileUsecase,
      searchProfileUsecase: searchProfileUsecase,
      getCurrentUserUsecase: getCurrentUserUsecase,
      setProfileUsecase: setProfileUsecase);
}
