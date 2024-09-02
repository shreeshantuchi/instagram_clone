import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_bloc.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_event.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_state.dart';
import 'package:login_token_app/features/messenging/presentation/pages/chatView/chat_view.dart';
import 'package:login_token_app/features/userManagement/domain/entity/profile_entity.dart';

class ConversationView extends StatefulWidget {
  static String pathName = "conversationView";
  const ConversationView({super.key});

  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  @override
  void initState() {
    var userModel = context.read<AuthBloc>().state.user;
    context.read<MessageBloc>().add(GetAllConversationEvent(userModel!));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "All Users",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            // const UserListView(),
            Text(
              "All Conversation",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            BlocConsumer<MessageBloc, MessageState>(
              listener: (context, state) async {
                if (state is OnAllCOnversationRetrivedState) {
                  print("cant get itn");
                  final convList = await state.conversationListStream.first;
                  context.read<MessageBloc>().add(
                        GetALlConversationProfileEvent(conversations: convList),
                      );
                }
              },
              builder: (context, state) {
                print(state);
                switch (state) {
                  case OnAllCOnversationProfileRetrivedState():
                    return Column(
                      children: [
                        ConversationListWidget(
                          state: state,
                        ),
                      ],
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ConversationListWidget extends StatelessWidget {
  const ConversationListWidget({
    super.key,
    required this.state,
  });
  final OnAllCOnversationProfileRetrivedState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.conversationList.length,
        itemBuilder: (context, index) {
          var conversation = state.conversationList[index];
          ProfileEntity profile = conversation.profileEntity!;

          return ListTile(
            onTap: () {
              print("lololol ${conversation.participants}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatView(conversationModel: conversation),
                ),
              );
            },
            title: Text(profile.username),
          );
        });
    //   return StreamBuilder<List<ConversationEntity>>(
    //     stream: state.conversationListStream,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       } else if (snapshot.hasError) {
    //         return Center(
    //           child: Text('Error: ${snapshot.error}'),
    //         );
    //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //         return const Center(
    //           child: Text("No conversation are available,Start one"),
    //         );
    //       } else {
    //         List<ConversationEntity> converSationlist = snapshot.data!;
    //         return ListView.builder(
    //           shrinkWrap: true,
    //           itemCount: converSationlist.length,
    //           itemBuilder: (context, index) {
    //             var conversation = converSationlist[index];
    //             return ListTile(
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) =>
    //                         ChatView(conversationModel: conversation),
    //                   ),
    //                 );
    //               },
    //               title: Column(
    //                 children: [
    //                   Text(conversation.id),
    //                   Text(conversation.participants.toString()),
    //                 ],
    //               ),
    //             );
    //           },
    //         );
    //       }
    //     },
    //   );
    // }
  }
}
