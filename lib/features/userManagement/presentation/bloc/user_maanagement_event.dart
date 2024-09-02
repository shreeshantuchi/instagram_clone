import 'package:flutter/foundation.dart';

@immutable
abstract class UserManagementEvent {
  const UserManagementEvent();
}

class GetProfileEvent extends UserManagementEvent {
  final String uid;
  const GetProfileEvent(this.uid) : super();
}

class SetProfileEvent extends UserManagementEvent {
  const SetProfileEvent() : super();
}

class GetAllProfileEvent extends UserManagementEvent {
  const GetAllProfileEvent() : super();
}

class GetCurrentUserEvent extends UserManagementEvent {
  const GetCurrentUserEvent() : super();
}

class SearchProfileEvent extends UserManagementEvent {
  final String searchText;

  const SearchProfileEvent({required this.searchText});
}
