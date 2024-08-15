import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/domain/repositories/feed_repository.dart';

class CreatePost {
  final FeedRepository repository;

  CreatePost({required this.repository});

  Future<void> call(Post post) async {
    try {
      await repository.createPost(post);
    } catch (e) {
      throw Exception("Failed to create post: $e");
    }
  }
}
