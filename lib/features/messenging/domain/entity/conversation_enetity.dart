import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_token_app/features/messenging/data/model/conversation_model.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

class ConversationEntity {
  String id;
  final List<String> participants;
  final Timestamp createdAt;
  final String conversationType;
  ProfileEntity? profileEntity;

  ConversationEntity({
    required this.profileEntity,
    required this.id,
    required this.participants,
    required this.createdAt,
    required this.conversationType,
  });

  factory ConversationEntity.fromConversationModel(
      ConversationModel conversationModel) {
    return ConversationEntity(
        id: conversationModel.id,
        participants: conversationModel.participants,
        createdAt: conversationModel.createdAt,
        conversationType: conversationModel.conversationType,
        profileEntity: conversationModel.profileEntity);
  }
}
