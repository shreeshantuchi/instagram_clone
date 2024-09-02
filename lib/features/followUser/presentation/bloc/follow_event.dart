import 'package:login_token_app/features/followUser/domain/entity/follow_entity.dart';

abstract class FollowEvent {}

class AddFollowEvent extends FollowEvent {
  final FollowEntity followUser;
  final FollowEntity currentUser;

  AddFollowEvent({required this.followUser, required this.currentUser});
}

class UnFollowEvent extends FollowEvent {
  final FollowEntity unFollowUser;
  final FollowEntity currentUser;

  UnFollowEvent({
    required this.unFollowUser,
    required this.currentUser,
  });
}

class DoesFollowExistevent extends FollowEvent {
  final FollowEntity followUser;
  final FollowEntity currentUser;

  DoesFollowExistevent({
    required this.followUser,
    required this.currentUser,
  });
}

class InititalizeEvenet extends FollowEvent {
  InititalizeEvenet();
}
