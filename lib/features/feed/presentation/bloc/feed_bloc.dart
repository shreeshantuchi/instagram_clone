import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/features/feed/domain/usecase/create_post.dart';
import 'package:login_token_app/features/feed/domain/usecase/get_feed.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_event.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeed getFeed;
  final CreatePost createPost;

  FeedBloc({required this.getFeed, required this.createPost})
      : super(FeedInitialState()) {
    //feed
    on<GetFeedEvent>((event, emit) async {
      emit(FeedLoadingState());
      try {
        final feed = await getFeed.call();
        emit(FeedLoadedState(postList: feed));
      } catch (e) {
        emit(FeedRetrivalFailureState());
      }
    });
    //post_creation
    on<CreatePostEvent>((event, emit) async {
      emit(PostCreationLoadingState());
      try {
        await createPost.call(event.post);
        emit(PostCreationSuccessState());
      } catch (e) {
        emit(PostCreationFailureState(error: e.toString()));
      }
    });
  }
}
