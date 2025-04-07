import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginwithEmailPassword(String email, String password) async {
    try {
      // ignore: unused_local_variable
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  // register
  Future registerWithEmailPassword(
      String fullName, String email, String password) async {
    try {
      print("register successful");
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // update the data base with new user
      await DatabaseServices(userId: user.uid).updateUserData(fullName, email);
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  // signout
  Future signOut(BuildContext context) async {
    try {
      await firebaseAuth.signOut();
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEMail("");
      await HelperFunctions.saveUserName("");
      Navigator.push(context,
          PageTransition(child: LoginPage(), type: PageTransitionType.fade));
    } catch (e) {
      return e;
    }
  }
}
