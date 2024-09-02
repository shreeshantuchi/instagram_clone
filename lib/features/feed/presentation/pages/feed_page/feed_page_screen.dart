import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:login_token_app/core/widget/nav_bar_screen.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/pages/splashView/splash_screen.dart';
import 'package:login_token_app/core/services/ApiService/api_service.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/core/widget/custom_button.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_event.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_state.dart';
import 'package:login_token_app/features/feed/presentation/widgets/post_list.dart';
import 'package:login_token_app/features/messenging/data/model/conversation_model.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_bloc.dart';
import 'package:login_token_app/features/messenging/presentation/pages/conversation_view/conversation_view.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class FeedPageScreen extends StatefulWidget {
  const FeedPageScreen({super.key});

  @override
  State<FeedPageScreen> createState() => _FeedPageScreenState();
}

class _FeedPageScreenState extends State<FeedPageScreen> {
  ApiService apiService = ApiService();
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  Widget? _catchedWidget;

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> appBarOpacity = ValueNotifier<double>(1.0);
  final double _appBarMaxHeight = 50.0;

  @override
  void initState() {
    context.read<FeedBloc>().add(GetFeedEvent());
    double count = 0;
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          count < _appBarMaxHeight) {
        count++;
      } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          count > 0) {
        count = count > 20 ? count - 5 : count - 1;
      }
      appBarOpacity.value = (1.0 - (count / _appBarMaxHeight).clamp(0.0, 1.0));
    });
  }

  Future<void> _refreshFeed() async {
    // Trigger a fresh feed load
    context.read<FeedBloc>().add(GetFeedEvent());

    // Simulate network request delay
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    appBarOpacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: InstagramColors.foregroundColor,
        body: RefreshIndicator(
          onRefresh: _refreshFeed,
          edgeOffset:
              50, // This determines the point at which the refresh is triggered
          displacement:
              50, // This controls the distance of the progress indicator from the top
          color: Colors.black,
          strokeWidth: 2.0, // Thickness of the progress indicator
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(), // Smooth scroll physics
            slivers: [
              ValueListenableBuilder<double>(
                valueListenable: appBarOpacity,
                builder: (context, opacity, child) {
                  return SliverAppBar(
                    toolbarHeight: _appBarMaxHeight.h,
                    backgroundColor: InstagramColors.foregroundColor,
                    floating: true,
                    pinned: false,
                    snap: true,
                    surfaceTintColor: Colors.transparent,
                    title: Opacity(
                      opacity: opacity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
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
                            Spacer(),
                            Icon(
                              PhosphorIconsRegular.heart,
                              size: 24.sp,
                              color: Colors.black.withOpacity(opacity),
                            ),
                            SizedBox(width: 10.w),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConversationView()),
                                );
                              },
                              icon: Icon(
                                PhosphorIconsRegular.messengerLogo,
                                size: 24.sp,
                                color: Colors.black.withOpacity(opacity),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              BlocConsumer<FeedBloc, FeedState>(
                listener: (context, state) async {
                  if (state is FeedRetrivalFailureState) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Log out"),
                          actions: [
                            CustomButton(
                              text: "Ok",
                              onTap: () {
                                context
                                    .read<AuthBloc>()
                                    .add(const SignOutEvent());
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
                      },
                    );
                  }
                },
                builder: (context, state) {
                  switch (state) {
                    case FeedLoadingState():
                      return SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 550.h,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // CircularProgressIndicator(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    case FeedLoadedState():
                      if (_catchedWidget == null) {
                        _catchedWidget = PostList(postList: state.postList);
                      } else {
                        return PostList(postList: state.postList);
                      }
                      return _catchedWidget!;
                    default:
                      return _catchedWidget ??
                          SliverToBoxAdapter(child: SizedBox.shrink());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
