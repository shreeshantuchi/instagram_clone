import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_token_app/core/services/ApiService/api_service.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/core/widget/custom_button.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/pages/splashView/splash_screen.dart';
import 'package:login_token_app/features/userManagement/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/features/userManagement/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/bloc/user_management_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiService apiService = ApiService();
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  @override
  void initState() {
    context.read<UserManagementBloc>().add(const GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserManagementBloc, UserManagementState>(
      listener: (event, state) async {
        if (state is OnUserRetrivedFailureState) {
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Log out"),
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
        }
      },
      child: scaffoldBody(context),
    );
  }
}

Scaffold scaffoldBody(BuildContext context) {
  return Scaffold(
    drawer: Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [],
          ),
          CustomButton(
            text: "Sign Out",
            onTap: () {
              context.read<AuthBloc>().add(
                    const SignOutEvent(),
                  );
            },
          )
        ],
      ),
    ),
    appBar: AppBar(),
    body: const Center(
      child: Text("Logged in"),
      //  // This trailing comma makes auto-formatting nicer for build methods.
    ),
  );
}
