import 'package:flutter/material.dart';
import 'package:login_token_app/core/widget/custom_text_form_field.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.showPassword,
    required this.passwordController,
  });

  final ValueNotifier<bool> showPassword;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: showPassword,
        builder: (context, bool password, child) {
          return CustomTextFormField(
            onScureText: showPassword,
            iconList: const [PhosphorIconsBold.eye, PhosphorIconsBold.eyeSlash],
            controller: passwordController,
            hintText: "Password",
          );
        });
  }
}
