import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:login_token_app/core/widget/custom_button.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/pages/splashView/splash_screen.dart';
import 'package:login_token_app/features/userManagement/presentation/widgets/iconRow.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CurrentUserUserNameRow extends StatelessWidget {
  final String username;
  const CurrentUserUserNameRow({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("log out"),
                actions: [
                  CustomButton(
                    text: "Ok",
                    onTap: () {
                      context.read<AuthBloc>().add(
                            const SignOutEvent(),
                          );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              );
            });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(PhosphorIconsRegular.lockSimple),
              SizedBox(width: 5.w),
              Text(
                username,
                style: instagramTextTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5.w),
              Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: Icon(
                  PhosphorIconsRegular.caretDown,
                  size: 14.sp,
                ),
              ),
            ],
          ),
          const IconRow(),
        ],
      ),
    );
  }
}
