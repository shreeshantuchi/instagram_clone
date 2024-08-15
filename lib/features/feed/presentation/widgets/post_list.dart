import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:login_token_app/core/widget/custom_button.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/pages/splashView/splash_screen.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/presentation/widgets/post_item.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
