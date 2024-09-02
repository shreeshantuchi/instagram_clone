import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_token_app/features/messenging/domain/entity/mesage_entity.dart';

class MessageModel extends MessageEntity {
  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      conversationId: data['conversationId'],
      senderId: data['senderId'],
      content: data['content'],
      timestamp: data['timestamp'],
      messageType: data['messageType'],
      imageUrl: data['imageUrl'],
    );
  }

  MessageModel(
      {required super.conversationId,
      required super.senderId,
      required super.content,
      required super.timestamp,
      required super.messageType,
      required super.id,
      required super.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversationId': conversationId,
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp,
      'messageType': messageType,
      'imageUrl': imageUrl,
    };
  }

  factory MessageModel.fromMessageEntity(MessageEntity message) {
    return MessageModel(
        conversationId: message.conversationId,
        senderId: message.senderId,
        content: message.content,
        timestamp: message.timestamp,
        messageType: message.messageType,
        id: message.id,
        imageUrl: message.imageUrl);
  }
}
