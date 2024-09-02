import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/widget/custom_button.dart';

class CurrentUserButtonRow extends StatelessWidget {
  const CurrentUserButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              backgroundColor: InstagramColors.grey.withOpacity(0.3),
              textColor: Colors.black,
              radius: 7,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              text: "Edit profile",
              onTap: () {},
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: CustomButton(
              backgroundColor: InstagramColors.grey.withOpacity(0.3),
              textColor: Colors.black,
              radius: 7,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              width: MediaQuery.of(context).size.width / 2.w,
              onTap: () {},
              text: "Share profile",
            ),
          )
        ],
      ),
    );
  }
}
