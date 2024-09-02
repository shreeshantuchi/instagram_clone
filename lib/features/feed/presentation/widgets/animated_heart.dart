import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/like/like_services.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_management_state.dart';

class HeartOverImage extends StatefulWidget {
  final String imageUrl;
  final VoidCallback? onAnimationEnd;
  final ValueNotifier<Color>? heartColorNotifier;
  final ValueNotifier<bool> isHeartVisible;
  final Post post;

  const HeartOverImage({
    super.key,
    required this.imageUrl,
    this.onAnimationEnd,
    this.heartColorNotifier,
    required this.isHeartVisible,
    required this.post,
  });

  @override
  _HeartOverImageState createState() => _HeartOverImageState();
}

class _HeartOverImageState extends State<HeartOverImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  final ValueNotifier<bool> _isHeartVisible = ValueNotifier<bool>(false);
  final ValueNotifier<Offset> _tapPosition = ValueNotifier<Offset>(Offset.zero);
  LikeServices likeServices = LikeServices();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  Future<void> _showHeart(Offset position) async {
    _tapPosition.value = position;

    widget.isHeartVisible.value = true;
    widget.onAnimationEnd!();
    _isHeartVisible.value = true;
    await _controller.forward().then((_) {
      _isHeartVisible.value = false;
      _controller.reset();
      if (widget.onAnimationEnd != null) {
        // Invoke the callback
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _isHeartVisible.dispose();
    _tapPosition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.imageUrl);
    return BlocListener<UserManagementBloc, UserManagementState>(
      listener: (context, state) {
        if (state is OnCurrentUserProfileRetrivedState) {
          if (widget.isHeartVisible.value) {
            print("only like");
            likeServices.likePost(
              widget.post,
              ProfileModel.fromProfileEntity(state.profile),
            );
          }
        }
      },
      child: GestureDetector(
        onDoubleTapDown: (TapDownDetails details) async {
          await _showHeart(details.localPosition);
          context.read<UserManagementBloc>().add(GetCurrentUserEvent());
        },
        child: Stack(
          children: [
            // The image widget
            SizedBox(
              height: 300.h,
              width: double.infinity,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // The animated heart widget
            ValueListenableBuilder<bool>(
              valueListenable: _isHeartVisible,
              builder: (context, isHeartVisible, child) {
                return isHeartVisible
                    ? ValueListenableBuilder<Offset>(
                        valueListenable: _tapPosition,
                        builder: (context, tapPosition, child) {
                          return Positioned(
                            left: tapPosition.dx - 50, // Adjust to center heart
                            top: tapPosition.dy - 50, // Adjust to center heart
                            child: FadeTransition(
                              opacity: _opacityAnimation,
                              child: ScaleTransition(
                                scale: _scaleAnimation,
                                child: Icon(
                                  Icons.favorite,
                                  color: InstagramColors.likeColor,
                                  size: 100.0.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : SizedBox.shrink(); // Empty widget when not visible
              },
            ),
          ],
        ),
      ),
    );
  }
}
