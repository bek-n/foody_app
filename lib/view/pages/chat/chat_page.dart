import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/components/cached_network_image.dart';
import 'package:foody_app/view/style/style.dart';
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
                      child: CustomTextFrom(
                    controller: searchUser,
                    label: "Users",
                    hintext: '',
                  )),
                  IconButton(
                      onPressed: () {
                        event.changeAddUser();
                      },
                      icon: Icon(
                        Icons.add,
                        color: Style.primaryColor,
                      ))
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
                                      builder: (_) => MessagePage(
                                            docId: id,
                                            user: state.users[index],
                                          )));
                                });
                              },
                              child: Container(
                                width: 380.w,
                                height: 88.h,
                                margin: EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 50,
                                        offset: Offset(0, 6),
                                        color:
                                            Color(0xff5A6CEA).withOpacity(0.08))
                                  ],
                                  color: Style.whiteColor,
                                ),
                                child: Row(
                                  children: [
                                    state.users[index].avatar == null
                                        ? const SizedBox.shrink()
                                        : CustomImageNetwork(
                                            image:
                                                state.users[index].avatar ?? "",
                                            height: 70,
                                            width: 70,
                                            radius: 100,
                                          ),
                                    20.horizontalSpace,
                                    Expanded(
                                      child: Text(
                                        state.users[index].name ?? "",
                                        style: Style.textStyleRegular(),
                                      ),
                                    )
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
                                              status:
                                                  state.chats[index].userStatus,
                                              docId:
                                                  state.listOfDocIdChats[index],
                                              user: state.chats[index].resender,
                                            )));
                              },
                              child: Container(
                                width: 380.w,
                                height: 88.h,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 50,
                                        offset: Offset(0, 6),
                                        color:
                                            Color(0xff5A6CEA).withOpacity(0.08))
                                  ],
                                  color: Style.whiteColor,
                                ),
                                margin: EdgeInsets.all(24),
                                child: Row(
                                  children: [
                                    state.chats[index].resender.avatar == null
                                        ? const SizedBox.shrink()
                                        : CustomImageNetwork(
                                            image: state.chats[index].resender
                                                    .avatar ??
                                                "",
                                            height: 70,
                                            width: 70,
                                            radius: 100,
                                          ),
                                    20.horizontalSpace,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.chats[index].resender.name ??
                                              "",
                                          style: Style.textStyleRegular(),
                                        ),
                                        state.chats[index].userStatus == true
                                            ? Text(
                                                'Online Now',
                                                style: Style.textStyleRegular2(
                                                    textColor: Colors.green),
                                              )
                                            : Text('Offline',
                                                style: Style.textStyleRegular2(
                                                    textColor:
                                                        Style.primaryColor)),
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
        ));
  }
}
