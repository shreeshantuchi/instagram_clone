import 'package:login_token_app/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/domain/repositories/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSoruce remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Post>> getFeed() async {
    final listPostModel = await remoteDataSource.getFeed();
    final listPost = listPostModel.map((element) {
      return Post(
          userId: element.userId,
          username: element.username,
          postId: element.postId,
          userUrl: element.userUrl,
          description: element.description,
          postUrl: element.postUrl);
    }).toList();
    return listPost;
  }
}
