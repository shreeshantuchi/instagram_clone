import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/domain/repositories/feed_repository.dart';

class GetFeed {
  final FeedRepository repository;

  GetFeed({required this.repository});

  Future<List<Post>> call() async {
    try {
      final feed = await repository.getFeed();
      return feed;
    } catch (e) {
      rethrow;
    }
  }
}
