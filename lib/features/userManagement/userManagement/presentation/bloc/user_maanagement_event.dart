import 'package:flutter/foundation.dart';

@immutable
abstract class UserMaanagementEvent {
  const UserMaanagementEvent();
}

class GetUserEvent extends UserMaanagementEvent {
  const GetUserEvent() : super();
}
