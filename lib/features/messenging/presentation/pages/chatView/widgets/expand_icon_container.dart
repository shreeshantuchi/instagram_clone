import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/core/widget/custom_text_form_field.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_state.dart';
import 'package:login_token_app/features/messenging/domain/entity/conversation_enetity.dart';
import 'package:login_token_app/features/messenging/domain/entity/mesage_entity.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_bloc.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_event.dart';
import 'package:login_token_app/features/messenging/presentation/pages/chatView/widgets/image_stack.dart';
import 'package:login_token_app/shared/mediaManagementBloc/media_management_bloc.dart';
import 'package:login_token_app/shared/mediaManagementBloc/media_management_event.dart';
import 'package:login_token_app/shared/mediaManagementBloc/media_management_state.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

enum MessageType { generalMessage, mediaMessage }

class ExpandableContainer extends StatefulWidget {
  final ConversationEntity conversationEntity;
  const ExpandableContainer(
      {super.key, required this.conversationEntity, required this.scrollToEnd});
  final VoidCallback scrollToEnd;
  @override
  // ignore: library_private_types_in_public_api
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final TextEditingController _messageController = TextEditingController();
  final ValueNotifier<bool> isExpandedNotifier = ValueNotifier(false);
  List<XFile> mediaList = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    isExpandedNotifier.addListener(_toggleAnimation);
  }

  void _toggleAnimation() {
    if (isExpandedNotifier.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    isExpandedNotifier.removeListener(_toggleAnimation);
    super.dispose();
  }

  bool isMedia = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<MediaManagementBloc, MediaManagementState>(
      listener: (context, state) {
        if (state is OnMediaSelected) {
          isMedia = true;
          mediaList = state.imageList;
        }
      },
      child: Column(
        children: [
          BlocBuilder<MediaManagementBloc, MediaManagementState>(
              builder: (context, state) {
            switch (state) {
              case OnMediaSelected():
                return ImageStack(
                  imageFiles: state.imageList,
                );

              default:
                return const SizedBox.shrink();
            }
          }),
          Row(
            //mainAxisSize: MainAxisSize.min,P
            children: [
              GestureDetector(
                onTap: () {
                  isExpandedNotifier.value = !isExpandedNotifier.value;
                },
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return SizedBox(
                      height: 50,
                      width: (isExpandedNotifier.value ? 100 : 50),
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!isExpandedNotifier.value)
                            const Center(
                              child: Icon(CupertinoIcons.square_arrow_right),
                            ),
                          isExpandedNotifier.value
                              ? SizeTransition(
                                  sizeFactor: _controller,
                                  axisAlignment: -1.0,
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          PhosphorIconsFill.camera,
                                        ),
                                        onPressed: () async {
                                          Permission cameraPermission =
                                              Permission.camera;
                                          var isCameraGranted =
                                              await cameraPermission
                                                  .status.isGranted;
                                          if (isCameraGranted) {
                                            context
                                                .read<MediaManagementBloc>()
                                                .add(SelectCameraEvent());
                                          } else {
                                            await cameraPermission.request();
                                            if (isCameraGranted) {
                                              context
                                                  .read<MediaManagementBloc>()
                                                  .add(SelectCameraEvent());
                                            }
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          PhosphorIconsRegular.image,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<MediaManagementBloc>()
                                              .add(SelectImageEvent());
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  contentPadding: 10,
                  onTap: () {
                    isExpandedNotifier.value = !isExpandedNotifier.value;
                    // Ensure that scrolling happens after the input field is tapped
                    widget.scrollToEnd;
                  },
                  hintText: 'Enter Your Text',
                  controller: _messageController,
                ),
              ),
              SizedBox(width: 8.h),
              BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
                return SizedBox(
                  height: 30.h,
                  width: 30.h,
                  child: FloatingActionButton(
                    backgroundColor: AppPallet.blueColor,
                    child: const Icon(
                      PhosphorIconsFill.arrowUp,
                      color: AppPallet.whiteColor,
                    ),
                    onPressed: () {
                      if (isMedia && _messageController.text.isNotEmpty) {
                        context
                            .read<MediaManagementBloc>()
                            .add(ResetMediaEvent());
                        context.read<MessageBloc>().add(
                              CreateMediaMessageEvent(
                                mediaList: mediaList,
                                message: MessageEntity(
                                  content: _messageController.text,
                                  id: '',
                                  conversationId: widget.conversationEntity.id,
                                  senderId: authState.user!.uid,
                                  imageUrl: null,
                                  timestamp: Timestamp.fromDate(DateTime.now()),
                                  messageType: MessageType.mediaMessage.name,
                                ),
                              ),
                            );
                        context.read<MessageBloc>().add(
                              CreateMessageEvent(
                                conversationEntity: widget.conversationEntity,
                                message: MessageEntity(
                                  content: _messageController.text,
                                  id: '',
                                  conversationId: widget.conversationEntity.id,
                                  senderId: authState.user!.uid,
                                  imageUrl: null,
                                  timestamp: Timestamp.fromDate(DateTime.now()),
                                  messageType: MessageType.generalMessage.name,
                                ),
                              ),
                            );
                      } else if (isMedia) {
                        context
                            .read<MediaManagementBloc>()
                            .add(ResetMediaEvent());
                        context.read<MessageBloc>().add(
                              CreateMediaMessageEvent(
                                mediaList: mediaList,
                                message: MessageEntity(
                                  content: _messageController.text,
                                  id: '',
                                  conversationId: widget.conversationEntity.id,
                                  senderId: authState.user!.uid,
                                  imageUrl: null,
                                  timestamp: Timestamp.fromDate(DateTime.now()),
                                  messageType: MessageType.mediaMessage.name,
                                ),
                              ),
                            );
                      } else if (_messageController.text.isNotEmpty) {
                        context.read<MessageBloc>().add(
                              CreateMessageEvent(
                                conversationEntity: widget.conversationEntity,
                                message: MessageEntity(
                                  content: _messageController.text,
                                  id: '',
                                  conversationId: widget.conversationEntity.id,
                                  senderId: authState.user!.uid,
                                  imageUrl: null,
                                  timestamp: Timestamp.fromDate(DateTime.now()),
                                  messageType: MessageType.generalMessage.name,
                                ),
                              ),
                            );
                      }
                      isMedia = false;
                      _messageController.clear();
                      widget.scrollToEnd;
                    },
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
