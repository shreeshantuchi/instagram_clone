class Post {
  final String id;
  final String userId;
  final String description;
  final String imageUrl;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });
}
