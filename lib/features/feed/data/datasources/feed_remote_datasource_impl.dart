import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_token_app/features/feed/data/models/post_model.dart';
import 'package:login_token_app/features/feed/data/datasources/feed_remote_datasource.dart';

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final FirebaseFirestore firestore;

  FeedRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<PostModel>> getFeed() async {
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
  Future<void> createPost(PostModel post) async {
    try {
      await firestore.collection('posts').doc(post.postId).set(post.toJson());
    } catch (e) {
      throw Exception("Failed to create post: $e");
    }
  }
}
