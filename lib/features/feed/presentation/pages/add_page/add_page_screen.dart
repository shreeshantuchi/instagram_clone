import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/presentation/image_state.dart';
import 'package:login_token_app/features/feed/presentation/pages/add_page/post_detatil_screen.dart';
import 'package:login_token_app/features/feed/presentation/widgets/image_grid.dart';
import 'package:login_token_app/features/feed/presentation/widgets/selected_image_display.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddPageScreen extends StatefulWidget {
  const AddPageScreen({super.key});

  @override
  State<AddPageScreen> createState() => _AddPageScreenState();
}

class _AddPageScreenState extends State<AddPageScreen> {
  @override
  void initState() {
    print("Add page");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.x),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              overlayColor: Colors.transparent,
              splashFactory:
                  NoSplash.splashFactory, // Removes the splash effect
            ),
            onPressed: () {
              final selectedImageFile =
                  context.read<ImageState>().selectedImagePath.value;
              final post = Post(
                  timestamp: Timestamp.fromDate(DateTime.now()),
                  postId: '',
                  userUrl: '',
                  description: '',
                  userId: '',
                  username: '',
                  postUrl: [selectedImageFile!]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetatilScreen(
                    newPost: post,
                  ),
                ),
              );
            },
            child: Text(
              "Next",
              style: instagramTextTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: InstagramColors.buttonColor),
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          "New post",
          style: instagramTextTheme.bodyMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SelectedImageDisplay(),
          SizedBox(
              height: 50.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent",
                      style: instagramTextTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(PhosphorIconsRegular.stack),
                        )
                      ],
                    )
                  ],
                ),
              )), // Top half display
          Expanded(child: ImageGrid()), // GridView display
        ],
      ),
    );
  }
}
