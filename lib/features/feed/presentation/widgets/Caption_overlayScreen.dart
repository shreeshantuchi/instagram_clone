import 'package:flutter/material.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';

class CustomDialog extends StatefulWidget {
  final VoidCallback onOkPressed;
  final TextEditingController captionController;

  CustomDialog({required this.onOkPressed, required this.captionController});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Request focus to show the keyboard when the dialog is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the dialog when tapping outside the TextField
        widget.onOkPressed();
      },
      child: Scaffold(
        backgroundColor: InstagramColors.grey.withOpacity(0.2),
        appBar: AppBar(
          elevation: 0,
          leading: Container(),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                overlayColor: Colors.transparent,
                splashFactory:
                    NoSplash.splashFactory, // Removes the splash effect
              ),
              onPressed: widget.onOkPressed,
              child: Text(
                "Ok",
                style: instagramTextTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: InstagramColors.buttonColor),
              ),
            ),
          ],
          centerTitle: true,
          title: Text(
            "Caption",
            style: instagramTextTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                // This GestureDetector handles taps outside the TextField
                widget.onOkPressed();
              },
              child: Container(
                color: Colors.transparent, // Transparent to capture taps
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: Container(
                color: InstagramColors.foregroundColor,
                child: TextField(
                  maxLines: 2,
                  focusNode: _focusNode,
                  controller: widget.captionController,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
