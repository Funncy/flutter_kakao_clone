import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_clone/models/chat_model.dart';
import 'package:flutter_kakao_clone/services/auth_service.dart';
import 'package:flutter_kakao_clone/services/chat_service.dart';

class ChatViewModel with ChangeNotifier {
  ChatService _chatService = ChatService();
  AuthService _authService = AuthService();
  List<ChatModel> chats = new List<ChatModel>();

  //전체 채팅 내용 가져오기
  Stream<QuerySnapshot> getChatsStream(String friendEmail) {
    return _chatService.getChatsStream(friendEmail);
  }

  List<ChatModel> getChatList(List<QueryDocumentSnapshot> docs) {
    docs.forEach((element) {
      var data = element.data();
      // document ID 중복 추가 안함
      // *매번 모든 데이터 stream으로 다 들어옴 해결법 고민
      var contains = chats.where((chat) => chat.did == element.id);
      if (contains.isEmpty)
        chats.add(new ChatModel(
            did: element.id, uid: data['userEmail'], content: data['content']));
    });
    return chats;
  }

  //채팅 보내기
  void sendChat(String friendEmail, String content,
      ScrollController scrollController) async {
    var userEmail = _authService.getUserEmail();
    var did = await _chatService.sendChat(userEmail, friendEmail, content);
    // chats.add(new ChatModel(did: did, uid: userEmail, content: content));

    // scrollController.animateTo(scrollController.position.maxScrollExtent,
    //     duration: Duration(seconds: 1), curve: Curves.ease);
  }
}
