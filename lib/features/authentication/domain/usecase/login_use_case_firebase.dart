import 'package:login_token_app/features/authentication/data/models/auth_token_model.dart';
import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:login_token_app/features/authentication/domain/repository/auth_repository.dart';

class FirebaseLoginUseCase {
  final FirebaseAuthRepository repository;

  FirebaseLoginUseCase({required this.repository});

  Future<UserEntity> call(String email, String password) async {
    return await repository.firebaseLogin(email, password);
  }
}

class FirebaseSignUpUseCase {
  final FirebaseAuthRepository repository;

  FirebaseSignUpUseCase({required this.repository});

  Future<UserEntity> call(String email, String password) async {
    return await repository.firebaseSignup(email, password);
  }
}

class FirebaseSignOutUseCase {
  final FirebaseAuthRepository repository;

  FirebaseSignOutUseCase({required this.repository});

  Future<void> call() async {
    await repository.signOut();
  }
}

class FirebaseCurrentUserUseCase {
  final FirebaseAuthRepository repository;

  FirebaseCurrentUserUseCase({required this.repository});

  UserEntity call() {
    final user = repository.getCurrentUser();
    return user;
  }
}
