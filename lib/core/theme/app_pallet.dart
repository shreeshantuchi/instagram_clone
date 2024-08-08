import 'package:flutter/material.dart';

class AppPallet {
  static const greyBorderColor = Colors.grey;
  static const backgroundColor = Color(0xff17171E);
  static const loginSuccessColor = Colors.greenAccent;
  static const loginFailureColor = Colors.red;
  static const whiteColor = Colors.white;
  static final whiteColor60 = Colors.white.withOpacity(0.5);
  static const focusColor = Colors.purpleAccent;
  static const redColor = Color(0xffff3040);
  static const blueColor = Color(0xff1C58D9);
  static const buttonColor = Color(0xff0095f6);
}

class InstagramColors {
  static const Color buttonColor = Color(0xff4cb5f9);
  static const Color likeColor = Color(0xffff3040);
  static const Color pink = Color(0xFFE1306C);
  static const Color purple = Color(0xFFC13584);
  static const Color orange = Color(0xFFF56040);
  static const Color yellow = Color(0xFFFCAF45);
  static const Color blue = Color(0xFF0077B5);

  // Gradient color
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF58529),
      Color(0xFFDD2A7B),
      Color(0xFF8134AF),
      Color(0xFF515BD4),
    ],
    stops: [0.1, 0.4, 0.6, 0.9],
  );

  // Additional shades for more design options
  static const Color blueLight = Color(0xFF9CD9F7);
  static const Color blueDark = Color(0xFF0D47A1);
  static const Color grey = Color(0xFFB1B1B1);
  static Color textFieldColor = grey.withOpacity(0.1);
  static const Color foregroundColor = Color(0xFFFFFFFF);
  static const Color navBarIconColor = Color(0xFF000000);
}
