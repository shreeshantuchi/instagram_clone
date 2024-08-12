import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/features/feed/domain/usecase/get_feed.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_event.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeed getFeed;
  FeedBloc({required this.getFeed}) : super(FeedInitialState()) {
    on<GetFeedEvent>((event, emit) async {
      emit(FeedLoadingState());
      final feed = await getFeed.call();
      print(feed);
      emit(FeedLoadedState(postList: feed));
    });
  }
}
