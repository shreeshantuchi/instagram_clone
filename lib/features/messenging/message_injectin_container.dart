import 'package:login_token_app/features/messenging/data/dataSource/message_datasource_impl.dart';
import 'package:login_token_app/features/messenging/data/repository/message_repository_impl.dart';
import 'package:login_token_app/features/messenging/domain/useCase/create_conversation_usecase.dart';
import 'package:login_token_app/features/messenging/domain/useCase/create_message_usecase.dart';
import 'package:login_token_app/features/messenging/domain/useCase/get_all_conversation_usecase.dart';
import 'package:login_token_app/features/messenging/domain/useCase/get_all_message_usecase.dart';
import 'package:login_token_app/features/messenging/domain/useCase/get_profile_conversation_usecase.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_bloc.dart';

Future<MessageBloc> createMessageBloc() async {
  final remoteDataSource = MessageDatasourceImpl();

  final remoteRepository =
      MessageRepositoryImpl(messageDatasourceImpl: remoteDataSource);

  final createMessageUsecase =
      CreateMessageUsecase(messageRepositoryImpl: remoteRepository);
  final createConversationUsecase =
      GetConversationUseCase(messageRepositoryImpl: remoteRepository);
  final getAllConvesationUsecase =
      GetAllConversationUsecase(messageRepository: remoteRepository);
  final getAllMessageUsecase =
      GetAllMessageUsecase(messageRepositoryImpl: remoteRepository);
  final getProfileConversationUsecase =
      GetProfileConversationUsecase(messageRepository: remoteRepository);

  return MessageBloc(
    createMessageUsecase,
    createConversationUsecase,
    getAllMessageUsecase,
    getAllConvesationUsecase,
    getProfileConversationUsecase,
  );
}
