import 'package:login_token_app/features/authentication/data/models/user.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

abstract class FeedRepository {
  Future<List<Post>> getFeed();
  Future<List<Post>> getUserPosts(ProfileEntity user);

  Future<void> createPost(Post post);
}
