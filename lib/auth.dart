import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseAuth {
 Future<String?>? signInWithEmailAndPassword(String email, String password);
 Future<String?>? createUserWithEmailAndPassword(String email, String password);
  Future<String?>? currentUser();
  Future<void> signOut();
}

class Auth with ChangeNotifier implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
@override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return FirebaseAuth.instance.currentUser!.uid;
  }
@override
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return FirebaseAuth.instance.currentUser!.uid;
  }
@override
  Future<String> currentUser() async {
    var user = await _firebaseAuth.currentUser!;
    return user.uid;
  }
@override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
