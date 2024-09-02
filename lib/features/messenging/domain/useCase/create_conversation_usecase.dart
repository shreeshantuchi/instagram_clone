import 'package:login_token_app/features/messenging/data/repository/message_repository_impl.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

class GetConversationUseCase {
  final MessageRepositoryImpl messageRepositoryImpl;

  GetConversationUseCase({required this.messageRepositoryImpl});
  Future<ConversationEntity> call(
      {required ProfileEntity currentUser,
      required ProfileEntity participantEntity}) async {
    var conversationEntity = await messageRepositoryImpl.getConversation(
        currentUser: currentUser, participantEntity: participantEntity);
    print(" conversationrepository ${conversationEntity.id}");
    return conversationEntity;
  }
}
