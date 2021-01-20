import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_kakao_clone/models/user_model.dart';
import 'package:flutter_kakao_clone/services/auth_service.dart';
import 'package:flutter_kakao_clone/services/user_list_service.dart';

class UserListViewModel with ChangeNotifier {
  var _userListService = UserListService();
  var _authSerivce = AuthService();
  List<UserModel> userList = new List<UserModel>();

  void getUserList() {
    _userListService.setUserListStreamFunction(setUserList);
  }

  void setUserList(QuerySnapshot data) {
    userList.clear();
    data.docs.forEach((element) {
      if (_authSerivce.getCurrentUserEmail() != element.data()['userEmail'])
        userList.add(new UserModel(
            email: element.data()['userEmail'],
            uid: element.data()['userEmail']));
    });
    notifyListeners();
  }
}
