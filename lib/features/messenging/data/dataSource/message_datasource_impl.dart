import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_token_app/features/authentication/data/models/user.dart';
import 'package:login_token_app/features/messenging/data/dataSource/message_datasource.dart';
import 'package:login_token_app/features/messenging/data/model/conversation_model.dart';
import 'package:login_token_app/features/messenging/data/model/message_model.dart';
import 'package:login_token_app/features/userManagement/data/model/profile_model.dart';

class MessageDatasourceImpl implements MessageDatasource {
  @override
  Future<void> createMessage(
      MessageModel message, ConversationModel conversation) async {
    print(conversation.participants[0]);
    final messageRef = FirebaseFirestore.instance
        .collection("Profile")
        .doc(conversation.participants[0])
        .collection("Conversations")
        .doc(conversation.id)
        .collection("Messages")
        .doc();
    message.id = messageRef.id;
    await messageRef.set(message.toMap());
  }

  @override
  Future<ConversationModel> createConversation(
      ConversationModel conversation) async {
    final conversationsRef = FirebaseFirestore.instance
        .collection("Profile")
        .doc(conversation.participants[0])
        .collection("Conversations")
        .doc();
    conversation.id = conversationsRef.id;
    final conversationsRef2 = FirebaseFirestore.instance
        .collection("Profile")
        .doc(conversation.participants[1])
        .collection("Conversations")
        .doc(conversation.id);
    await conversationsRef2.set(conversation.toMap());
    await conversationsRef.set(conversation.toMap());
    return conversation;
  }

  Future<ConversationModel> getConversation(
      {required ProfileModel participateUser,
      required ProfileModel currentUser}) async {
    var conversatiolList = await FirebaseFirestore.instance
        .collection('Profile')
        .doc(currentUser.uid)
        .collection("Conversations")
        .where('participants', arrayContains: participateUser.uid)
        .get()
        .then((snapshot) => snapshot.docs
            .map((value) => ConversationModel.fromFirestore(value))
            .toList());

    try {
      print("im in");
      var filteredConversation = conversatiolList.firstWhere(
        (element) =>
            element.participants.contains(currentUser.uid) &&
            element.participants.contains(participateUser.uid),
      );
      print(filteredConversation.toMap());
      return filteredConversation;
    } catch (e) {
      print(e);
      return await createConversation(ConversationModel(
          id: "",
          participants: [currentUser.uid, participateUser.uid],
          createdAt: Timestamp.fromDate(DateTime.now()),
          conversationType: "single"));
    }
  }

  @override
  Future<void> createMediaMessage(MessageModel message,
      ConversationModel conversation, List<XFile> mediaList) async {
    String? downloadURL;

    // ignore: avoid_function_literals_in_foreach_calls
    mediaList.forEach((item) async {
      final messageRef = FirebaseFirestore.instance
          .collection("Profile")
          .doc(conversation.participants[0])
          .collection("Messages")
          .doc();
      message.id = messageRef.id;
      String filePath =
          '${message.senderId}/${message.conversationId}/media/${message.id}/${DateTime.now().microsecondsSinceEpoch}.jpg';
      File file = File(item.path);
      TaskSnapshot snapshot =
          await FirebaseStorage.instance.ref(filePath).putFile(file);
      downloadURL = await snapshot.ref.getDownloadURL();
      message.imageUrl = downloadURL;
      await messageRef.set(message.toMap());
    });
  }

  @override
  Stream<List<MessageModel>> getAllMessages(ConversationModel conversation) {
    print(conversation.id);
    var messageModelStream = FirebaseFirestore.instance
        .collection("Profile")
        .doc(conversation.participants[0])
        .collection("Conversations")
        .doc(conversation.id)
        .collection("Messages")
        .where('conversationId', isEqualTo: conversation.id)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((value) => MessageModel.fromFirestore(value))
            .toList());
    return messageModelStream;
  }

  @override
  Stream<List<ConversationModel>> getAllConversation(UserModel userModel) {
    var messageModelStream = FirebaseFirestore.instance
        .collection("Profile")
        .doc(userModel.uid)
        .collection("Conversations")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((value) => ConversationModel.fromFirestore(value))
            .toList());
    return messageModelStream;
  }

  @override
  Future<List<ConversationModel>> getAllConversationProfile(
      List<ConversationModel> conversation) async {
    final user = FirebaseAuth.instance.currentUser;
    List<String> participantId = conversation.map((conversation) {
      final participant = conversation.participants;
      List<String> tempParticipant = List.from(participant);
      tempParticipant.remove(user!.uid);
      final userId = tempParticipant.first;
      return userId;
    }).toList();

    final allProfileSnapshot = await FirebaseFirestore.instance
        .collection("Profile")
        .where(FieldPath.documentId, whereIn: participantId)
        .get();

    final profileList = allProfileSnapshot.docs
        .map(
          (snapshot) => ProfileModel.fromJson(
            snapshot.data(),
          ),
        )
        .toList();

    final converSationList = conversation.map((conv) {
      conv.profileEntity = profileList.firstWhere(
        (e) => conv.participants.contains(e.uid),
      );
      return conv;
    }).toList();

    return converSationList;
  }
}
