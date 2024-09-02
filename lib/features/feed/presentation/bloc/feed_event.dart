import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

abstract class FeedEvent {}

class GetFeedEvent extends FeedEvent {}

class CreatePostEvent extends FeedEvent {
  final Post post;

  CreatePostEvent({required this.post});
}

class GetUserPostEvent extends FeedEvent {
  final ProfileEntity user;

  GetUserPostEvent({required this.user});
}
