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
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _appBarOpacity = ValueNotifier<double>(1.0);
  final double _appBarMaxHeight =
      50.0; // Adjust this as per your app bar height

  @override
  void initState() {
    double count = 0;
    super.initState();
    _scrollController.addListener(() {
      // print(count);
      if (count < _appBarMaxHeight &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        count++;
      } else if (count >= 0 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        count = count - 1;
        if (count > 20) {
          count = count - 5;
        }
      }
      ;

      double opacity = 1.0 - (count / _appBarMaxHeight).clamp(0.0, 1.0);
      _appBarOpacity.value = opacity;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _appBarOpacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        ValueListenableBuilder<double>(
          valueListenable: _appBarOpacity,
          builder: (context, opacity, child) {
            return SliverAppBar(
              toolbarHeight: _appBarMaxHeight.h, // Adjust height here
              backgroundColor: InstagramColors.foregroundColor,
              floating: true,
              pinned: false,
              snap: true,
              surfaceTintColor: Colors.transparent,
              title: Opacity(
                opacity: opacity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("log out"),
                              actions: [
                                CustomButton(
                                  text: "Ok",
                                  onTap: () {
                                    context.read<AuthBloc>().add(
                                          const SignOutEvent(),
                                        );

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SplashScreen()),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Instagram",
                          style: instagramHeading.copyWith(
                            fontSize: 35.sp,
                            color: Colors.black.withOpacity(opacity),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Icon(
                            PhosphorIconsRegular.caretDown,
                            size: 14.sp,
                            color: Colors.black.withOpacity(opacity),
                          ),
                        ),
                        SizedBox(width: 100.w),
                        Icon(
                          PhosphorIconsRegular.heart,
                          size: 24.sp,
                          color: Colors.black.withOpacity(opacity),
                        ),
                        SizedBox(width: 10.w),
                        Icon(
                          PhosphorIconsRegular.messengerLogo,
                          size: 24.sp,
                          color: Colors.black.withOpacity(opacity),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => PostItem(
              post: widget.postList[index],
              key: ValueKey(widget.postList[index].postId),
            ),
            childCount: widget.postList.length,
          ),
        ),
      ],
    );
  }
}
