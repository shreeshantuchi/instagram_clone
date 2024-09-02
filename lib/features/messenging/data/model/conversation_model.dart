import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel(
      {required super.id,
      required super.participants,
      required super.createdAt,
      required super.conversationType,
      super.profileEntity});

  // Factory constructor to create a Conversation instance from Firestore document
  factory ConversationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ConversationModel(
      profileEntity: null,
      id: doc.id,
      participants: List<String>.from(data['participants']),
      createdAt: data['createdAt'],
      conversationType: data['conversationType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participants': participants,
      'createdAt': createdAt,
      'conversationType': conversationType,
    };
  }

  factory ConversationModel.fromConversationEntity(
      ConversationEntity conversationModel) {
    return ConversationModel(
      profileEntity: conversationModel.profileEntity,
      id: conversationModel.id,
      participants: conversationModel.participants,
      createdAt: conversationModel.createdAt,
      conversationType: conversationModel.conversationType,
    );
  }
}
