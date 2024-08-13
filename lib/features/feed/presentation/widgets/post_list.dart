import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          floating: true,
          pinned: false,
          surfaceTintColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text(
                  "Instagram",
                  style: instagramHeading.copyWith(fontSize: 35.sp),
                ),
                SizedBox(width: 5.w),
                Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Icon(
                    PhosphorIconsRegular.caretDown,
                    size: 14.sp,
                  ),
                ),
                SizedBox(width: 100.w),
                Icon(
                  PhosphorIconsRegular.heart,
                  size: 24.sp,
                ),
                SizedBox(width: 10.w),
                Icon(
                  PhosphorIconsRegular.messengerLogo,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => PostItem(post: widget.postList[index]),
            childCount: widget.postList.length,
          ),
        ),
      ],
    );
  }
}
