import 'package:bloc/bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_state.dart';
import 'package:login_token_app/core/constants/url/app_urls.dart';
import 'package:login_token_app/core/services/ApiService/api_service.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/data/model/user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthTokenModel? user;
  ApiService apiService = ApiService();
  SharedPreferencesService sharedPreferenceService = SharedPreferencesService();
  AuthBloc() : super(const OnAuthInitialState()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(const OnAuthLoadingState());
        Map<String, dynamic>? data = await apiService.sendPostRequest(
            event.data, baseUrl + loginEndpoint);
        if (data != null) {
          final AuthTokenModel user = AuthTokenModel.fromAPi(data);
          await sharedPreferenceService.saveAccessToken(user.access_token);
          await sharedPreferenceService.saveRefreshToken(user.refresh_token);
          print(user.refresh_token);

          emit(OnLogInAuthenticatedState(user));
        } else {
          emit(OnLoginFailureState(error: "Unable to Login"));
        }
      },
    );

    on<AppStartEvent>((event, emit) async {
      String? access_token = await sharedPreferenceService.getAccessToken();
      String? refresh_token = await sharedPreferenceService.getRefreshToken();
      print("refresh:$refresh_token");
      print("access:$access_token");
      if (access_token != null) {
        emit(OnAppStartLogInAuthenticatedState());
      } else {
        emit(OnLogInUnAuthenticactedState());
      }
    });

    on<SignOutEvent>((event, emit) async {
      emit(const OnAuthLoadingState());
      sharedPreferenceService.deleteTokens();

      emit(const OnLogInUnAuthenticactedState());
    });
  }
}
