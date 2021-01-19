import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_clone/models/chat_model.dart';
import 'package:flutter_kakao_clone/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class ChatWidget extends StatelessWidget {
  final ChatModel chatModel;
  ChatWidget({@required this.chatModel});

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthViewModel>(context);
    return chatModel.uid == auth.userEmail
        ? RightChat(content: chatModel.content)
        : LeftChat(content: chatModel.content);
  }
}

class LeftChat extends StatelessWidget {
  final String content;
  const LeftChat({
    Key key,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      // margin - 내 외부와의 거리를 조절. 내 크기는 변하지 않음.
      // padding - 나를 중심으로. 크기도 변하겟지.
      alignment: Alignment.centerLeft,
      child: Container(
        width: 250,
        height: 50,
        margin: const EdgeInsets.only(left: 20, bottom: 20),
        child: Bubble(
          color: Colors.greenAccent,
          nip: BubbleNip.leftBottom,
          child: Text(this.content),
        ),
      ),
    );
  }
}

class RightChat extends StatelessWidget {
  final String content;
  const RightChat({
    Key key,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 250,
        height: 50,
        margin: const EdgeInsets.only(right: 20, bottom: 20),
        child: Bubble(
          color: Colors.yellow,
          nip: BubbleNip.rightBottom,
          child: Text(this.content),
        ),
      ),
    );
  }
}
