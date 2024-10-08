import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:login_token_app/core/widget/custom_button.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/core/constants/client_detials.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/widget/custom_text_form_field.dart';
import 'package:login_token_app/features/authentication/presentation/pages/loginView/widgets/forgot_password.dart';
import 'package:login_token_app/features/authentication/presentation/pages/loginView/widgets/password_textfield.dart';
import 'package:login_token_app/features/authentication/presentation/pages/loginView/widgets/sign_in_text.dart';

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
    return const Scaffold(
      body: Center(
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
    return SingleChildScrollView(
      child: SizedBox(
        height: 640.h,
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Text(
                  "Instagram",
                  style: instagramHeading.copyWith(fontSize: 42.sp),
                ),
              ),
              SizedBox(
                height: 36.h,
              ),
              CustomTextFormField(
                controller: emailController,
                hintText: "E-mail",
              ),
              const SizedBox(
                height: 20,
              ),
              PasswordField(
                  showPassword: showPassword,
                  passwordController: passwordController),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const ForgotPasswrod(),
              ),
              CustomButton(
                color: InstagramColors.buttonColor,
                onTap: () {
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
                text: "Log in",
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Text(
                  "Or",
                  style: instagramTextTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Log in with Facebook",
                style: instagramTextTheme.bodySmall!.copyWith(
                    color: InstagramColors.buttonColor,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const SignInText(),
            ],
          ),
        ),
      ),
    );
  }
}
