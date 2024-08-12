import 'package:login_token_app/features/authentication/data/models/auth_token_model.dart';
import 'package:login_token_app/features/authentication/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<AuthTokenModel?> call(Map<String, dynamic> data) async {
    return await repository.login(data);
  }
}

class GetStoredTokensUseCase {
  final AuthRepository repository;

  GetStoredTokensUseCase({required this.repository});

  Future<AuthTokenModel?> call() async {
    return await repository.getStoredTokens();
  }
}

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}
