import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/widget/custom_text_form_field.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';

import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_management_state.dart';
import 'package:login_token_app/features/userManagement/presentation/pages/profile_page/profile_page_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchPageScreen extends StatefulWidget {
  const SearchPageScreen({super.key});

  @override
  State<SearchPageScreen> createState() => _SearchPageScreenState();
}

class _SearchPageScreenState extends State<SearchPageScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomTextFormField(
                onTap: () {
                  context
                      .read<UserManagementBloc>()
                      .add(const SearchProfileEvent(searchText: " "));
                },
                onChanged: (value) {
                  context.read<UserManagementBloc>().add(SearchProfileEvent(
                      searchText: value.isEmpty ? " " : value));
                },
                leadingIcon: PhosphorIconsRegular.magnifyingGlass,
                hintText: "Search",
                controller: searchController),
            BlocBuilder<UserManagementBloc, UserManagementState>(
                builder: (context, state) {
              print(state);
              switch (state) {
                case OnSearchProfileRetrivedState():
                  final profileList = state.profileList;
                  print("xxx $profileList");
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: profileList.length,
                      itemBuilder: (context, index) {
                        final profile = profileList[index];
                        return ProfileTile(profile: profile);
                      });
                default:
                  return const SizedBox.shrink();
              }
            }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.profile,
  });

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePageScreen(
                      profileEntity: profile,
                    )));
      },
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                profile.photoUrl != null ? InstagramColors.grey : null,
          ),
          Column(
            children: [
              Text(profile.email),
              Text(profile.username),
            ],
          ),
        ],
      ),
    );
  }
}
