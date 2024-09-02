import 'package:login_token_app/features/followUser/data/model/follow_model.dart';

abstract class FollowUserDataSource {
  Future<void> followUser(
      {required FollowModel user, required FollowModel userFollow});
  Future<void> unfollowUser(
      {required FollowModel user, required FollowModel userFollow});
  Future<bool> doesFollowerExist(String userId, String followerId);
}
