import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/core/widget/nav_bar_screen.dart';
import 'package:login_token_app/features/messenging/presentation/pages/conversation_view/conversation_view.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_management_state.dart';
import 'package:login_token_app/features/userManagement/presentation/pages/search_page/search_page_screen.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final PageController _pageController = PageController(initialPage: 1);
  final List<Widget> _screens = [
    const SearchPageScreen(),
    const NavBarScreen(),
    const ConversationView(),
  ];

  Widget? _cachedWidget;

  @override
  void initState() {
    context.read<UserManagementBloc>().add(const GetCurrentUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagementBloc, UserManagementState>(
      builder: (context, state) {
        // Cache the widget only if the desired state is retrieved
        if (state is OnCurrentUserProfileRetrivedState &&
            _cachedWidget == null) {
          context.read<UserManagementBloc>().add(GetAllProfileEvent());
          _cachedWidget = PageView(
            controller: _pageController,
            onPageChanged: (index) {},
            children: _screens,
          );
        }

        // Return the cached widget if it exists
        return _cachedWidget ??
            const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
      },
    );
  }
}
