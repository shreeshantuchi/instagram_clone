import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';

class LoadingIndicator extends StatelessWidget {
  final String text;
  const LoadingIndicator({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: AppPallet.blueColor),
            ),
            SizedBox(
              height: 12.h,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
