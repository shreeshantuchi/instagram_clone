import 'package:image_picker/image_picker.dart';
import 'package:login_token_app/features/authentication/data/models/user.dart';
import 'package:login_token_app/features/messenging/data/model/conversation_model.dart';
import 'package:login_token_app/features/messenging/data/model/message_model.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';

abstract class MessageDatasource {
  Future<void> createMessage(
      MessageModel message, ConversationModel conversation);

  Future<void> createMediaMessage(MessageModel message,
      ConversationModel conversation, List<XFile> mediaList);

  Future<ConversationModel> createConversation(
    ConversationModel conversation,
  );

  Future<List<ConversationModel>> getAllConversationProfile(
      List<ConversationModel> conversation);
  Stream<List<MessageModel>> getAllMessages(ConversationModel conversation);
  Stream<List<ConversationModel>> getAllConversation(UserModel userModel);
}
