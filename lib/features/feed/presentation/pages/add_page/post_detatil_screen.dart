import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:login_token_app/core/widget/custom_button.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/feed/domain/entities/post.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_event.dart';
import 'package:login_token_app/features/feed/presentation/widgets/Caption_overlayScreen.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';

class PostDetatilScreen extends StatefulWidget {
  final Post newPost;
  const PostDetatilScreen({super.key, required this.newPost});

  @override
  State<PostDetatilScreen> createState() => _PostDetatilScreenState();
}

class _PostDetatilScreenState extends State<PostDetatilScreen> {
  TextEditingController captionController = TextEditingController();
  final ValueNotifier<bool> _isDialogVisible = ValueNotifier<bool>(false);

  void _showCaptionDialog() {
    _isDialogVisible.value = true;
    FocusScope.of(context).unfocus();
  }

  void _hideCaptionDialog() {
    _isDialogVisible.value = false;
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final imgUrl = widget.newPost.postUrl!.first;

    return Stack(
      children: [
        Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ValueListenableBuilder<bool>(
              valueListenable: _isDialogVisible,
              builder: (context, isVisible, child) {
                return !isVisible
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: CustomButton(
                          width: 300,
                          backgroundColor: InstagramColors.buttonColor,
                          height: 40,
                          text: "Submit",
                          onTap: () async {
                            final user = await context
                                .read<UserManagementBloc>()
                                .getCurrentUserUsecase
                                .call();
                            widget.newPost.description = captionController.text;
                            widget.newPost.userId = user.uid;
                            widget.newPost.username = user.username;
                            widget.newPost.userUrl = user.photoUrl;
                            context
                                .read<FeedBloc>()
                                .add(CreatePostEvent(post: widget.newPost));
                          },
                        ),
                      )
                    : SizedBox.shrink();
              }),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "New post",
              style: instagramTextTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: _isDialogVisible,
                        builder: (context, isVisible, child) {
                          return !isVisible
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Container(
                                    height: 200.h,
                                    width: 180.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8
                                          .r), // Border radius for the container
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8
                                          .r), // Same border radius for the image
                                      child: Image.file(
                                        File.fromUri(Uri.parse(imgUrl)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
                TextField(
                  maxLines: 2,
                  onTap: _showCaptionDialog,
                  controller: captionController,
                  decoration: InputDecoration(
                    border:
                        InputBorder.none, // Removes the border in all states
                    enabledBorder: InputBorder
                        .none, // Removes the border when the field is enabled
                    focusedBorder: InputBorder
                        .none, // Removes the border when the field is focused
                    disabledBorder: InputBorder
                        .none, // Removes the border when the field is disabled
                    hintText: "Write a caption or add a poll...",
                    hintStyle: instagramTextTheme.labelMedium!
                        .copyWith(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isDialogVisible,
          builder: (context, isVisible, child) {
            return isVisible
                ? CustomDialog(
                    captionController: captionController,
                    onOkPressed: _hideCaptionDialog,
                  )
                : SizedBox.shrink();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _isDialogVisible.dispose();
    super.dispose();
  }
}

class CustomLineBreakFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Define the max number of characters before a line break
    const int maxCharsPerLine = 20;

    final String text = newValue.text;
    final newText = _addLineBreaks(text, maxCharsPerLine);

    // Return the new value with the added line breaks
    return newValue.copyWith(
      text: newText,
      selection: newValue.selection.copyWith(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }

  String _addLineBreaks(String text, int maxCharsPerLine) {
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % maxCharsPerLine == 0) {
        buffer.write('\n');
      }
      buffer.write(text[i]);
    }
    return buffer.toString();
  }
}
