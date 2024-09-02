import 'package:flutter/foundation.dart';
import 'package:login_token_app/features/messenging/data/model/message_model.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/domain/entity/mesage_entity.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

@immutable
abstract class MessageState {
  final MessageModel? message;

  const MessageState({required this.message});
}

class OnMessageinitialState extends MessageState {
  const OnMessageinitialState() : super(message: null);
}

class OnMessageLoadingState extends MessageState {
  const OnMessageLoadingState() : super(message: null);
}

class OnConversationFetchedState extends MessageState {
  final ConversationEntity conversation;
  const OnConversationFetchedState(this.conversation) : super(message: null);
}

class OnMessageCreatedState extends MessageState {
  final MessageEntity newMessage;
  const OnMessageCreatedState(this.newMessage) : super(message: null);
}

class OnAllMessageRetrivedState extends MessageState {
  final Stream<List<MessageEntity>> messageListStream;
  const OnAllMessageRetrivedState(this.messageListStream)
      : super(message: null);
}

class OnAllCOnversationRetrivedState extends MessageState {
  final Stream<List<ConversationEntity>> conversationListStream;
  const OnAllCOnversationRetrivedState(this.conversationListStream)
      : super(message: null);
}

class OnAllCOnversationProfileRetrivedState extends MessageState {
  final List<ConversationEntity> conversationList;
  const OnAllCOnversationProfileRetrivedState(this.conversationList)
      : super(message: null);
}

class OnConversationRetrived extends MessageState {
  final ConversationEntity conversationModel;
  const OnConversationRetrived(this.conversationModel) : super(message: null);
}

class OnMessageRetriveFailureState extends MessageState {
  const OnMessageRetriveFailureState() : super(message: null);
}

class OnConversationRetrivedFailureState extends MessageState {
  final ConversationEntity conversationModel;
  const OnConversationRetrivedFailureState(this.conversationModel)
      : super(message: null);
}
