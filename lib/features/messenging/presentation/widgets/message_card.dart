import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/features/messenging/domain/entity/mesage_entity.dart';
import 'package:login_token_app/features/messenging/presentation/pages/chatView/widgets/dynamic_image.dart';

class MessageCard extends StatelessWidget {
  const MessageCard(
      {super.key,
      required this.message,
      this.textColor = AppPallet.whiteColor,
      this.backgroundCOlor = AppPallet.blueColor});
  final MessageEntity message;
  final Color textColor;
  final Color backgroundCOlor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: message.imageUrl != null
          ? DynamicImageFit(imageUrl: message.imageUrl!)
          : Container(
              decoration: BoxDecoration(
                  color: backgroundCOlor,
                  borderRadius: BorderRadius.circular(
                    30.r,
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                child: Text(
                  message.content!,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: textColor,
                      ),
                ),
              ),
            ),
    );
  }
}
