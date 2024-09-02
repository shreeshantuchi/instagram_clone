import 'package:login_token_app/features/authentication/data/models/user.dart';
import 'package:login_token_app/features/feed/data/models/post_model.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

abstract class FeedRemoteDataSource {
  Future<List<PostModel>> getFeed();
  Future<List<PostModel>> getUserPosts(ProfileEntity user);

  Future<void> createPost(PostModel post);
}
