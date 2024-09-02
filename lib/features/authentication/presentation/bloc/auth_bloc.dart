import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/features/authentication/domain/usecase/login_use_case_firebase.dart';
import 'package:login_token_app/features/authentication/domain/usecase/login_use_cases.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //final LoginUseCase loginUseCase;
  final FirebaseLoginUseCase loginUseCase;
  final FirebaseSignOutUseCase signOutUseCase;
  final FirebaseSignUpUseCase signUpUseCase;
  final FirebaseCurrentUserUseCase getCurrentUserUsecase;
  AuthBloc({
    required this.getCurrentUserUsecase,
    required this.signUpUseCase,
    required this.loginUseCase,
    required this.signOutUseCase,
  }) : super(const OnAuthInitialState()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(const OnAuthLoadingState());
        try {
          //final user = await loginUseCase.call(event.data);
          final user = await loginUseCase.call(event.email, event.password);
          emit(OnAppStartLogInAuthenticatedState(userSuccess: user));
        } catch (e) {
          emit(const OnLoginFailureState(error: "Unable to Login"));
        }
      },
    );

    on<SignUpEvent>(
      (event, emit) async {
        emit(const OnAuthLoadingState());
        try {
          emit(const OnAuthLoadingState());
          //final user = await loginUseCase.call(event.data);
          final user = await signUpUseCase.call(event.email, event.password);
          //print("user:::::::::: $user");
          emit(OnSignUpSuccessState(user));
        } catch (e) {
          emit(const OnLoginFailureState(error: "Unable to Login"));
        }
      },
    );

    on<AppStartEvent>((event, emit) async {
      try {
        final user = getCurrentUserUsecase.call();

        emit(OnAppStartLogInAuthenticatedState(userSuccess: user));
      } catch (e) {
        emit(const OnLogInUnAuthenticatedState());
      }
    });

    on<SignOutEvent>((event, emit) async {
      emit(const OnAuthLoadingState());
      await signOutUseCase.call();
      emit(const OnLogInUnAuthenticatedState());
    });

    on<RefereshTokenExpiredEvent>((event, emit) {
      emit(const RenewRefreshtokenState());
    });
  }
}
