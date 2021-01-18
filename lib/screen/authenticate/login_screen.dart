import 'package:flutter/material.dart';
import 'package:flutter_kakao_clone/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 170, child: Image.asset('assets/logo.png')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: EmailController,
                  decoration: InputDecoration(hintText: "Email"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: TextFormField(
                  controller: PasswordController,
                  decoration: InputDecoration(hintText: "Password"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: RaisedButton(
                  onPressed: () {
                    //Firebase 로그인
                    context.read<AuthViewModel>().emailSignIn(
                        EmailController.text, PasswordController.text);
                  },
                  child: Container(
                      width: size.width,
                      child: Center(
                          child: Text(
                        "Log in",
                        style: TextStyle(fontSize: 20),
                      ))),
                  color: Colors.yellowAccent,
                ),
              ),
              FlatButton(
                  onPressed: () {
                    //Firebase 회원가입
                    context.read<AuthViewModel>().emailSignUp(
                        EmailController.text, PasswordController.text);
                  },
                  child: Text("Sign Up"))
            ],
          ),
        ),
      ),
    );
  }
}
