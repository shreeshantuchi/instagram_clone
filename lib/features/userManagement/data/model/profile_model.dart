import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel(
      {required super.email,
      required super.username,
      required super.emailVerified,
      required super.photoUrl,
      required super.uid,
      required super.followerCount,
      required super.postCount,
      required super.followingCount});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json["email"],
      username: json["username"],
      emailVerified: json["emailVerified"],
      photoUrl: json["photoUrl"],
      uid: json["uid"],
      followerCount: json["followerCount"],
      postCount: json["postCount"],
      followingCount: json["followingCount"],
    );
  }

  factory ProfileModel.fromFirebaseUser(User user) {
    return ProfileModel(
      email: user.email ?? "",
      username: user.displayName ?? "",
      emailVerified: user.emailVerified,
      photoUrl: user.photoURL ?? "",
      uid: user.uid,
      followerCount: 0,
      postCount: 0,
      followingCount: 0,
    );
  }

  factory ProfileModel.fromProfileEntity(ProfileEntity user) {
    return ProfileModel(
      email: user.email,
      username: user.username,
      emailVerified: user.emailVerified,
      photoUrl: user.photoUrl,
      uid: user.uid,
      followerCount: user.followerCount,
      postCount: user.postCount,
      followingCount: user.followerCount,
    );
  }

  factory ProfileModel.fromUserEntity(UserEntity user) {
    return ProfileModel(
      email: user.email,
      username: "",
      emailVerified: false,
      photoUrl: "",
      uid: user.uid,
      followerCount: 0,
      postCount: 0,
      followingCount: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "username": username,
      "emailVerified": emailVerified,
      "photoUrl": photoUrl,
      "uid": uid,
      "followerCount": followerCount,
      "followingCount": followingCount,
      "postCount": postCount,
    };
  }
}
