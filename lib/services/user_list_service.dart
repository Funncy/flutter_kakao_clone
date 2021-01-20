import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserListService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setUserListStreamFunction(Function getUserList) {
    _firestore
        .collection('users')
        .snapshots()
        .listen((event) => getUserList(event));
  }
}
