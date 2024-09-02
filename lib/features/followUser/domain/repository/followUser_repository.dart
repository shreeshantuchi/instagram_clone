import 'package:login_token_app/features/followUser/domain/entity/follow_entity.dart';

abstract class FollowuserRepository {
  Future<void> followUser(
      {required FollowEntity currentUser, required FollowEntity followUser});
  Future<void> unfollowUSer(
      {required FollowEntity currentUser, required FollowEntity followUser});
  Future<bool> doesFollowerExist(
      {required String userId, required String followerId});
}
