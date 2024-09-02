import 'package:flutter/material.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/presentation/widgets/post_item.dart';

class PostList extends StatefulWidget {
  final List<Post> postList;
  const PostList({super.key, required this.postList});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => PostItem(
          post: widget.postList[index],
          key: ValueKey(widget.postList[index].postId),
        ),
        childCount: widget.postList.length,
      ),
    );
  }
}
