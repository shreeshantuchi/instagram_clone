import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_token_app/features/authentication/data/models/user.dart';
import 'package:login_token_app/features/feed/data/datasources/feed_remote_datasource.dart';
import 'package:login_token_app/features/feed/data/datasources/feed_remote_datasource_impl.dart';
import 'package:login_token_app/features/feed/data/models/post_model.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/domain/repositories/feed_repository.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;
  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Post>> getFeed() async {
    try {
      final querySnapshot = await remoteDataSource.getFeed();
      return querySnapshot;
    } catch (e) {
      throw Exception("Failed to fetch feed: $e");
    }
  }

  @override
  Future<void> createPost(Post post) async {
    try {
      final postModel = PostModel(
        timestamp: post.timestamp,
        postId: post.postId,
        userUrl: post.userUrl,
        postCaption: post.description,
        userId: post.userId,
        username: post.username,
        postUrl: post.postUrl,
      );

      await remoteDataSource.createPost(postModel);
    } catch (e) {
      throw Exception("Failed to create post: $e");
    }
  }

  @override
  Future<List<Post>> getUserPosts(ProfileEntity user) async {
    final usrPostsModel = await remoteDataSource.getUserPosts(user);
    final userPosts = usrPostsModel
        .map(
          (e) => PostModel(
            timestamp: e.timestamp,
            postId: e.postId,
            userUrl: e.userUrl,
            postCaption: e.description,
            userId: e.userId,
            username: e.username,
            postUrl: e.postUrl,
          ),
        )
        .toList();
    return userPosts;
  }
}
