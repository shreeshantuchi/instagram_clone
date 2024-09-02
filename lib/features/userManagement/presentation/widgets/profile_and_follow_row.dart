import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:login_token_app/features/userManagement/presentation/widgets/profile_properties.dart';

class ProfileAndFollowerRow extends StatelessWidget {
  final String imgUrl;
  final ProfileEntity profileEntity;
  const ProfileAndFollowerRow(
      {super.key, required this.imgUrl, required this.profileEntity});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        imgUrl != ""
            ? CircleAvatar(
                radius: 50.r,
                child: Image.network(imgUrl),
              )
            : CircleAvatar(
                radius: 50.r,
                backgroundColor: InstagramColors.grey,
              ),
        ProfileProperties(valueCount: profileEntity.postCount, text: "posts"),
        ProfileProperties(
            valueCount: profileEntity.followerCount, text: "followers"),
        ProfileProperties(
            valueCount: profileEntity.followingCount, text: "following"),
      ],
    );
  }
}
