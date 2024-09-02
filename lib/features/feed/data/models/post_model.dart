import 'package:login_token_app/features/feed/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.postId,
    required super.userUrl,
    required String? postCaption,
    required super.userId,
    required super.username,
    required super.postUrl,
    required super.timestamp,
  }) : super(description: postCaption);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'].toString(),
      userUrl: json['userUrl'],
      postCaption: json['description'],
      userId: json['userId'],
      username: json['username'],
      postUrl: List<String>.from(json['postUrl']),
      timestamp: json["timestamp"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userUrl': userUrl,
      'description': description,
      'userId': userId,
      'username': username,
      'postUrl': postUrl,
      'timestamp': timestamp
    };
  }
}
