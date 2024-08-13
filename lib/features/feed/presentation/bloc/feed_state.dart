import 'package:login_token_app/features/feed/domain/entities/post.dart';

abstract class FeedState {}

class FeedInitialState extends FeedState {}

class FeedLoadingState extends FeedState {}

class FeedLoadedState extends FeedState {
  final List<Post> postList;

  FeedLoadedState({required this.postList});
}

class FeedRetrivalFailureState extends FeedState {}
