// import 'package:login_token_app/features/feed/data/datasources/feed_remote_data_source.dart';
// import 'package:http/http.dart' as http;
// import 'package:login_token_app/features/feed/data/repositories/feed_repository_impl.dart';
// import 'package:login_token_app/features/feed/domain/usecase/get_feed.dart';
// import 'package:login_token_app/features/feed/presentation/bloc/feed_bloc.dart';

// Future<FeedBloc> createFeedBloc() async {
//   final remoteDataSource = FeedRemoteDataSourceImpl(client: http.Client());
//   //final localDataSource = FeedLocalDataSourceImpl();

//   final remoteRepository =
//       FeedRepositoryImpl(remoteDataSource: remoteDataSource);
//   // final localRepository =
//   //     FeedLocalRepositoryImpl(localDataSource: localDataSource);

//   final getFeed = GetFeed(
//     repository: remoteRepository,
//     // localRepository: localRepository,
//     // isConnected: isConnected,
//   );

//   return FeedBloc(getFeed: getFeed);
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_token_app/features/feed/data/datasources/feed_remote_datasource_impl.dart';
import 'package:login_token_app/features/feed/data/repositories/feed_repository_impl.dart';
import 'package:login_token_app/features/feed/domain/usecase/get_feed.dart';
import 'package:login_token_app/features/feed/domain/usecase/create_post.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_bloc.dart';

Future<FeedBloc> createFeedBloc() async {
  final firestore = FirebaseFirestore.instance;
  final remoteDataSource = FeedRemoteDataSourceImpl(firestore: firestore);

  final remoteRepository = FeedRepositoryImpl(
      remoteDataSource: remoteDataSource, firestore: firestore);

  final getFeed = GetFeed(repository: remoteRepository);
  final createPost = CreatePost(repository: remoteRepository);

  return FeedBloc(getFeed: getFeed, createPost: createPost);
}
