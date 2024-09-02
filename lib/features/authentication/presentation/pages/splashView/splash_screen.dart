import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/core/widget/nav_bar_screen.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_state.dart';
import 'package:login_token_app/features/authentication/presentation/pages/loginView/login_view.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/widget/loading_indicator.dart';
import 'package:login_token_app/features/feed/presentation/pages/dashBoard/main_dashboard_screen.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case OnLogInUnAuthenticatedState():
            break;
          case OnLogInAuthenticatedState():
            const snackbar = SnackBar(
              backgroundColor: AppPallet.loginSuccessColor,
              content: Text(
                "Logged In",
                style: TextStyle(color: AppPallet.whiteColor),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            break;
          case OnLoginFailureState():
            final snackbar = SnackBar(
              backgroundColor: AppPallet.loginFailureColor,
              content: Text(
                state.error,
                style: const TextStyle(color: AppPallet.whiteColor),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            break;
          case OnSignUpSuccessState():
            context.read<UserManagementBloc>().add(const SetProfileEvent());

          default:
            break;
        }
      },
      builder: (context, state) {
        print(state);
        switch (state) {
          case OnAuthLoadingState():
            return const LoadingIndicator(text: "Loading");
          case OnLogInAuthenticatedState():
            return const DashBoardPage();
          case OnAppStartLogInAuthenticatedState():
            return const DashBoardPage();
          case OnLoginFailureState():
            return const LoginView();
          case OnLogInUnAuthenticatedState():
            return const LoginView();
          case OnSignUpSuccessState():
            return const DashBoardPage();

          default:
            return const LoadingIndicator(text: "Initializing");
        }
      },
    );
  }
}

class InitializingView extends StatelessWidget {
  const InitializingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Initializzing"),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
