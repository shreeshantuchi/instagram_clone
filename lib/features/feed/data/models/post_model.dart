import 'package:login_token_app/features/feed/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.postId,
    required super.userUrl,
    required String? postCaption,
    required super.userId,
    required super.username,
    required super.postUrl,
  }) : super(
          description: postCaption,
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
