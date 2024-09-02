import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:login_token_app/features/authentication/data/models/user.dart';
import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/feed/data/models/post_model.dart';
import 'package:login_token_app/features/feed/data/datasources/feed_remote_datasource.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:mime/mime.dart';

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final FirebaseFirestore firestore;

  FeedRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<PostModel>> getFeed() async {
    try {
      final querySnapshot = await firestore.collection('Posts').get();

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
      // Validate the file path
      final filePath = post.postUrl!.first;
      if (filePath == null || filePath.isEmpty) {
        throw Exception("Invalid file path or URI");
      }

      // Create a file instance
      final file = File(filePath);
      if (!file.existsSync()) {
        throw Exception("File does not exist at the specified path");
      }

      String path =
          '${post.userId}/${post.postId}/media/${DateTime.now().microsecondsSinceEpoch}.jpg';
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref(path)
          .putFile(file, SettableMetadata(contentType: "image/jpeg"));

      // Ensure the upload is successful
      if (snapshot.state == TaskState.success) {
        // Get the download URL
        final downloadURL = await snapshot.ref.getDownloadURL();
        post.postUrl = [downloadURL];

        // Save post details in Firestore
        final docRef = FirebaseFirestore.instance.collection('Posts').doc();
        post.postId = docRef.id;
        //increasing the number of post
        FirebaseFirestore.instance
            .collection('Profile')
            .doc(post.userId)
            .update({
          'postCount': FieldValue.increment(1),
        });

        await docRef.set(post.toJson());
      } else {
        throw Exception("Failed to upload image to Firebase Storage");
      }
    } catch (e) {
      throw Exception("Failed to create post: $e");
    }
  }

  @override
  Future<List<PostModel>> getUserPosts(ProfileEntity user) async {
    final allPost = await getFeed();
    final List<PostModel> userPosts =
        allPost.where((item) => item.userId == user.uid).toList();
    return userPosts;
  }
}
