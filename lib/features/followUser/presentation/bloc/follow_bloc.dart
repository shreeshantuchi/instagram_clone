import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/features/followUser/domain/useCase/addFollowUseCase.dart';
import 'package:login_token_app/features/followUser/domain/useCase/doesFollowExistUSecase.dart';
import 'package:login_token_app/features/followUser/domain/useCase/unfollow_usecase.dart';
import 'package:login_token_app/features/followUser/presentation/bloc/follow_event.dart';
import 'package:login_token_app/features/followUser/presentation/bloc/follow_state.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_management_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final AddFollowUsecase followUsecase;
  final UnfollowFollowUsecase unfollowFollowUsecase;
  final Doesfollowexistusecase doesfollowexistusecase;
  FollowBloc(
      {required this.doesfollowexistusecase,
      required this.followUsecase,
      required this.unfollowFollowUsecase})
      : super(FollowInitialState()) {
    on<AddFollowEvent>(
      (event, emit) async {
        await followUsecase.call(
            currentUser: event.currentUser, followUser: event.followUser);
        emit(FollowUserState());
      },
    );
    on<InititalizeEvenet>(
      (event, emit) {
        emit(FollowInitialState());
      },
    );

    on<UnFollowEvent>(
      (event, emit) async {
        await unfollowFollowUsecase.call(
            currentUser: event.currentUser, followUser: event.unFollowUser);
        emit(UnFollowUserState());
      },
    );

    on<DoesFollowExistevent>(
      (event, emit) async {
        final isFollowed = await doesfollowexistusecase.call(
            currentUserId: event.currentUser.uid,
            followUserId: event.followUser.uid);
        emit(FollowExistState(isFollowed: isFollowed));
      },
    );
  }
}
