import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_kakao_clone/models/user_model.dart';
import 'package:flutter_kakao_clone/services/auth_service.dart';

class AuthViewModel {
  final _authService = AuthService();
  String userEmail;

  String getCurrentUserEmail() {
    return _authService.getCurrentUserEmail();
  }

  // 유저 로그인 상태 Stream
  Stream<UserModel> get user {
    return _authService.user.map((user) {
      userEmail = user.email;
      return user;
    });
  }

  //이메일 로그인
  void emailSignIn(String email, String password) async {
    //공백 제거
    email = email.trim();
    password = password.trim();

    _authService.emailSignIn(email, password);
  }

  //이메일 회원가입
  void emailSignUp(String email, String password) async {
    //공백 제거
    email = email.trim();
    password = password.trim();

    _authService.emailSignUp(email, password);
  }

  //로그아웃
  void logOut() {
    _authService.signOut();
  }
}
