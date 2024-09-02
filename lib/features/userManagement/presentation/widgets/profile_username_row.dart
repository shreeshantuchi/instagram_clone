import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileUserUserNameRow extends StatelessWidget {
  final String username;
  const ProfileUserUserNameRow({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 7.5.h),
                child: Text(
                  username,
                  style: instagramTextTheme.headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(PhosphorIconsBold.caretLeft)),
      ],
    );
  }
}
