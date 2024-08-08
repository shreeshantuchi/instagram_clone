// ignore_for_file: overridden_fields

import 'package:flutter/foundation.dart';
import 'package:login_token_app/data/model/user.dart';

@immutable
abstract class AuthState {
  final AuthTokenModel? user;
  final String? error;
  const AuthState(this.user, this.error);
}

class OnAuthInitialState extends AuthState {
  const OnAuthInitialState() : super(null, null);
}

class OnAuthLoadingState extends AuthState {
  const OnAuthLoadingState() : super(null, null);
}

class OnLogInAuthenticatedState extends AuthState {
  final AuthTokenModel userSuccess;

  const OnLogInAuthenticatedState(this.userSuccess) : super(userSuccess, null);
}

class OnAppStartLogInAuthenticatedState extends AuthState {
  OnAppStartLogInAuthenticatedState() : super(null, null);
}

class OnLogInUnAuthenticactedState extends AuthState {
  const OnLogInUnAuthenticactedState() : super(null, null);
}

class OnLoginFailureState extends AuthState {
  @override
  final String error;

  const OnLoginFailureState({required this.error}) : super(null, error);
}

class OnSignUpFailureState extends AuthState {
  @override
  final String error;

  const OnSignUpFailureState({required this.error}) : super(null, error);
}

class OnSignUpSuccessState extends AuthState {
  const OnSignUpSuccessState() : super(null, '');
}
