import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/features/authentication/data/models/user.dart';
import 'package:login_token_app/features/feed/domain/usecase/create_post.dart';
import 'package:login_token_app/features/feed/domain/usecase/get_feed.dart';
import 'package:login_token_app/features/feed/domain/usecase/get_user_post.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_event.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeed getFeed;
  final CreatePost createPost;
  final GetUserPost getUserFeed;

  FeedBloc(
      {required this.getFeed,
      required this.createPost,
      required this.getUserFeed})
      : super(FeedInitialState()) {
    //feed
    on<GetFeedEvent>((event, emit) async {
      print("here");
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

    on<GetUserPostEvent>((event, emit) async {
      // emit(PostCreationLoadingState());
      try {
        final postList = await getUserFeed.call(
          event.user,
        );
        emit(UserFeedLoadedState(postList: postList));
      } catch (e) {
        emit(PostCreationFailureState(error: e.toString()));
      }
    });
  }
}
