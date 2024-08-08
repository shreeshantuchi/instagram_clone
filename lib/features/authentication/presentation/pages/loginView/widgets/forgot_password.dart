import 'package:flutter/material.dart';
import 'package:login_token_app/core/constants/strings/strings.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';

class ForgotPasswrod extends StatelessWidget {
  const ForgotPasswrod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(AppString.forgotPassword,
            style: instagramTextTheme.bodySmall!.copyWith(
                color: InstagramColors.buttonColor,
                fontWeight: FontWeight.bold))
      ],
    );
  }
}
