import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_kakao_clone/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userModel;

  //현재 유저
  String getCurrentUserEmail() {
    return _auth.currentUser.email;
  }

  // 유저 상태 Stream
  Stream<UserModel> get user {
    return _auth.authStateChanges().map((user) {
      userModel = UserModel(uid: user.uid, email: user.email);
      return userModel;
    });
  }

  //유저 이메일
  String getUserEmail() {
    return _auth.currentUser.email;
    // if (userModel != null) return userModel.email;
    // return "unknown";
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
      // User정보 Firestore에 추가 저장 (친구 목록 용)
      _firestore.collection('users').add({"userEmail": email});
    } on FirebaseAuthException catch (e) {
      print("Error e.code=${e.code}");
      return;
    } on FirebaseException catch (e) {
      print("Error e.code=${e.code}");
      return;
    }

    print("success");
  }

  //로그아웃
  void signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print("SignOut Error e.code=${e.code}");
      return;
    }
    print("SignOut");
  }
}
