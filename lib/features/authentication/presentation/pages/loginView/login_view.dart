import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/core/constants/client_detials.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/widget/custom_text_form_field.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginView extends StatefulWidget {
  static String pathName = "loginView";
  static String routeName = "/loginView";
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: const Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    emailController.text = "9843141624";
    passwordController.text = "123Admin@";
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  ValueNotifier<bool> showPassword = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign In",
            style: TextStyle(
                color: AppPallet.whiteColor,
                fontSize: 36,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextFormField(
            controller: emailController,
            hintText: "E-mail",
          ),
          const SizedBox(
            height: 20,
          ),
          ValueListenableBuilder(
              valueListenable: showPassword,
              builder: (context, bool password, child) {
                return CustomTextFormField(
                  onScureText: showPassword,
                  iconList: const [
                    PhosphorIconsBold.eye,
                    PhosphorIconsBold.eyeSlash
                  ],
                  controller: passwordController,
                  hintText: "Password",
                );
              }),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    LoginEvent(
                        email: emailController.text,
                        password: passwordController.text,
                        data: {
                          "client_id": ClientDetials.clientId,
                          "client_secret": ClientDetials.clientSecrets,
                          "username": "+977-${emailController.text}",
                          "password": passwordController.text,
                          "grant_type": "password"
                        }),
                  );
            },
            child: const Text("Login"),
          ),
          GestureDetector(
            onTap: () {},
            child: RichText(
              text: TextSpan(
                  text: "Need a account ?",
                  style: Theme.of(context).textTheme.labelMedium,
                  children: [
                    TextSpan(
                        text: " Sign In",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: AppPallet.blueColor,
                                fontWeight: FontWeight.bold)),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
