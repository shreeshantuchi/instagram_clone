import 'package:login_token_app/features/messenging/data/repository/message_repository_impl.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/domain/entity/mesage_entity.dart';

class CreateMessageUsecase {
  final MessageRepositoryImpl messageRepositoryImpl;

  CreateMessageUsecase({required this.messageRepositoryImpl});
  Future<void> call(
      {required MessageEntity message,
      required ConversationEntity conversation}) async {
    await messageRepositoryImpl.createMessage(message, conversation);
  }
}
