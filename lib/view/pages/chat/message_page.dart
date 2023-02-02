import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:foody_app/view/components/cached_network_image.dart';
import 'package:foody_app/view/style/style.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/chat_controller.dart';
import '../../../model/user_model.dart';
import '../../components/custom_textform.dart';
import '../../components/unfocus.dart';

class MessagePage extends StatefulWidget {
  final String docId;
  final UserModel user;
  final status;

  MessagePage({Key? key, required this.docId, required this.user, this.status})
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
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  return FocusedMenuHolder(
                    duration: const Duration(milliseconds: 300),
                    onPressed: () {},
                    menuItems: state.messages[index].ownerId == state.userId
                        ? [
                            FocusedMenuItem(
                                title: const Text("Edit"),
                                onPressed: () {
                                  message.text = state.messages[index].title;
                                  FocusScope.of(context).autofocus(messageNode);
                                  event.changeEditText(
                                      messId: state.messages[index].messId,
                                      time: state.messages[index].time,
                                      oldText: state.messages[index].title);
                                }),
                            FocusedMenuItem(
                                title: const Text("Delete"),
                                onPressed: () {
                                  event.deleteMessage(
                                      chatDocId: widget.docId,
                                      messDocId: state.messages[index].messId);
                                }),
                          ]
                        : [
                            FocusedMenuItem(
                                title: const Text("Delete"),
                                onPressed: () {
                                  event.deleteMessage(
                                      chatDocId: widget.docId,
                                      messDocId: state.messages[index].messId);
                                }),
                          ],
                    child: Align(
                      alignment: state.messages[index].ownerId == state.userId
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            color: state.messages[index].ownerId == state.userId
                                ? Style.primaryColor
                                : Color.fromARGB(255, 189, 182, 182),
                            borderRadius: state.messages[index].ownerId ==
                                    state.userId
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(_borderRadius),
                                    bottomRight: Radius.circular(_borderRadius),
                                    bottomLeft: Radius.circular(_borderRadius))
                                : const BorderRadius.only(
                                    topLeft: Radius.circular(_borderRadius),
                                    topRight: Radius.circular(_borderRadius),
                                    bottomRight: Radius.circular(_borderRadius),
                                  )),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                state.messages[index].title,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: state.messages[index].ownerId ==
                                            state.userId
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 4),
                              child: Text(
                                DateFormat("hh:mm")
                                    .format(state.messages[index].time),
                                style: TextStyle(
                                    color: state.messages[index].ownerId ==
                                            state.userId
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
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
            suffixIcon: IconButton(
              onPressed: () {
                state.editTime != null
                    ? event.editMessage(
                        chatDocId: widget.docId,
                        messDocId: state.editMessId,
                        newMessage: message.text,
                        time: state.editTime ?? DateTime.now())
                    : event.sendMessage(message.text, widget.docId);
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
