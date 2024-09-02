import 'package:flutter/foundation.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

@immutable
abstract class UserManagementState {
  final ProfileEntity? profie;
  const UserManagementState({this.profie});
}

class InitialState extends UserManagementState {
  const InitialState() : super();
}

class UserLoadingState extends UserManagementState {}

class OnAllUserRetrivedState extends UserManagementState {}

class OnProfileAddedState extends UserManagementState {}

class OnAllProfileReceivedState extends UserManagementState {}

class OnUserRetrivedFailureState extends UserManagementState {}

class OnSearchProfileRetrivedState extends UserManagementState {
  final List<ProfileEntity> profileList;

  const OnSearchProfileRetrivedState({required this.profileList});
}

class OnCurrentUserProfileRetrivedState extends UserManagementState {
  final ProfileEntity profile;

  const OnCurrentUserProfileRetrivedState({required this.profile})
      : super(profie: profile);
}

class OnUserProfileRetrivedState extends UserManagementState {
  final ProfileEntity profile;

  const OnUserProfileRetrivedState({required this.profile});
}
