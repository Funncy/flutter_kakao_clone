import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 170, child: Image.asset('assets/logo.png')),
              RaisedButton(
                color: Colors.yellowAccent,
                onPressed: () {},
                child: Container(
                  width: 300,
                  height: 45,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(Icons.ac_unit_rounded),
                      ),
                      Expanded(child: Center(child: Text("카카오톡 로그인")))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
