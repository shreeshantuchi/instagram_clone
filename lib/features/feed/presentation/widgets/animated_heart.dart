import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';

class HeartOverImage extends StatefulWidget {
  final String imageUrl;
  final VoidCallback? onAnimationEnd;
  final ValueNotifier<Color>? heartColorNotifier;
  final ValueNotifier<bool> isHeartVisible;

  const HeartOverImage({
    super.key,
    required this.imageUrl,
    this.onAnimationEnd,
    this.heartColorNotifier,
    required this.isHeartVisible,
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

  void _showHeart(Offset position) {
    _tapPosition.value = position;
    widget.isHeartVisible.value = true;
    _isHeartVisible.value = true;
    _controller.forward().then((_) {
      _isHeartVisible.value = false;
      _controller.reset();
      if (widget.onAnimationEnd != null) {
        widget.onAnimationEnd!(); // Invoke the callback
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
    return GestureDetector(
      onDoubleTapDown: (TapDownDetails details) {
        _showHeart(details.localPosition);
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
                              child: ValueListenableBuilder<Color>(
                                valueListenable: widget.heartColorNotifier!,
                                builder: (context, heartColor, child) {
                                  return Icon(
                                    Icons.favorite,
                                    color: InstagramColors.likeColor,
                                    size: 100.0.sp,
                                  );
                                },
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
    );
  }
}
