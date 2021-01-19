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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: Text("${context.watch<AuthViewModel>().userEmail}"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AuthViewModel>().logOut();
              })
        ],
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height - 200,
            child: StreamBuilder<QuerySnapshot>(
                stream: context.watch<ChatViewModel>().getChatsStream(),
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

                      return ListView.builder(
                        controller: scrollController,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return chats[index];
                        },
                      );
                  }
                }),

            // SingleChildScrollView(
            //     controller: scrollController,
            //     scrollDirection: Axis.vertical,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           width: size.width,
            //           height: 20,
            //         ),
            //         StreamBuilder<QuerySnapshot>(
            //           stream: context.watch<ChatViewModel>().getChatsStream(),
            //           builder: (context, snapshot) {
            //             switch (snapshot.connectionState) {
            //               case ConnectionState.waiting:
            //                 return Loading();
            //                 break;
            //               case ConnectionState.none:
            //               case ConnectionState.active:
            //               case ConnectionState.done:
            //                 return Column(
            //                   children: [
            //                     ...context
            //                         .watch<ChatViewModel>()
            //                         .getChatList(snapshot.data.docs)
            //                         .map((chat) => ChatWidget(
            //                               chatModel: chat,
            //                             ))
            //                         .toList()
            //                   ],
            //                 );
            //                 break;
            //             }
            //             return Container();
            //           },
            //         )
            //       ],
            //     )),
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
                                  sendTextController.text, scrollController);
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
