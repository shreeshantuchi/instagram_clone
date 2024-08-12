import 'package:login_token_app/core/services/ApiService/api_service.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/features/authentication/data/datasourse/auth_remote_repository.dart';
import 'package:login_token_app/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:login_token_app/features/authentication/domain/usecase/login_use_cases.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';

Future<AuthBloc> createAuthBloc() async {
  final sharedPreferences = SharedPreferencesService();
  final apiService = ApiService();
  final remoteDataSource = AuthDataSourceImpl(
      apiService: apiService, sharedPreferencesService: sharedPreferences);
  //final localDataSource = FeedLocalDataSourceImpl();

  final remoteRepository = AuthRepositoryImpl(dataSource: remoteDataSource);
  // final localRepository =
  //     FeedLocalRepositoryImpl(localDataSource: localDataSource);

  final loginUseCase = LoginUseCase(repository: remoteRepository);
  final storedTokenUSecase =
      GetStoredTokensUseCase(repository: remoteRepository);
  final signOutUseCase = SignOutUseCase(repository: remoteRepository);

  // localRepository: localRepository,
  // isConnected: isConnected,

  return AuthBloc(
      loginUseCase: loginUseCase,
      signOutUseCase: signOutUseCase,
      getStoredTokensUseCase: storedTokenUSecase);
}
