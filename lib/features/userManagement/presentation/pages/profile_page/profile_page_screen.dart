import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_event.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_state.dart';
import 'package:login_token_app/features/followUser/domain/entity/follow_entity.dart';
import 'package:login_token_app/features/followUser/presentation/bloc/follow_bloc.dart';
import 'package:login_token_app/features/followUser/presentation/bloc/follow_event.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';

import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_management_state.dart';
import 'package:login_token_app/features/userManagement/presentation/widgets/all_user_post.dart';
import 'package:login_token_app/features/userManagement/presentation/widgets/current_user_profile_button_row.dart';
import 'package:login_token_app/features/userManagement/presentation/widgets/current_username_row.dart';
import 'package:login_token_app/features/userManagement/presentation/widgets/profile_and_follow_row.dart';
import 'package:login_token_app/features/userManagement/presentation/widgets/profile_button_row.dart';
import 'package:login_token_app/features/userManagement/presentation/widgets/profile_username_row.dart';

class ProfilePageScreen extends StatefulWidget {
  final ProfileEntity profileEntity;
  const ProfilePageScreen({super.key, required this.profileEntity});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  @override
  void initState() {
    print("Xxx");
    context
        .read<UserManagementBloc>()
        .add(GetProfileEvent(widget.profileEntity.uid));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<FollowBloc>().add(InititalizeEvenet());
    context.read<FeedBloc>().add(GetUserPostEvent(user: widget.profileEntity));
    final currentUserEntity = context.read<AuthBloc>().state.user!;
    final profile = ProfileEntity.fromProfileModel(
      ProfileModel.fromUserEntity(currentUserEntity),
    );
    context.read<FollowBloc>().add(
          DoesFollowExistevent(
            followUser: FollowEntity.fromProfileEntity(widget.profileEntity),
            currentUser: FollowEntity.fromProfileEntity(
              profile,
            ),
          ),
        );
    return BlocBuilder<UserManagementBloc, UserManagementState>(
      builder: (context, state) {
        if (state is OnUserProfileRetrivedState) {
          return Scaffold(
            body: SafeArea(
              child: ProfileColumn(
                currentProfile: profile,
                iscurrentProfile: widget.profileEntity.uid == profile.uid,
                profile: widget.profileEntity,
              ),
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}

class ProfileColumn extends StatelessWidget {
  final ProfileEntity profile;
  final ProfileEntity currentProfile;
  final bool iscurrentProfile;
  const ProfileColumn(
      {super.key,
      required this.profile,
      required this.iscurrentProfile,
      required this.currentProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              iscurrentProfile
                  ? CurrentUserUserNameRow(
                      username: profile.username,
                    )
                  : ProfileUserUserNameRow(username: profile.username),
              SizedBox(
                height: 10.h,
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Profile")
                      .doc(profile.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        return ProfileAndFollowerRow(
                          imgUrl: "",
                          profileEntity: ProfileModel.fromJson(
                              snapshot.data!.data() as Map<String, dynamic>),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
              SizedBox(
                height: 10.h,
              ),
              iscurrentProfile
                  ? const CurrentUserButtonRow()
                  : ProfileButtonRow(
                      currentProfile: currentProfile,
                      followProfile: profile,
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if (state is UserFeedLoadedState) {
              return UserPostsGridView(
                usePost: state.postList,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        )
      ],
    );
  }
}
