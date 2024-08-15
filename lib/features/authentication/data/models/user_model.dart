import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.email,
      required super.username,
      required super.emailVerified,
      required super.photoUrl,
      required super.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      username: json["username"],
      emailVerified: json["emailVerified"],
      photoUrl: json["photoUrl"],
      uid: json["uid"],
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      email: user.email ?? "",
      username: user.displayName ?? "",
      emailVerified: user.emailVerified,
      photoUrl: user.photoURL ?? "",
      uid: user.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "username": username,
      "emailVerified": emailVerified,
      "photoUrl": photoUrl,
      "uid": uid,
    };
  }
}
