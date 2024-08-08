import 'package:flutter/material.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallet.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(width: 2, color: AppPallet.greyBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(width: 2, color: AppPallet.focusColor)),
      ));

  static final lightTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppPallet.whiteColor,
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(12),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: InstagramColors.grey)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.3, color: InstagramColors.grey)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.3, color: InstagramColors.grey)),
      ));
}
