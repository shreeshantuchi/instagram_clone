import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_token_app/features/messenging/domain/useCase/create_conversation_usecase.dart';
import 'package:login_token_app/features/messenging/domain/useCase/create_message_usecase.dart';
import 'package:login_token_app/features/messenging/domain/useCase/get_all_conversation_usecase.dart';
import 'package:login_token_app/features/messenging/domain/useCase/get_all_message_usecase.dart';
import 'package:login_token_app/features/messenging/domain/useCase/get_profile_conversation_usecase.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_state.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_event.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final CreateMessageUsecase createMessageUsecase;
  final GetConversationUseCase getConversationUsecase;
  final GetAllMessageUsecase getAllMessageUsecase;
  final GetAllConversationUsecase getAllConvesationUsecase;
  final GetProfileConversationUsecase getProfileConversationUsecase;
  MessageBloc(
      this.createMessageUsecase,
      this.getConversationUsecase,
      this.getAllMessageUsecase,
      this.getAllConvesationUsecase,
      this.getProfileConversationUsecase)
      : super(const OnMessageinitialState()) {
    on<GetConversationEvent>(
      (event, emit) async {
        var conversationEntity = await getConversationUsecase.call(
            currentUser: event.currentUser,
            participantEntity: event.participantUser);
        print(conversationEntity.id);
        emit(OnConversationFetchedState(conversationEntity));
      },
    );

    on<CreateMessageEvent>(
      (event, emit) async {
        print(" xxxx   ${event.conversationEntity.participants}");
        await createMessageUsecase.call(
            message: event.message, conversation: event.conversationEntity);
      },
    );

    on<CreateMediaMessageEvent>(
      (event, emit) async {},
    );

    on<GetAllMessageevent>(
      (event, emit) async {
        var messaeEntityStream = getAllMessageUsecase.call(event.conversation);
        emit(OnAllMessageRetrivedState(messaeEntityStream));
      },
    );

    on<GetAllConversationEvent>(
      (event, emit) async {
        var conversationEntityStream =
            getAllConvesationUsecase.call(event.userEntity);
        emit(OnAllCOnversationRetrivedState(conversationEntityStream));
      },
    );
    on<GetALlConversationProfileEvent>(
      (event, emit) async {
        print("im in bloc");
        var conversation =
            await getProfileConversationUsecase.call(event.conversations);
        emit(OnAllCOnversationProfileRetrivedState(conversation));
      },
    );

    // on<GetConversationEvent>(
    //   (event, emit) async {
    //     try {
    //       var conversatiolList = await FirebaseFirestore.instance
    //           .collection('conversations')
    //           .where('participants', arrayContains: event.userUidList.first)
    //           .get()
    //           .then((snapshot) => snapshot.docs
    //               .map((value) => ConversationModel.fromFirestore(value))
    //               .toList());

    //       var filteredConversation = conversatiolList.firstWhere(
    //         (element) =>
    //             element.participants.contains(event.userUidList.last) &&
    //             element.participants.contains(event.userUidList.first),
    //       );

    //       emit(OnConversationRetrived(filteredConversation));
    //     } catch (e) {
    //       emit(OnConversationRetrivedFailureState(ConversationModel(
    //         conversationType: "",
    //         id: '',
    //         participants: [event.userUidList.first, event.userUidList.last],
    //         createdAt: Timestamp.fromDate(DateTime.now()),
    //       )));
    //     }
    //   },
    // );
  }
}
