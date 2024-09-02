import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      uid: json["uid"],
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      email: user.email ?? "",
      uid: user.uid,
    );
  }

  factory UserModel.fromUserEntity(UserEntity user) {
    return UserModel(
      email: user.email,
      uid: user.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "uid": uid,
    };
  }
}
