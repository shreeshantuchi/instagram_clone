import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_token_app/features/feed/data/datasources/feed_remote_datasource_impl.dart';
import 'package:login_token_app/features/feed/data/models/post_model.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/domain/repositories/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FirebaseFirestore firestore;

  FeedRepositoryImpl(
      {required this.firestore,
      required FeedRemoteDataSourceImpl remoteDataSource});

  @override
  Future<List<Post>> getFeed() async {
    try {
      final querySnapshot = await firestore.collection('posts').get();
      return querySnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch feed: $e");
    }
  }

  @override
  Future<void> createPost(Post post) async {
    try {
      final postModel = PostModel(
        postId: post.postId,
        userUrl: post.userUrl,
        postCaption: post.description,
        userId: post.userId,
        username: post.username,
        postUrl: post.postUrl,
      );

      await firestore
          .collection('posts')
          .doc(postModel.postId)
          .set(postModel.toJson());
    } catch (e) {
      throw Exception("Failed to create post: $e");
    }
  }
}
