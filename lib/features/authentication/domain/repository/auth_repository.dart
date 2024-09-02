import 'package:login_token_app/features/authentication/data/models/auth_token_model.dart';
import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

abstract class AuthRepository {
  Future<AuthTokenModel?> login(Map<String, dynamic> data);
  Future<AuthTokenModel?> getStoredTokens();
  Future<void> signOut();
}

abstract class FirebaseAuthRepository {
  Future<UserEntity> firebaseLogin(String email, String password);
  Future<UserEntity> firebaseSignup(String email, String password);
  Future<void> signOut();
  UserEntity getCurrentUser();
}
