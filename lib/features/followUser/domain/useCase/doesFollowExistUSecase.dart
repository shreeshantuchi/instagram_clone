import 'package:login_token_app/features/followUser/domain/entity/follow_entity.dart';
import 'package:login_token_app/features/followUser/domain/repository/followUser_repository.dart';

class Doesfollowexistusecase {
  final FollowuserRepository followuserRepository;

  Doesfollowexistusecase({required this.followuserRepository});

  Future<bool> call({
    required String currentUserId,
    required String followUserId,
  }) async {
    final isFollowed = await followuserRepository.doesFollowerExist(
        userId: currentUserId, followerId: followUserId);
    return isFollowed;
  }
}
