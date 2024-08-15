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
import 'package:login_token_app/features/userManagement/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/features/userManagement/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/bloc/user_management_state.dart';
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

  @override
  void initState() {
    //   context.read<UserManagementBloc>().add(const GetUserEvent());
    context.read<FeedBloc>().add(GetFeedEvent());
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
      appBarOpacity.value = opacity;
    });
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> appBarOpacity = ValueNotifier<double>(1.0);
  final double _appBarMaxHeight =
      50.0; // Adjust this as per your app bar height

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

        // bottomNavigationBar: const NavBarScreen(),

        body: SizedBox(
          height: double.infinity,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              ValueListenableBuilder<double>(
                valueListenable: appBarOpacity,
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
                        child: Row(
                          children: [
                            GestureDetector(
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
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      PhosphorIconsRegular.heart,
                                      size: 24.sp,
                                      color: Colors.black.withOpacity(opacity),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Icon(
                                      PhosphorIconsRegular.messengerLogo,
                                      size: 24.sp,
                                      color: Colors.black.withOpacity(opacity),
                                    ),
                                  ],
                                ),
                              ),
                            )
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
                  }
                },
                builder: (context, state) {
                  switch (state) {
                    case FeedLoadingState():
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 550.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        ),
                      );
                    case FeedLoadedState():
                      return PostList(
                        postList: state.postList,
                      );
                    default:
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
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
