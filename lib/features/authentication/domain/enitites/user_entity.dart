import 'package:login_token_app/features/authentication/data/models/user.dart';

class UserEntity {
  final String email;

  final String uid;

  UserEntity({
    required this.email,
    required this.uid,
  });

  factory UserEntity.fromUserModel(UserModel userModel) {
    return UserEntity(email: userModel.email, uid: userModel.uid);
  }
}
