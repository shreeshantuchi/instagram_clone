import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/auth/bloc/auth_bloc.dart';
import 'package:login_token_app/auth/bloc/auth_event.dart';
import 'package:login_token_app/auth/bloc/auth_state.dart';
import 'package:login_token_app/auth/pages/splashView/splash_screen.dart';
import 'package:login_token_app/core/services/ApiService/api_service.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/core/widget/custom_button.dart';
import 'package:login_token_app/userManagement/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/userManagement/bloc/user_maanagement_event.dart';
import 'package:login_token_app/userManagement/bloc/user_management_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    context.read<UserManagementBloc>().add(GetUserEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather6
    // than having to individually change instances of widgets.
    return BlocListener<UserManagementBloc, UserManagementState>(
      listener: (event, state) async {
        print(state);
        if (state is OnUserRetrivedFailureState) {
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("log out"),
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
                              builder: (context) => SplashScreen()),
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
    body: Center(
      child: Text("Logged in"),
      //  // This trailing comma makes auto-formatting nicer for build methods.
    ),
  );
}
