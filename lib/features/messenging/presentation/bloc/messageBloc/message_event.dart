import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/domain/entity/mesage_entity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

@immutable
abstract class MessageEvent {
  final MessageEntity? message;

  const MessageEvent({required this.message});
}

// ignore: must_be_immutable
class CreateMessageEvent extends MessageEvent {
  @override
  final MessageEntity message;
  final ConversationEntity conversationEntity;

  const CreateMessageEvent({
    required this.conversationEntity,
    required this.message,
  }) : super(message: message);
}

class CreateMediaMessageEvent extends MessageEvent {
  final List<XFile> mediaList;
  @override
  final MessageEntity message;

  const CreateMediaMessageEvent({
    required this.message,
    required this.mediaList,
  }) : super(message: message);
}

class CreateConversationEvent extends MessageEvent {
  final ConversationEntity conversation;
  const CreateConversationEvent(this.conversation) : super(message: null);
}

class GetAllMessageevent extends MessageEvent {
  final ConversationEntity conversation;
  const GetAllMessageevent(this.conversation) : super(message: null);
}

class GetAllConversationEvent extends MessageEvent {
  final UserEntity userEntity;
  const GetAllConversationEvent(this.userEntity) : super(message: null);
}

class GetConversationEvent extends MessageEvent {
  final ProfileEntity currentUser;
  final ProfileEntity participantUser;
  const GetConversationEvent(
      {required this.currentUser, required this.participantUser})
      : super(message: null);
}

class GetALlConversationProfileEvent extends MessageEvent {
  final List<ConversationEntity> conversations;

  const GetALlConversationProfileEvent({
    required this.conversations,
  }) : super(message: null);
}
