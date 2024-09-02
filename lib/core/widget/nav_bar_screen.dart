import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/widget/custom_button.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_state.dart';
import 'package:login_token_app/features/feed/presentation/pages/add_page/add_page_screen.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_management_state.dart';
import 'package:login_token_app/features/userManagement/presentation/pages/profile_page/profile_page_screen.dart';
import 'package:login_token_app/features/authentication/presentation/pages/reels_page/reels_page_screen.dart';
import 'package:login_token_app/features/feed/presentation/pages/feed_page/feed_page_screen.dart';
import 'package:login_token_app/features/userManagement/presentation/pages/search_page/search_page_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Cached profile screen
  Widget? _profilePage;

  final List<Widget> _screens = [
    const FeedPageScreen(),
    const SearchPageScreen(),
    const AddPageScreen(),
    const ReelsPageScreen(),
    const Scaffold(), // Placeholder for ProfilePageScreen
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
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
                      context.read<AuthBloc>().add(const SignOutEvent());
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
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
                    _currentIndex == 0
                        ? PhosphorIconsFill.house
                        : PhosphorIconsRegular.house,
                    0),
                _buildNavItem(
                    _currentIndex == 1
                        ? PhosphorIconsBold.magnifyingGlass
                        : PhosphorIconsRegular.magnifyingGlass,
                    1),
                _buildNavItem(
                    _currentIndex == 2
                        ? PhosphorIconsFill.plusSquare
                        : PhosphorIconsRegular.plusSquare,
                    2),
                _buildNavItem(
                    _currentIndex == 3
                        ? PhosphorIconsFill.video
                        : PhosphorIconsRegular.video,
                    3),
                GestureDetector(
                  onTap: () {
                    // Load the profile page if not already cached
                    if (_profilePage == null) {
                      context
                          .read<UserManagementBloc>()
                          .add(const GetCurrentUserEvent());
                    }

                    setState(() {
                      _currentIndex = 4;
                      _pageController.jumpToPage(_currentIndex);
                    });
                  },
                  child: CircleAvatar(
                    radius: 11.r,
                    backgroundColor: InstagramColors.grey,
                    backgroundImage: const NetworkImage(
                        'https://imgs.search.brave.com/xJNs3Y0-T1-uTatUxa9yvG5oIyoorhWV4OsjepTe3x0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9w/ZXJzb24taG9sZGlu/Zy1jdXAtY29mZmVl/XzIzLTIxNTA2OTg3/MDMuanBnP3NpemU9/NjI2JmV4dD1qcGc'),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<UserManagementBloc, UserManagementState>(
          builder: (context, state) {
            if (state is OnCurrentUserProfileRetrivedState) {
              // Cache the profile page once it is retrieved
              _profilePage = ProfilePageScreen(profileEntity: state.profile);
            }

            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: _screens.map((screen) {
                if (screen is Scaffold && _currentIndex == 4) {
                  return _profilePage!;
                }
                return screen;
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddPageScreen()));
          } else {
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: _currentIndex == index
                  ? InstagramColors.navBarIconColor
                  : InstagramColors.navBarIconColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
