import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_kakao_clone/models/chat_model.dart';

class ChatService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //채팅 내용 가져오기 Stream
  Stream<QuerySnapshot> getChatsStream() {
    return firestore.collection('chats').snapshots();
  }

  //실시간 연동 Stream

  //채팅 Send
  Future<String> sendChat(String uid, String content) async {
    var documentReference = await firestore.collection('chats').add({
      'userEmail': uid,
      'content': content,
    });
    return documentReference.id;
  }
}
