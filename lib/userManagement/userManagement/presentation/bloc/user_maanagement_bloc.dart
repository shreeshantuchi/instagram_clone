import 'package:bloc/bloc.dart';
import 'package:login_token_app/core/services/ApiService/api_service.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/userManagement/bloc/presentation/bloc/user_maanagement_event.dart';
import 'package:login_token_app/userManagement/bloc/presentation/bloc/user_management_state.dart';

class UserManagementBloc
    extends Bloc<UserMaanagementEvent, UserManagementState> {
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  ApiService apiService = ApiService();
  UserManagementBloc() : super(const InitialState()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoadingState());

      String? accessToken = await sharedPreferencesService.getAccessToken();
      Map<String, dynamic>? result = await apiService.sendGetRequest(
          accessToken!, "https://qa-ravenapi.ekbana.net/api/v1/user/profile");

      if (result != null) {
        emit(OnAllUserRetrivedState());
      } else {
        emit(OnUserRetrivedFailureState());
      }
    });
  }
}
