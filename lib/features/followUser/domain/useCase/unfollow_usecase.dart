import 'package:login_token_app/features/followUser/domain/entity/follow_entity.dart';
import 'package:login_token_app/features/followUser/domain/repository/followUser_repository.dart';

class UnfollowFollowUsecase {
  final FollowuserRepository followuserRepository;

  UnfollowFollowUsecase({required this.followuserRepository});

  Future<void> call({
    required FollowEntity currentUser,
    required FollowEntity followUser,
  }) async {
    await followuserRepository.unfollowUSer(
      currentUser: currentUser,
      followUser: followUser,
    );
  }
}
