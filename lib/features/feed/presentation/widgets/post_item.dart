import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
                  height: 200,
                  width: double.infinity,
                ),
          widget.post.postUrl!.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.post.postUrl!.asMap().entries.map((entry) {
                    print(entry.key);
                    print("current:" + current.toString());
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: current == entry.key
                                ? Colors.black
                                : Colors.grey),
                      ),
                    );
                  }).toList(),
                )
              : SizedBox.shrink(),
          Text(widget.post.username.toString()),
          Text(widget.post.description.toString()),
          Text(widget.post.userId.toString()),
        ],
      ),
    );
  }
}
