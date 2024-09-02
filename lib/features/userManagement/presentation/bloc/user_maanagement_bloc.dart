import 'package:bloc/bloc.dart';
import 'package:login_token_app/core/services/ApiService/api_service.dart';
import 'package:login_token_app/core/services/sharedPreference/shared_preference_service.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:login_token_app/features/userManagement/domain/usecase/get_all_profile_usecase.dart';
import 'package:login_token_app/features/userManagement/domain/usecase/get_current_user_usecase.dart';
import 'package:login_token_app/features/userManagement/domain/usecase/get_user_usecase.dart';
import 'package:login_token_app/features/userManagement/domain/usecase/search_profile_usecase.dart';
import 'package:login_token_app/features/userManagement/domain/usecase/set_profile_usecase.dart';

import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_management_state.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final SetProfileUsecase setProfileUsecase;
  final SearchProfileUsecase searchProfileUsecase;
  final GetAllProfileUsecase getAllProfileUsecase;
  final GetProfileUsecase getProfileUsecase;
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();
  ApiService apiService = ApiService();
  UserManagementBloc({
    required this.getProfileUsecase,
    required this.getAllProfileUsecase,
    required this.getCurrentUserUsecase,
    required this.setProfileUsecase,
    required this.searchProfileUsecase,
  }) : super(const InitialState()) {
    on<GetProfileEvent>((event, emit) async {
      final profile = await getProfileUsecase.call(event.uid);
      print(profile.followerCount);
      emit(OnUserProfileRetrivedState(profile: profile));
    });

    on<SetProfileEvent>((event, emit) async {
      emit(UserLoadingState());
      await setProfileUsecase.call();
      emit(OnProfileAddedState());
    });

    on<GetAllProfileEvent>((event, emit) async {
      emit(UserLoadingState());
      await getAllProfileUsecase.call();
      emit(OnProfileAddedState());
    });

    on<SearchProfileEvent>((event, emit) async {
      final profileList = await searchProfileUsecase.call(event.searchText);
      print("profilelIst:   $profileList");
      emit(OnSearchProfileRetrivedState(profileList: profileList));
    });

    on<GetCurrentUserEvent>((event, emit) async {
      print("called");
      final profile = await getCurrentUserUsecase.call();

      print("profilelIst:   ${profile.username}");
      emit(OnCurrentUserProfileRetrivedState(profile: profile));
    });
  }
}
