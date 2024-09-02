import 'package:login_token_app/features/authentication/data/models/user.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/domain/repositories/feed_repository.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

class GetUserPost {
  final FeedRepository repository;

  GetUserPost({required this.repository});

  Future<List<Post>> call(ProfileEntity user) async {
    try {
      return await repository.getUserPosts(user);
    } catch (e) {
      throw Exception("Failed to get feed: $e");
    }
  }
}
