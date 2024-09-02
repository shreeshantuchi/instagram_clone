import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/widget/custom_button.dart';
import 'package:login_token_app/features/followUser/domain/entity/follow_entity.dart';
import 'package:login_token_app/features/followUser/presentation/bloc/follow_bloc.dart';
import 'package:login_token_app/features/followUser/presentation/bloc/follow_event.dart';
import 'package:login_token_app/features/followUser/presentation/bloc/follow_state.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_bloc.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_event.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_state.dart';
import 'package:login_token_app/features/messenging/presentation/pages/chatView/chat_view.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

// ignore: must_be_immutable
class ProfileButtonRow extends StatelessWidget {
  final ProfileEntity followProfile;
  final ProfileEntity currentProfile;

  const ProfileButtonRow(
      {super.key, required this.followProfile, required this.currentProfile});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageBloc, MessageState>(
      listener: (context, state) {
        print(state);
        switch (state) {
          case OnConversationFetchedState():
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatView(
                  conversationModel: state.conversation,
                ),
              ),
            );
            break;
          default:
            break;
        }
        // TODO: implement listener
      },
      child: BlocBuilder<FollowBloc, FollowState>(
        builder: (context, state) {
          print(state);

          switch (state) {
            case FollowUserState():
              return FollowedButton(
                  followProfile: followProfile, currentProfile: currentProfile);
            case UnFollowUserState():
              return FollowButton(
                  followProfile: followProfile, currentProfile: currentProfile);
            case FollowExistState():
              if (state.isFollowed) {
                return FollowedButton(
                    followProfile: followProfile,
                    currentProfile: currentProfile);
              } else {
                return FollowButton(
                    followProfile: followProfile,
                    currentProfile: currentProfile);
              }

            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  FollowButton({
    super.key,
    required this.followProfile,
    required this.currentProfile,
  });
  final ValueNotifier<bool> isEnablied = ValueNotifier<bool>(true);

  final ProfileEntity followProfile;
  final ProfileEntity currentProfile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: isEnablied,
                builder: (context, isEnabledBool, child) {
                  return CustomButton(
                    backgroundColor: InstagramColors.buttonColor,
                    radius: 7,
                    // contentPadding:
                    //     EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    text: "Follow",
                    onTap: isEnabledBool
                        ? () {
                            context.read<FollowBloc>().add(AddFollowEvent(
                                  followUser: FollowEntity.fromProfileEntity(
                                      followProfile),
                                  currentUser: FollowEntity.fromProfileEntity(
                                      currentProfile),
                                ));
                            isEnablied.value = false;
                          }
                        : () {},
                  );
                }),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: CustomButton(
              backgroundColor: InstagramColors.grey.withOpacity(0.3),
              textColor: Colors.black,
              radius: 7,
              // contentPadding:
              //     EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              width: MediaQuery.of(context).size.width / 2.w,
              onTap: () {
                context.read<MessageBloc>().add(GetConversationEvent(
                    currentUser: currentProfile,
                    participantUser: followProfile));
              },
              text: "Message",
            ),
          )
        ],
      ),
    );
  }
}

class FollowedButton extends StatelessWidget {
  FollowedButton({
    super.key,
    required this.followProfile,
    required this.currentProfile,
  });

  final ProfileEntity followProfile;
  final ProfileEntity currentProfile;
  final ValueNotifier<bool> isEnabled = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: isEnabled,
                builder: (context, isEnabledBool, child) {
                  return CustomButton(
                    backgroundColor: InstagramColors.grey.withOpacity(0.3),
                    textColor: Colors.black,
                    radius: 7,
                    // contentPadding:
                    //     EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    text: "Followed",
                    onTap: isEnabledBool
                        ? () {
                            isEnabled.value = false;
                            context.read<FollowBloc>().add(UnFollowEvent(
                                  unFollowUser: FollowEntity.fromProfileEntity(
                                      followProfile),
                                  currentUser: FollowEntity.fromProfileEntity(
                                      currentProfile),
                                ));
                          }
                        : () {},
                  );
                }),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: CustomButton(
              height: 30.h,
              backgroundColor: InstagramColors.grey.withOpacity(0.3),
              textColor: Colors.black,
              radius: 7,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              width: MediaQuery.of(context).size.width / 2.w,
              onTap: () {
                print("hello");
                context.read<MessageBloc>().add(GetConversationEvent(
                    currentUser: currentProfile,
                    participantUser: followProfile));
              },
              text: "Message",
            ),
          )
        ],
      ),
    );
  }
}
