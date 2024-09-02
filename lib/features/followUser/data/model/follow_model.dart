import 'package:login_token_app/features/followUser/domain/entity/follow_entity.dart';

class FollowModel extends FollowEntity {
  FollowModel(
      {required super.email,
      required super.uid,
      required super.imgUrl,
      required super.displayName});

  factory FollowModel.fromJson(Map<String, dynamic> json) {
    return FollowModel(
      email: json["email"],
      uid: json["uid"],
      imgUrl: json["photoUrl"],
      displayName: 'displayName',
    );
  }

  factory FollowModel.fromFollowEntity(FollowEntity follow) {
    return FollowModel(
      email: follow.email,
      uid: follow.uid,
      imgUrl: follow.imgUrl,
      displayName: follow.displayName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "uid": uid,
      "photoUrl": imgUrl,
      "displayName": displayName,
    };
  }
}
