abstract class FollowState {}

class FollowInitialState extends FollowState {}

class FollowUserState extends FollowState {}

class UnFollowUserState extends FollowState {}

class FollowExistState extends FollowState {
  final bool isFollowed;

  FollowExistState({required this.isFollowed});
}
