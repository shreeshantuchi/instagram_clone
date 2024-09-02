import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/domain/repository/message_repository.dart';

class GetAllConversationUsecase {
  final MessageRepository messageRepository;

  GetAllConversationUsecase({required this.messageRepository});
  Stream<List<ConversationEntity>> call(UserEntity user) {
    final convStream = messageRepository.getAllConversation(user);
    return convStream;
  }
}
