import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_kakao_clone/models/chat_model.dart';
import 'package:flutter_kakao_clone/screen/home/chat_widget.dart';
import 'package:flutter_kakao_clone/view_model/auth_view_model.dart';
import 'package:flutter_kakao_clone/view_model/chat_view_model.dart';
import 'package:flutter_kakao_clone/widget/Loading.dart';
import 'package:provider/provider.dart';

class ChattingScreen extends StatefulWidget {
  final friendEmail;

  ChattingScreen({@required this.friendEmail});
  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final sendTextController = TextEditingController();
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.friendEmail}"),
        actions: [],
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height - 200,
            child: StreamBuilder<QuerySnapshot>(
                stream: context
                    .watch<ChatViewModel>()
                    .getChatsStream(widget.friendEmail),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Loading();
                      break;
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.done:
                      var chats = context
                          .watch<ChatViewModel>()
                          .getChatList(snapshot.data.docs)
                          .map((chat) => ChatWidget(
                                chatModel: chat,
                              ))
                          .toList();
                      //scroll 맨 아래로
                      Timer(
                          Duration(microseconds: 500),
                          () => scrollController.jumpTo(
                              scrollController.position.maxScrollExtent));

                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            return chats[index];
                          },
                        ),
                      );
                  }
                }),
          ),
          Center(
            child: Container(
                width: size.width,
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.8,
                        child: TextFormField(
                          controller: sendTextController,
                        ),
                      ),
                      Container(
                        width: 30,
                        child: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              context.read<ChatViewModel>().sendChat(
                                  widget.friendEmail,
                                  sendTextController.text,
                                  scrollController);
                            }),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
