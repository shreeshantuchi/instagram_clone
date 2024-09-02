import 'package:image_picker/image_picker.dart';
import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/domain/entity/mesage_entity.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

abstract class MessageRepository {
  Future<void> createMessage(
      MessageEntity message, ConversationEntity conversation);

  Future<void> createMediaMessage(MessageEntity message,
      ConversationEntity conversation, List<XFile> mediaList);
  Future<ConversationEntity> getConversation(
      {required ProfileEntity currentUser,
      required ProfileEntity participantEntity});
  Stream<List<MessageEntity>> getAllMessages(ConversationEntity conversation);
  Stream<List<ConversationEntity>> getAllConversation(UserEntity userModel);
  Future<List<ConversationEntity>> getALlProfile(
      List<ConversationEntity> conversation);
}
