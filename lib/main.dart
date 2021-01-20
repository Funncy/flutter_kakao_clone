import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_clone/screen/authenticate/auth_wrapper.dart';
import 'package:flutter_kakao_clone/screen/authenticate/login_screen.dart';
import 'package:flutter_kakao_clone/view_model/auth_view_model.dart';
import 'package:flutter_kakao_clone/view_model/chat_view_model.dart';
import 'package:flutter_kakao_clone/view_model/user_list_view_model.dart';
import 'package:provider/provider.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() {
  //main에서 비동기 처리 허용
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  void getToken(Future<String> token) async {
    var data = await token;
    print("token = $data");
  }

  @override
  void initState() {
    _firebaseMessaging.getToken().then((token) {
      print('token:' + token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Kakao clone',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Container(
                child: Text("Error"),
              );
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return MultiProvider(providers: [
                Provider<AuthViewModel>(
                  create: (_) => AuthViewModel(),
                ),
                ChangeNotifierProvider(create: (_) => ChatViewModel()),
                ChangeNotifierProvider(create: (_) => UserListViewModel()),
              ], child: AuthWrapper());
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Container(
              child: Text("Loading"),
            );
          },
        ));
  }
}
