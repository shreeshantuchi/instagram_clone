import 'package:login_token_app/features/followUser/data/dataSource/follower_datasource_impl.dart';
import 'package:login_token_app/features/followUser/data/repository/followUser_repository_impl.dart';
import 'package:login_token_app/features/followUser/domain/useCase/addFollowUseCase.dart';
import 'package:login_token_app/features/followUser/domain/useCase/doesFollowExistUSecase.dart';
import 'package:login_token_app/features/followUser/domain/useCase/unfollow_usecase.dart';
import 'package:login_token_app/features/followUser/presentation/bloc/follow_bloc.dart';

Future<FollowBloc> createFollowBloc() async {
  final remoteDataSource = FollowUserDataSourceImpl();

  final remoteRepository =
      FollowuserRepositoryImpl(followUserDataSource: remoteDataSource);

  final followUsecase =
      AddFollowUsecase(followuserRepository: remoteRepository);
  final unfollowFollowUsecase =
      UnfollowFollowUsecase(followuserRepository: remoteRepository);
  final doesfollowexistusecase =
      Doesfollowexistusecase(followuserRepository: remoteRepository);

  return FollowBloc(
      doesfollowexistusecase: doesfollowexistusecase,
      followUsecase: followUsecase,
      unfollowFollowUsecase: unfollowFollowUsecase);
}
