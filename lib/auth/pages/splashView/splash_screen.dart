import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/auth/bloc/auth_bloc.dart';
import 'package:login_token_app/auth/bloc/auth_state.dart';
import 'package:login_token_app/auth/pages/homeView/home_view.dart';
import 'package:login_token_app/auth/pages/loginView/login_view.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/widget/loading_indicator.dart';
import 'package:login_token_app/main.dart';

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
          case OnLogInUnAuthenticactedState():
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
          default:
            break;
        }
      },
      builder: (context, state) {
        print(state);
        switch (state) {
          case OnAuthLoadingState():
            return LoadingIndicator(text: "Loading");
          case OnLogInAuthenticatedState():
            return MyHomePage(title: "ggg");
          case OnAppStartLogInAuthenticatedState():
            return MyHomePage(title: "ggg");
          case OnLoginFailureState():
            return LoginView();
          case OnLogInUnAuthenticactedState():
            return LoginView();

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
