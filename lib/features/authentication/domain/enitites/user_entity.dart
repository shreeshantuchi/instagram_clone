import 'package:login_token_app/features/authentication/data/models/user_model.dart';

class UserEntity {
  final String email;
  final String username;
  final bool emailVerified;
  final String photoUrl;
  final String uid;

  UserEntity({
    required this.email,
    required this.username,
    required this.emailVerified,
    required this.photoUrl,
    required this.uid,
  });

  factory UserEntity.fromUserModel(UserModel userModel) {
    return UserEntity(
        email: userModel.email,
        username: userModel.email,
        emailVerified: userModel.emailVerified,
        photoUrl: userModel.photoUrl,
        uid: userModel.uid);
  }
}
