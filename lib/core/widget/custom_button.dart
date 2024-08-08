import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final double width;
  final VoidCallback onTap;
  const CustomButton(
      {super.key,
      this.color = AppPallet.blueColor,
      required this.text,
      this.width = double.infinity,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp), color: color),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Text(
              text,
              style: instagramTextTheme.bodyMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
