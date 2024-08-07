import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularProfileWidget extends StatelessWidget {
  final String imageUrl;
  final double imageSize;
  const CircularProfileWidget(
      {super.key, required this.imageUrl, this.imageSize = 18});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: imageSize.sp,
      backgroundImage: NetworkImage(imageUrl, scale: imageSize),
    );
  }
}
