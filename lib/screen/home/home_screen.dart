import 'package:flutter/material.dart';
import 'package:flutter_kakao_clone/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(),
    );
  }
}
