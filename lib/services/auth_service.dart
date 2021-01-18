import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 유저 상태 Stream
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //이메일 로그인
  void emailSignIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("User ${userCredential}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wroing-password') {
        print('Wrong passwrod provided for that user.');
      } else {
        print("Error e.code=${e.code}");
      }
      return;
    }
    print("success");
  }

  //이메일 회원가입
  void emailSignUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("Error e.code=${e.code}");
      return;
    }

    print("success");
  }
}
