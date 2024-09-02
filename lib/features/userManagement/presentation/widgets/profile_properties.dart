import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/text_thme.dart';

class ProfileProperties extends StatelessWidget {
  final int valueCount;
  final String text;
  const ProfileProperties(
      {super.key, required this.valueCount, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: Column(
        children: [
          Text(
            valueCount.toString(),
            style: instagramTextTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(text),
        ],
      ),
    );
  }
}
