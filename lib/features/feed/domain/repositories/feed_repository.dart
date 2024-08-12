import 'package:login_token_app/features/feed/domain/entities/post.dart';

abstract class FeedRepository {
  Future<List<Post>> getFeed();
}
