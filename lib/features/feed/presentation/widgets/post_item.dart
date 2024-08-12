import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:login_token_app/features/feed/presentation/widgets/action_row.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key, required this.post});
  final Post post;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  int current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    print(widget.post.userUrl);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                widget.post.userUrl != null
                    ? CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(widget.post.userUrl!),
                      )
                    : CircleAvatar(
                        radius: 20.r,
                        backgroundColor: InstagramColors.grey,
                      ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.username.toString(),
                      style: instagramTextTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.post.username.toString(),
                      style: instagramTextTheme.labelSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
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
                        return SizedBox(
                          height: 300.h,
                          width: double.infinity,
                          child: Image.network(
                            i,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              : Container(
                  height: 200.h,
                  width: double.infinity,
                ),
          widget.post.postUrl!.isNotEmpty
              ? ActionRow(
                  widget: widget, current: current, controller: _controller)
              : const SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.username.toString(),
                  style: instagramTextTheme.labelLarge!.copyWith(
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
