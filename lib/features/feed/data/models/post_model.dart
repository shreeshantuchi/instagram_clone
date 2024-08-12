import 'package:login_token_app/features/feed/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required String? postId,
    required String? userUrl,
    required String? postCaption,
    required String? userId,
    required String? username,
    required List? postUrl,
  }) : super(
          postUrl: postUrl,
          postId: postId,
          userUrl: userUrl,
          description: postCaption,
          userId: userId,
          username: username,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        postId: json['productId'].toString(),
        userUrl: json['userImage'],
        postCaption: json['caption'],
        userId: json['user_id'],
        username: json['userName'],
        postUrl: json['imageList']);
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'imageUrl': userUrl,
      'description': description,
      'userId': userId,
      'username': username,
    };
  }
}
