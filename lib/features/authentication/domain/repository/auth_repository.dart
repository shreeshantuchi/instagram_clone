import 'package:login_token_app/features/authentication/data/models/auth_token_model.dart';

abstract class AuthRepository {
  Future<AuthTokenModel?> login(Map<String, dynamic> data);
  Future<AuthTokenModel?> getStoredTokens();
  Future<void> signOut();
}
