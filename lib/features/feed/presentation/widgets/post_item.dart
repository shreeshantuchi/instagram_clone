import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/presentation/widgets/animated_heart.dart';
import 'package:login_token_app/features/feed/presentation/widgets/action_row.dart';
import 'package:login_token_app/features/like/like_services.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key, required this.post});
  final Post post;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem>
    with AutomaticKeepAliveClientMixin {
  LikeServices likeServices = LikeServices();
  int current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final ValueNotifier<Color> _heartColor = ValueNotifier<Color>(Colors.black);
  late ValueNotifier<bool> isHeart;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _heartColor.dispose();
    isHeart.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final userProfile = context.read<AuthBloc>().state.user;
    likeServices.isPostLiked(
        widget.post,
        ProfileModel.fromProfileEntity(
            ProfileModel.fromUserEntity(userProfile!)));
    super.initState();
    isHeart = ValueNotifier<bool>(false);
  }

  void _changeHeartColor() {
    if (isHeart.value) {
      _heartColor.value = InstagramColors.likeColor;
    } else {
      _heartColor.value = Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = context.read<AuthBloc>().state.user;
    super.build(
        context); // Ensures the state is retained when using AutomaticKeepAliveClientMixin
    return FutureBuilder<bool>(
      future: likeServices.isPostLiked(
        widget.post,
        ProfileModel.fromUserEntity(userProfile!),
      ),
      builder: (context, snapshot) {
        // Check if the future is still loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 400.h, // Adjust height according to your content
                color: Colors.white,
              ),
            ),
          );
        }

        // Check if there was an error
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        // Check if data has been received and return content
        if (snapshot.hasData) {
          if (snapshot.data!) {
            isHeart.value = true;
            _changeHeartColor();
          }
          return postContent();
        }

        // Handle the case where the snapshot does not have data yet
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  ListTile postContent() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                widget.post.userUrl != ""
                    ? CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(widget.post.userUrl!),
                      )
                    : CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.grey,
                      ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.username.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.post.username.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          widget.post.postUrl!.isNotEmpty
              ? CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                      padEnds: false,
                      enableInfiniteScroll: false,
                      height: 300.0,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                      }),
                  items: widget.post.postUrl!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return HeartOverImage(
                          post: widget.post,
                          imageUrl: i,
                          onAnimationEnd: _changeHeartColor,
                          heartColorNotifier: _heartColor,
                          isHeartVisible: isHeart,
                        );
                      },
                    );
                  }).toList(),
                )
              : SizedBox(height: 200.h, width: double.infinity),
          widget.post.postUrl!.isNotEmpty
              ? ActionRow(
                  onAnimationEnd: _changeHeartColor,
                  post: widget.post,
                  isHeartVisible: isHeart,
                  widget: widget,
                  current: current,
                  controller: _controller,
                  heartColorNotifier: _heartColor,
                )
              : const SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.username.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(widget.post.description.toString()),
                Text(widget.post.userId.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
