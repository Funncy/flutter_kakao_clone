import 'package:flutter/material.dart';
import 'package:flutter_kakao_clone/models/user_model.dart';
import 'package:flutter_kakao_clone/screen/authenticate/login_screen.dart';
import 'package:flutter_kakao_clone/screen/home/home_screen.dart';
import 'package:flutter_kakao_clone/view_model/auth_view_model.dart';
import 'package:flutter_kakao_clone/widget/Error.dart';
import 'package:flutter_kakao_clone/widget/Loading.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthViewModel>(context);

    // return StreamBuilder(builder:  )
    return StreamBuilder<UserModel>(
        stream: auth.user,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                body: Loading(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.data != null) {
                return HomeScreen();
              }
              return LoginScreen();
            case ConnectionState.none:
              return Scaffold(
                body: Error(),
              );
          }

          return LoginScreen();
        });
  }
}
