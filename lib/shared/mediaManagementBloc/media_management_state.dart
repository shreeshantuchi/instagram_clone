import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

@immutable
abstract class MediaManagementState {}

class MediaManagementInitial extends MediaManagementState {}

class OnMediaSelected extends MediaManagementState {
  final List<XFile> imageList;

  OnMediaSelected({required this.imageList});
}

class UserCanceledState extends MediaManagementState {}

class OnVideoSelected extends MediaManagementState {
  final List<XFile> videoList;

  OnVideoSelected({required this.videoList});
}
