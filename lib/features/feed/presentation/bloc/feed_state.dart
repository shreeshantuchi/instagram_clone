import 'package:login_token_app/features/feed/domain/entities/post.dart';

abstract class FeedState {}

class FeedInitialState extends FeedState {}

class FeedLoadingState extends FeedState {}

class FeedLoadedState extends FeedState {
  final List<Post> postList;

  FeedLoadedState({required this.postList});
}

class FeedRetrivalFailureState extends FeedState {}

//loading
class PostCreationLoadingState extends FeedState {}

//sucess
class PostCreationSuccessState extends FeedState {}

//fail
class PostCreationFailureState extends FeedState {
  final String error;

  PostCreationFailureState({required this.error});
}
