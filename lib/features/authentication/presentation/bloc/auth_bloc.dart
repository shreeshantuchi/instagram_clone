import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/features/authentication/domain/usecase/login_use_cases.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final GetStoredTokensUseCase getStoredTokensUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.getStoredTokensUseCase,
    required this.signOutUseCase,
  }) : super(const OnAuthInitialState()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(const OnAuthLoadingState());
        try {
          final user = await loginUseCase.call(event.data);
          if (user != null) {
            print(user.accessToken);
            emit(const OnAppStartLogInAuthenticatedState());
          } else {
            emit(const OnLogInUnAuthenticatedState());
          }
        } catch (e) {
          emit(const OnLoginFailureState(error: "Unable to Login"));
        }
      },
    );

    on<AppStartEvent>((event, emit) async {
      try {
        final user = await getStoredTokensUseCase.call();
        if (user != null) {
          print(user.accessToken);
          emit(const OnAppStartLogInAuthenticatedState());
        } else {
          emit(const OnLogInUnAuthenticatedState());
        }
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
