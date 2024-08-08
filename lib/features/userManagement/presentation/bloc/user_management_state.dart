import 'package:flutter/foundation.dart';

@immutable
abstract class UserManagementState {
  const UserManagementState();
}

class InitialState extends UserManagementState {
  const InitialState() : super();
}

class UserLoadingState extends UserManagementState {}

class OnAllUserRetrivedState extends UserManagementState {}

class OnUserRetrivedFailureState extends UserManagementState {}
