import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kakao_clone/screen/authenticate/auth_wrapper.dart';
import 'package:flutter_kakao_clone/screen/authenticate/login_screen.dart';
import 'package:flutter_kakao_clone/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  //main에서 비동기 처리 허용
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
                )
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
