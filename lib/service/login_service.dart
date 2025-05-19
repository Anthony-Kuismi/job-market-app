import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService extends ChangeNotifier {

  UserCredential? userCred;

  LoginService();

  Future<dynamic> logIn() async {
    
    try {
      final GoogleSignInAccount? account = await GoogleSignIn().signIn();
      log('$account');
      final GoogleSignInAuthentication? googleAuth =
      await account?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential cred = await FirebaseAuth.instance.signInWithCredential(credential);
      await saveUser(account!);
      userCred = cred;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', cred.user!.uid);
      notifyListeners();
      return cred;

    } on Exception catch (error) {
      print('Error: $error');
    }
  }

  Future<bool> logOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      userCred = null;
      notifyListeners();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<void> saveUser(GoogleSignInAccount user) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'username': user.displayName,
      'email': user.email,
    });
  }

  Future<void> deleteUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).delete();
  }

}