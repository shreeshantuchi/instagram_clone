import 'package:login_token_app/features/messenging/data/dataSource/message_datasource.dart';
import 'package:login_token_app/features/messenging/data/model/conversation_model.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/domain/repository/message_repository.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

class GetProfileConversationUsecase {
  final MessageRepository messageRepository;

  GetProfileConversationUsecase({required this.messageRepository});

  Future<List<ConversationEntity>> call(
      List<ConversationEntity> conversations) async {
    final conversation = await messageRepository.getALlProfile(conversations);
    return conversation;
  }
}
