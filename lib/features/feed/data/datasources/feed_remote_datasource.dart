import 'package:login_token_app/features/feed/data/models/post_model.dart';

abstract class FeedRemoteDataSource {
  Future<List<PostModel>> getFeed();

  Future<void> createPost(PostModel post);
}
