class Post {
  final String? postId;
  final String? userUrl;
  final String? description;
  final String? userId;
  final String? username;
  final List? postUrl;

  Post({
    required this.postUrl,
    required this.userId,
    required this.username,
    required this.postId,
    required this.userUrl,
    required this.description,
  });

  // @override
  // List<Object> get props => [postId, userUrl, description, userId, username];
}
