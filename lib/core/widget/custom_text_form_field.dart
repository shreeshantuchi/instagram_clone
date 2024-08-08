import 'package:flutter/material.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final ValueNotifier<bool>? onScureText;
  final List<IconData>? iconList;
  final TextInputType textInputType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Key? formKey;
  final VoidCallback? onTap;
  final double? contentPadding;
  final double? borderRadius;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.onScureText,
    this.textInputType = TextInputType.name,
    required this.controller,
    this.iconList,
    this.formKey,
    this.validator,
    this.onTap,
    this.contentPadding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      validator: validator,
      style: Theme.of(context).textTheme.labelSmall,
      key: formKey,
      keyboardType: textInputType,
      controller: controller,
      obscureText: onScureText != null ? onScureText!.value : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: InstagramColors.textFieldColor,
        contentPadding: contentPadding != null
            ? EdgeInsets.symmetric(
                vertical: contentPadding! / 2, horizontal: contentPadding!)
            : null,
        suffixIcon: iconList != null
            ? IconButton(
                icon: Icon(onScureText!.value ? iconList![1] : iconList![0]),
                onPressed: () {
                  onScureText!.value = !onScureText!.value;
                },
              )
            : null,
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: hintText,
      ),
    );
  }
}
