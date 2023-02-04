import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:foody_app/view/components/cached_network_image.dart';
import 'package:foody_app/view/style/style.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../controller/chat_controller.dart';
import '../../../model/user_model.dart';
import '../../components/custom_image_message.dart';
import '../../components/custom_textform.dart';
import '../../components/custom_video.dart';
import '../../components/message_items.dart';
import '../../components/unfocus.dart';

class MessagePage extends StatefulWidget {
  final String docId;
  final UserModel user;
  final status;

  const MessagePage(
      {Key? key, required this.docId, required this.user, this.status})
      : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController message = TextEditingController();
  final FocusNode messageNode = FocusNode();
  static const _borderRadius = 26.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatController>().getMessages(widget.docId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatController>();
    final event = context.read<ChatController>();
    return OnUnFocusTap(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              widget.user.avatar == null
                  ? const SizedBox.shrink()
                  : CustomImageNetwork(
                      image: widget.user.avatar ?? "",
                      height: 55,
                      width: 55,
                      radius: 100,
                    ),
              20.horizontalSpace,
              Column(
                children: [
                  Text(
                    widget.user.name ?? "",
                    style: Style.textStyleRegular(),
                  ),
                  widget.status == true
                      ? Text(
                          'Online Now',
                          style:
                              Style.textStyleRegular2(textColor: Colors.green),
                        )
                      : Text('Offline',
                          style: Style.textStyleRegular2(
                              textColor: Style.primaryColor)),
                ],
              ),
            ],
          ),
        ),
        body: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                reverse: true,
                itemCount: state.isUploading
                    ? state.messages.length + 1
                    : state.messages.length,
                itemBuilder: (context, index) {
                  return (state.isUploading && (index == 0))
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: TextLiquidFill(
                                text: 'LOADING',
                                waveColor: Style.primaryColor,
                                boxBackgroundColor: Colors.grey,
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                boxHeight: 100),
                          ))
                      : Align(
                          alignment: state
                                      .messages[
                                          state.isUploading ? index - 1 : index]
                                      .ownerId ==
                                  state.userId
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: state
                                      .messages[
                                          state.isUploading ? index - 1 : index]
                                      .type ==
                                  "text"
                              ? MessageItem(
                                  isOwner: state
                                          .messages[state.isUploading
                                              ? index - 1
                                              : index]
                                          .ownerId ==
                                      state.userId,
                                  onEdit: () {
                                    message.text = state
                                        .messages[state.isUploading
                                            ? index - 1
                                            : index]
                                        .title;
                                    FocusScope.of(context)
                                        .autofocus(messageNode);
                                    event.changeEditText(
                                        messId: state
                                            .messages[state.isUploading
                                                ? index - 1
                                                : index]
                                            .messId,
                                        time: state
                                            .messages[state.isUploading
                                                ? index - 1
                                                : index]
                                            .time,
                                        oldText: state
                                            .messages[state.isUploading
                                                ? index - 1
                                                : index]
                                            .title);
                                  },
                                  onDelete: () {
                                    event.deleteMessage(
                                        chatDocId: widget.docId,
                                        messDocId: state
                                            .messages[state.isUploading
                                                ? index - 1
                                                : index]
                                            .messId);
                                  },
                                  message: state.messages[
                                      state.isUploading ? index - 1 : index],
                                )
                              : state
                                          .messages[state.isUploading
                                              ? index - 1
                                              : index]
                                          .type ==
                                      "image"
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12),
                                      child: FocusScope(
                                        child: CustomImageNetworkMessage(
                                          isOwner: state
                                                  .messages[state.isUploading
                                                      ? index - 1
                                                      : index]
                                                  .ownerId ==
                                              state.userId,
                                          onDelete: () {
                                            event.deleteImage(
                                                chatDocId: widget.docId,
                                                messDocId: state
                                                    .messages[state.isUploading
                                                        ? index - 1
                                                        : index]
                                                    .messId);
                                          },
                                          image: state
                                              .messages[state.isUploading
                                                  ? index - 1
                                                  : index]
                                              .title,
                                          height: 100,
                                          width: 100,
                                          radius: 16,
                                        ),
                                      ),
                                    )
                                  : CustomVideo(
                                      videoUrl: state
                                          .messages[state.isUploading
                                              ? index - 1
                                              : index]
                                          .title,
                                      onDelete: () {
                                        event.deleteVideo(
                                            chatDocId: widget.docId,
                                            messDocId: state
                                                .messages[state.isUploading
                                                    ? index - 1
                                                    : index]
                                                .messId);
                                      },
                                      onEdit: () {},
                                      isOwner: state
                                              .messages[state.isUploading
                                                  ? index - 1
                                                  : index]
                                              .ownerId ==
                                          state.userId,
                                    ),
                        );
                }),
        bottomNavigationBar: Container(
          padding:
              const EdgeInsets.only(bottom: 12, left: 24, right: 24, top: 12),
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          color: Colors.white,
          child: CustomTextFrom(
            node: messageNode,
            controller: message,
            label: "",
            prefixicon: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      event.getImageGallery(widget.docId);
                    },
                    icon: const Icon(Icons.image),
                  ),
                  IconButton(
                    onPressed: () {
                      event.getVideoGallery(widget.docId);
                    },
                    icon: const Icon(Icons.video_library),
                  ),
                ],
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                state.editTime != null
                    ? event.editMessage(
                        chatDocId: widget.docId,
                        messDocId: state.editMessId,
                        newMessage: message.text,
                        time: state.editTime ?? DateTime.now())
                    : event.sendMessage(
                        title: message.text, docId: widget.docId, type: 'text');
                message.clear();
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(Icons.send),
            ),
            hintext: '',
          ),
        ),
      ),
    );
  }
}
