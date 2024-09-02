import 'package:login_token_app/features/messenging/data/repository/message_repository_impl.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/domain/entity/mesage_entity.dart';

class GetAllMessageUsecase {
  final MessageRepositoryImpl messageRepositoryImpl;

  GetAllMessageUsecase({required this.messageRepositoryImpl});
  Stream<List<MessageEntity>> call(ConversationEntity conversation) {
    var messageListStream = messageRepositoryImpl.getAllMessages(conversation);
    return messageListStream;
  }
}
