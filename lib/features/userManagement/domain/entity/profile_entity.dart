import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';

class ProfileEntity {
  final String email;
  String username;
  final bool emailVerified;
  final String? photoUrl;
  final String uid;
  final int followerCount;
  final int postCount;
  final int followingCount;

  ProfileEntity({
    required this.followerCount,
    required this.postCount,
    required this.followingCount,
    required this.email,
    required this.username,
    required this.emailVerified,
    required this.photoUrl,
    required this.uid,
  });

  factory ProfileEntity.fromProfileModel(ProfileModel userModel) {
    return ProfileEntity(
        email: userModel.email,
        username: userModel.username,
        emailVerified: userModel.emailVerified,
        photoUrl: userModel.photoUrl,
        uid: userModel.uid,
        followerCount: userModel.followerCount,
        postCount: userModel.postCount,
        followingCount: userModel.followingCount);
  }
}
