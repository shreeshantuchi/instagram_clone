import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';

class UserPostsGridView extends StatelessWidget {
  final List<Post> usePost;
  const UserPostsGridView({super.key, required this.usePost});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: usePost.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            child: CachedNetworkImage(
              imageUrl: usePost[index].postUrl!.first,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }
}
