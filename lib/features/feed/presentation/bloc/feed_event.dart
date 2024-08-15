import 'package:login_token_app/features/feed/domain/entities/post.dart';

abstract class FeedEvent {}

class GetFeedEvent extends FeedEvent {}

class CreatePostEvent extends FeedEvent {
  final Post post;

  CreatePostEvent({required this.post});
}
