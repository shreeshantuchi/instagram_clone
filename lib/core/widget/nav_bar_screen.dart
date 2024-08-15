import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/widget/custom_button.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_state.dart';

import 'package:login_token_app/features/authentication/presentation/pages/reels_page/reels_page_screen.dart';
import 'package:login_token_app/features/feed/presentation/pages/feed_page/feed_page_screen.dart';
import 'package:login_token_app/features/feed/presentation/pages/add_page/add_page_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int currentIndex = 0; // Default to the FeedPageScreen

  final List<Widget> screens = const [
    FeedPageScreen(),
    AddPageScreen(),
    ReelsPageScreen(),
    ReelsPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        bool value = false;
        print(state);
        if (state is RenewRefreshtokenState) {
          await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Logged out"),
                  actions: [
                    CustomButton(
                      text: "Ok",
                      onTap: () {
                        value = true;
                        context.read<AuthBloc>().add(
                              const SignOutEvent(),
                            );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 1,
          color: Colors.white,
          child: SizedBox(
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                    currentIndex == 0
                        ? PhosphorIconsFill.house
                        : PhosphorIconsRegular.house,
                    0),
                _buildNavItem(
                    currentIndex == 1
                        ? PhosphorIconsBold.magnifyingGlass
                        : PhosphorIconsRegular.magnifyingGlass,
                    1),
                _buildNavItem(
                    currentIndex == 2
                        ? PhosphorIconsFill.plusSquare
                        : PhosphorIconsRegular.plusSquare,
                    2),
                _buildNavItem(
                    currentIndex == 3
                        ? PhosphorIconsFill.video
                        : PhosphorIconsRegular.video,
                    3),
                CircleAvatar(
                  radius: 11.r,
                  backgroundColor: InstagramColors.foregroundColor,
                  backgroundImage: const NetworkImage(
                      'https://imgs.search.brave.com/xJNs3Y0-T1-uTatUxa9yvG5oIyoorhWV4OsjepTe3x0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9w/ZXJzb24taG9sZGlu/Zy1jdXAtY29mZmVl/XzIzLTIxNTA2OTg3/MDMuanBnP3NpemU9/NjI2JmV4dD1qcGc'),
                ),
              ],
            ),
          ),
        ),
        body: screens[currentIndex],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = index; // Update the currentIndex to the tapped index
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: currentIndex == index
                  ? InstagramColors.navBarIconColor
                  : InstagramColors.navBarIconColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
