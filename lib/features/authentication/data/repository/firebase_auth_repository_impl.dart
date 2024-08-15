import 'package:login_token_app/features/authentication/data/datasourse/firebase_data_source.dart';
import 'package:login_token_app/features/authentication/data/models/user_model.dart';
import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/authentication/domain/repository/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAUthDataSource firebaseAUthDataSource;

  FirebaseAuthRepositoryImpl({required this.firebaseAUthDataSource});
  @override
  Future<UserEntity> firebaseLogin(String email, String password) async {
    final userModel = await firebaseAUthDataSource.login(email, password);
    return UserEntity(
      email: userModel.email,
      username: userModel.username,
      emailVerified: userModel.emailVerified,
      photoUrl: userModel.photoUrl,
      uid: userModel.uid,
    );
  }

  @override
  Future<UserEntity> firebaseSignup(String email, String password) async {
    final userModel = await firebaseAUthDataSource.signUp(email, password);
    return UserEntity(
      email: userModel.email,
      username: userModel.username,
      emailVerified: userModel.emailVerified,
      photoUrl: userModel.photoUrl,
      uid: userModel.uid,
    );
  }

  @override
  Future<void> signOut() async {
    await firebaseAUthDataSource.signout();
  }

  @override
  UserEntity getCurrentUser() {
    final userModel = firebaseAUthDataSource.getCurrentUser();
    return UserEntity.fromUserModel(userModel);

    throw UnimplementedError();
  }
}
