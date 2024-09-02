import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_token_app/features/authentication/data/models/user.dart';
import 'package:login_token_app/features/authentication/domain/enitites/user_entity.dart';
import 'package:login_token_app/features/messenging/data/dataSource/message_datasource.dart';
import 'package:login_token_app/features/messenging/data/dataSource/message_datasource_impl.dart';
import 'package:login_token_app/features/messenging/data/model/conversation_model.dart';
import 'package:login_token_app/features/messenging/data/model/message_model.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/domain/entity/mesage_entity.dart';
import 'package:login_token_app/features/messenging/domain/repository/message_repository.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageDatasourceImpl messageDatasourceImpl;

  MessageRepositoryImpl({required this.messageDatasourceImpl});
  @override
  Future<void> createMessage(
      MessageEntity message, ConversationEntity conversation) async {
    await messageDatasourceImpl.createMessage(
        MessageModel.fromMessageEntity(message),
        ConversationModel.fromConversationEntity(conversation));
  }

  @override
  Future<ConversationEntity> getConversation(
      {required ProfileEntity currentUser,
      required ProfileEntity participantEntity}) async {
    var conversationEntity = await messageDatasourceImpl.getConversation(
      currentUser: ProfileModel.fromProfileEntity(currentUser),
      participateUser: ProfileModel.fromProfileEntity(participantEntity),
    );

    return ConversationEntity.fromConversationModel(conversationEntity);
  }

  @override
  Future<void> createMediaMessage(MessageEntity message,
      ConversationEntity conversation, List<XFile> mediaList) async {
    messageDatasourceImpl.createMediaMessage(
        MessageModel.fromMessageEntity(message),
        ConversationModel.fromConversationEntity(conversation),
        mediaList);
  }

  @override
  Stream<List<MessageEntity>> getAllMessages(ConversationEntity conversation) {
    var messageModelStream = messageDatasourceImpl.getAllMessages(
      ConversationModel.fromConversationEntity(conversation),
    );
    return messageModelStream;
  }

  @override
  Stream<List<ConversationEntity>> getAllConversation(UserEntity userModel) {
    var conversationModelStream = messageDatasourceImpl
        .getAllConversation(UserModel.fromUserEntity(userModel));
    return conversationModelStream;
  }

  @override
  Future<List<ConversationEntity>> getALlProfile(
      List<ConversationEntity> conversation) async {
    final conversationEntityList = conversation
        .map((e) => ConversationModel.fromConversationEntity(e))
        .toList();
    final conversationModel = await messageDatasourceImpl
        .getAllConversationProfile(conversationEntityList);
    final convEntity = conversationModel
        .map((e) => ConversationEntity.fromConversationModel(e))
        .toList();

    return convEntity;
  }
}
