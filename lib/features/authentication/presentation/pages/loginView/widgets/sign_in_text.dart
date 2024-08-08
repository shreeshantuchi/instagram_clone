import 'package:flutter/material.dart';
import 'package:login_token_app/core/constants/strings/strings.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/theme/text_thme.dart';

class SignInText extends StatelessWidget {
  const SignInText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: RichText(
        text: TextSpan(
            text: AppString.dontHaveanAccount,
            style: instagramTextTheme.labelMedium,
            children: [
              TextSpan(
                  text: " Sign up",
                  style: instagramTextTheme.labelMedium!.copyWith(
                      color: InstagramColors.buttonColor,
                      fontWeight: FontWeight.bold)),
            ]),
      ),
    );
  }
}
