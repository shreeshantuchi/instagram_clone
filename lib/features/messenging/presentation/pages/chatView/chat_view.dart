import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/domain/entity/mesage_entity.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_bloc.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_event.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_state.dart';
import 'package:login_token_app/features/messenging/presentation/pages/chatView/widgets/expand_icon_container.dart';
import 'package:login_token_app/features/messenging/presentation/widgets/message_card.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_management_state.dart';

class ChatView extends StatefulWidget {
  static String pathName = "supportView";
  static String routeName = "/supportView";
  final ConversationEntity conversationModel;
  const ChatView({super.key, required this.conversationModel});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _chatScrollController = ScrollController();

  @override
  void initState() {
    print(widget.conversationModel.participants);

    super.initState();
    final currentUser = context.read<AuthBloc>().state.user;
    final participants = widget.conversationModel.participants;
    final uid = participants.firstWhere((e) => currentUser!.uid != e);
    print(widget.conversationModel.participants);

    context.read<UserManagementBloc>().add(GetProfileEvent(uid));
    context.read<MessageBloc>().add(
          GetAllMessageevent(widget.conversationModel),
        );
  }

  final ValueNotifier<bool> isExpandedNotifier = ValueNotifier<bool>(false);
  List<List<MessageEntity>> groupMessagesByDay(List<MessageEntity> messages) {
    if (messages.isEmpty) return [];

    messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    List<List<MessageEntity>> groupedMessages = [];
    List<MessageEntity> currentGroup = [messages[0]];

    for (int i = 1; i < messages.length; i++) {
      DateTime currentDate = messages[i].timestamp.toDate();
      DateTime previousDate = messages[i - 1].timestamp.toDate();

      if (currentDate.day == previousDate.day &&
          currentDate.month == previousDate.month &&
          currentDate.year == previousDate.year) {
        currentGroup.add(messages[i]);
      } else {
        groupedMessages.add(currentGroup);
        currentGroup = [messages[i]];
      }
    }

    groupedMessages.add(currentGroup); // Add the last group
    return groupedMessages;
  }

  @override
  void dispose() {
    _chatScrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    // Ensure that the scrolling happens after the frame is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_chatScrollController.hasClients) {
          _chatScrollController.animateTo(
            _chatScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagementBloc, UserManagementState>(
      builder: (context, state) {
        switch (state) {
          case OnUserProfileRetrivedState():
            final profile = state.profile;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                shadowColor: Colors.white,
                surfaceTintColor: Colors.white,
                title: Text(profile.username),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    var userModel = context.read<AuthBloc>().state.user!;
                    context
                        .read<MessageBloc>()
                        .add(GetAllConversationEvent(userModel));
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12.0.h),
                      child: BlocConsumer<MessageBloc, MessageState>(
                        listener: (context, state) {
                          if (state is OnAllCOnversationRetrivedState) {
                            _scrollToEnd();
                          }
                        },
                        builder: (context, state) {
                          if (state is OnAllMessageRetrivedState) {
                            return StreamBuilder<List<MessageEntity>>(
                              stream: state.messageListStream,
                              builder: (context, snapshot) {
                                _scrollToEnd();
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text("No messages are available"),
                                  );
                                } else {
                                  List<MessageEntity> messageModelList =
                                      snapshot.data!;
                                  List<List<MessageEntity>>
                                      groupedMessagedList = groupMessagesByDay(
                                    messageModelList,
                                  );
                                  return ListView.builder(
                                    controller: _chatScrollController,
                                    itemCount: groupedMessagedList.length,
                                    itemBuilder: (context, index1) {
                                      // ignore: unused_local_variable
                                      for (var e
                                          in groupedMessagedList[index1]) {}
                                      var messageList =
                                          groupedMessagedList[index1];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: DateWidget(
                                                  messageList: messageList),
                                            ),
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: messageList.length,
                                            itemBuilder: (context, index2) {
                                              var message = messageList[index2];
                                              if (message.senderId ==
                                                  context
                                                      .read<AuthBloc>()
                                                      .state
                                                      .user!
                                                      .uid) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    MessageCard(
                                                      message: message,
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    MessageCard(
                                                      backgroundCOlor: AppPallet
                                                          .greyBorderColor
                                                          .withOpacity(0.2),
                                                      message: message,
                                                      textColor: Colors.black,
                                                    ),
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: ExpandableContainer(
                      conversationEntity: widget.conversationModel!,
                      scrollToEnd: _scrollToEnd,
                    ),
                  ),
                ],
              ),
            );

          default:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.messageList,
  });

  final List<MessageEntity> messageList;

  @override
  Widget build(BuildContext context) {
    final DateTime messageDate = messageList[0].timestamp.toDate();
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = today.subtract(const Duration(days: 1));

    String formattedDate;

    if (messageDate.year == today.year &&
        messageDate.month == today.month &&
        messageDate.day == today.day) {
      formattedDate = 'Today';
    } else if (messageDate.year == yesterday.year &&
        messageDate.month == yesterday.month &&
        messageDate.day == yesterday.day) {
      formattedDate = 'Yesterday';
    } else {
      formattedDate = DateFormat('d MMMM, yyyy').format(messageDate);
    }

    return Text(
      formattedDate,
      style: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(color: AppPallet.greyBorderColor),
    );
  }
}
