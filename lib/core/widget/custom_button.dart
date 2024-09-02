import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final double radius;
  final String text;
  final double width;
  final double height;
  final VoidCallback onTap;
  final EdgeInsetsGeometry contentPadding;
  const CustomButton({
    super.key,
    this.height = 50,
    this.backgroundColor = AppPallet.blueColor,
    required this.text,
    this.width = double.infinity,
    required this.onTap,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    this.textColor = Colors.white,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius.r),
            color: backgroundColor),
        child: Center(
          child: Padding(
            padding: contentPadding,
            child: Text(
              text,
              style: instagramTextTheme.bodyMedium!
                  .copyWith(color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
