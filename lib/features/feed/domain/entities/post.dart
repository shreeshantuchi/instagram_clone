import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? postId;
  String? userUrl;
  String? description;
  String? userId;
  String? username;
  List<String>? postUrl;
  Timestamp timestamp;

  Post({
    required this.postId,
    required this.userUrl,
    required this.description,
    required this.userId,
    required this.username,
    required this.postUrl,
    required this.timestamp,
  });
}
