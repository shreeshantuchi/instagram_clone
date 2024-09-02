import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/presentation/widgets/post_item.dart';
import 'package:login_token_app/features/like/like_services.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_management_state.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ActionRow extends StatelessWidget {
  ActionRow({
    super.key,
    required this.widget,
    required this.current,
    required CarouselSliderController controller,
    required this.heartColorNotifier,
    required this.isHeartVisible,
    required this.post,
    this.onAnimationEnd, // Added this line
  }) : _controller = controller;
  final VoidCallback? onAnimationEnd;
  final Post post;
  final PostItem widget;
  final int current;
  final CarouselSliderController _controller;
  final ValueNotifier<Color> heartColorNotifier; //
  final ValueNotifier<bool> isHeartVisible;
  final LikeServices likeServices = LikeServices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 90.w,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocListener<UserManagementBloc, UserManagementState>(
                        listenWhen: (previous, current) => current != previous,
                        listener: (context, state) async {
                          if (state is OnCurrentUserProfileRetrivedState) {
                            print(state);
                            if (isHeartVisible.value) {
                              likeServices.likePost(
                                widget.post,
                                ProfileModel.fromProfileEntity(state.profile),
                              );
                            } else {
                              likeServices.dislikePost(
                                widget.post,
                                ProfileModel.fromProfileEntity(state.profile),
                              );
                            }
                          }
                        },
                        child: GestureDetector(
                          onTap: () {
                            final value = !isHeartVisible.value;
                            isHeartVisible.value = value;
                            onAnimationEnd!();

                            context
                                .read<UserManagementBloc>()
                                .add(GetCurrentUserEvent());
                          },
                          child: ValueListenableBuilder(
                              valueListenable: isHeartVisible,
                              builder: (context, value, child) {
                                return Icon(
                                  value
                                      ? PhosphorIconsFill.heart
                                      : PhosphorIconsRegular.heart,
                                  size: 24.sp,
                                  color: heartColorNotifier
                                      .value, // Use the color from ValueNotifier
                                );
                              }),
                        ),
                      ),
                      Icon(PhosphorIconsRegular.chatCircle, size: 24.sp),
                      Icon(PhosphorIconsRegular.paperPlaneTilt, size: 24.sp),
                    ]),
              ),
              Icon(PhosphorIconsRegular.bookmarkSimple, size: 25.sp)
            ],
          ),
          ScrollDot(widget: widget, current: current, controller: _controller),
        ],
      ),
    );
  }
}

class ScrollDot extends StatelessWidget {
  const ScrollDot({
    super.key,
    required this.widget,
    required this.current,
    required CarouselSliderController controller,
  }) : _controller = controller;

  final PostItem widget;
  final int current;
  final CarouselSliderController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.post.postUrl!.asMap().entries.map((entry) {
          return widget.post.postUrl!.length != 1
              ? GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0.w,
                    height: 8.0.w,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: current == entry.key
                            ? InstagramColors.blue
                            : Colors.grey),
                  ),
                )
              : const SizedBox.shrink();
        }).toList(),
      ),
    );
  }
}
