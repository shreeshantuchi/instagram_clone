import 'package:login_token_app/features/followUser/data/model/follow_model.dart';
import 'package:login_token_app/features/followUser/domain/entity/follow_entity.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:login_token_app/features/followUser/data/dataSource/follower_datasource.dart';
import 'package:login_token_app/features/followUser/domain/repository/followUser_repository.dart';

class FollowuserRepositoryImpl implements FollowuserRepository {
  final FollowUserDataSource followUserDataSource;

  FollowuserRepositoryImpl({required this.followUserDataSource});
  @override
  Future<void> followUser(
      {required FollowEntity currentUser,
      required FollowEntity followUser}) async {
    await followUserDataSource.followUser(
        user: FollowModel.fromFollowEntity(currentUser),
        userFollow: FollowModel.fromFollowEntity(followUser));
  }

  @override
  Future<void> unfollowUSer(
      {required FollowEntity currentUser,
      required FollowEntity followUser}) async {
    await followUserDataSource.unfollowUser(
        user: FollowModel.fromFollowEntity(currentUser),
        userFollow: FollowModel.fromFollowEntity(followUser));
  }

  @override
  Future<bool> doesFollowerExist(
      {required String userId, required String followerId}) async {
    final isFollowed =
        await followUserDataSource.doesFollowerExist(userId, followerId);
    return isFollowed;
  }
}
