import 'package:login_token_app/features/authentication/data/datasourse/auth_remote_repository.dart';
import 'package:login_token_app/features/authentication/data/models/auth_token_model.dart';
import 'package:login_token_app/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<AuthTokenModel?> getStoredTokens() async {
    return await dataSource.getLastAuthToken();
  }

  @override
  Future<void> signOut() async {
    await dataSource.clearAuthToken();
  }

  @override
  Future<AuthTokenModel?> login(Map<String, dynamic> data) async {
    return await dataSource.login(data);
  }
}
