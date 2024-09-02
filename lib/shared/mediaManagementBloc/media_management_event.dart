import 'package:flutter/foundation.dart';

@immutable
abstract class MediaManageMentEvent {}

class ResetMediaEvent extends MediaManageMentEvent {}

class SelectImageEvent extends MediaManageMentEvent {}

class SelectCameraEvent extends MediaManageMentEvent {}

class SelectMultipleImage extends MediaManageMentEvent {}

class SelectVideo extends MediaManageMentEvent {}
