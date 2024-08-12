import 'package:flutter/material.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/presentation/widgets/post_item.dart';

class PostList extends StatelessWidget {
  final List<Post> postList;
  const PostList({super.key, required this.postList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          final post = postList[index];
          return PostItem(post: post);
        });
  }
}
