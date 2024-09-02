import 'package:login_token_app/features/followUser/domain/entity/follow_entity.dart';
import 'package:login_token_app/features/followUser/domain/repository/followUser_repository.dart';

class AddFollowUsecase {
  final FollowuserRepository followuserRepository;

  AddFollowUsecase({required this.followuserRepository});

  Future<void> call({
    required FollowEntity currentUser,
    required FollowEntity followUser,
  }) async {
    await followuserRepository.followUser(
        currentUser: currentUser, followUser: followUser);
  }
}
