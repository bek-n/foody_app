import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/chat_controller.dart';
import '../../components/custom_textform.dart';
import 'message_page.dart';


class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final TextEditingController searchUser = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatController>()
        ..getUserList()
        ..getChatsList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final event = context.read<ChatController>();
    final state = context.watch<ChatController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child:
                        CustomTextFrom(controller: searchUser, label: "Users", hintext: '',)),
                IconButton(
                    onPressed: () {
                      event.changeAddUser();
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            state.addUser
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              event.createChat(index, (id) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => MessagePage(docId: id,user:  state.users[index],)));
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  state.users[index].avatar == null
                                      ? const SizedBox.shrink()
                                      : ClipOval(
                                          child: Image.network(
                                            state.users[index].avatar ?? "",
                                            height: 62,
                                            width: 62,
                                          ),
                                        ),
                                  Text(state.users[index].name ?? "")
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.chats.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MessagePage(
                                            docId:
                                                state.listOfDocIdChats[index],
                                        user:   state.chats[index].resender,
                                          )));
                            },
                            child: Container(
                              color: Colors.pinkAccent,
                              margin: EdgeInsets.all(24),
                              child: Row(
                                children: [
                                  state.chats[index].resender.avatar == null
                                      ? const SizedBox.shrink()
                                      : ClipOval(
                                          child: Image.network(
                                            state.chats[index].resender
                                                    .avatar ??
                                                "",
                                            height: 62,
                                            width: 62,
                                          ),
                                        ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text(state.chats[index].resender.name ?? ""),
                                      Text(state.chats[index].userStatus.toString()),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}