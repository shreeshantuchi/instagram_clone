import 'package:login_token_app/features/followUser/data/model/follow_model.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

class FollowEntity {
  final String email;
  final String? imgUrl;
  final String uid;
  final String displayName;

  FollowEntity({
    required this.displayName,
    this.imgUrl,
    required this.email,
    required this.uid,
  });

  factory FollowEntity.fromfollowModel(FollowModel followModel) {
    return FollowEntity(
        email: followModel.email,
        uid: followModel.uid,
        imgUrl: followModel.imgUrl,
        displayName: followModel.displayName);
  }

  factory FollowEntity.fromProfileEntity(ProfileEntity profileEntity) {
    return FollowEntity(
        email: profileEntity.email,
        uid: profileEntity.uid,
        imgUrl: profileEntity.photoUrl,
        displayName: profileEntity.username);
  }
}
