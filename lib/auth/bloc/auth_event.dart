import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final Map<String, dynamic> data;

  const LoginEvent(
      {required this.email, required this.password, required this.data});
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  const SignUpEvent({required this.email, required this.password});
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

class AppStartEvent extends AuthEvent {
  const AppStartEvent();
}
