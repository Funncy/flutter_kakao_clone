import 'package:flutter/material.dart';
import 'package:flutter_kakao_clone/screen/home/chatting_screen.dart';
import 'package:flutter_kakao_clone/view_model/auth_view_model.dart';
import 'package:flutter_kakao_clone/view_model/chat_view_model.dart';
import 'package:flutter_kakao_clone/view_model/user_list_view_model.dart';
import 'package:provider/provider.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  void initState() {
    Provider.of<UserListViewModel>(context, listen: false).getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userList = Provider.of<UserListViewModel>(context).userList;
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
      body: Container(
        child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(userList[index].email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiProvider(
                                providers: [
                                  Provider<AuthViewModel>(
                                    create: (_) => AuthViewModel(),
                                  ),
                                  ChangeNotifierProvider(
                                      create: (_) => ChatViewModel()),
                                ],
                                child: ChattingScreen(
                                  friendEmail: userList[index].email,
                                ))),
                  );
                },
              );
            }),
      ),
    );
  }
}
