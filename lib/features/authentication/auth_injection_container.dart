import 'package:login_token_app/core/services/ApiService/api_service.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/features/authentication/data/datasourse/auth_remote_repository.dart';
import 'package:login_token_app/features/authentication/data/datasourse/firebase_data_source.dart';
import 'package:login_token_app/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:login_token_app/features/authentication/data/repository/firebase_auth_repository_impl.dart';
import 'package:login_token_app/features/authentication/domain/usecase/login_use_case_firebase.dart';
import 'package:login_token_app/features/authentication/domain/usecase/login_use_cases.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';

Future<AuthBloc> createAuthBloc() async {
  // final sharedPreferences = SharedPreferencesService();
  // final apiService = ApiService();
  final firebaseDataSource = FirebaseAUthDataSourceImpl();
  //final localDataSource = FeedLocalDataSourceImpl();

  final firebaseAuthRepository =
      FirebaseAuthRepositoryImpl(firebaseAUthDataSource: firebaseDataSource);
  // final localRepository =
  //     FeedLocalRepositoryImpl(localDataSource: localDataSource);

  final loginUseCase = FirebaseLoginUseCase(repository: firebaseAuthRepository);

  final signupUsecase =
      FirebaseSignUpUseCase(repository: firebaseAuthRepository);
  final getCurrentUserUsercase =
      FirebaseCurrentUserUseCase(repository: firebaseAuthRepository);
  final signoutUserCase =
      FirebaseSignOutUseCase(repository: firebaseAuthRepository);

  // localRepository: localRepository,
  // isConnected: isConnected,

  return AuthBloc(
      signUpUseCase: signupUsecase,
      loginUseCase: loginUseCase,
      getCurrentUserUseCase: getCurrentUserUsercase,
      signOutUseCase: signoutUserCase);
}
