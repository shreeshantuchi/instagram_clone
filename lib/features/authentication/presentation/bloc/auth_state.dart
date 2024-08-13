import 'package:flutter/foundation.dart';
import 'package:login_token_app/features/authentication/data/models/auth_token_model.dart';

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
  const OnAppStartLogInAuthenticatedState() : super(null, null);
}

class OnLogInUnAuthenticatedState extends AuthState {
  const OnLogInUnAuthenticatedState() : super(null, null);
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

class RenewRefreshtokenState extends AuthState {
  const RenewRefreshtokenState() : super(null, '');
}
