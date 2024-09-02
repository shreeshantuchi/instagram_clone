import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_token_app/features/messenging/data/model/message_model.dart';

class MessageEntity {
   String? id;
  final String conversationId;
  final String senderId;
  final String? content;
  final Timestamp timestamp;
  final String? messageType;
   String? imageUrl;

  MessageEntity({
    this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.messageType,
    this.imageUrl,
  });

  factory MessageEntity.fromMessageEntity(MessageModel message) {
    return MessageEntity(
        conversationId: message.conversationId,
        senderId: message.senderId,
        content: message.content,
        timestamp: message.timestamp,
        messageType: message.messageType,
        id: message.id,
        imageUrl: message.imageUrl);
  }
}
