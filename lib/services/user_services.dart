import 'dart:async';
import 'package:crowd_funding/tabbar/tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/usermodel.dart';

class UserServices {
  UserServices();

  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late UserModel currentUserModel;

  late SharedPreferences _prefs;
  var acs = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    // URL must be whitelisted in the Firebase Console.
      url: 'https://www.example.com/finishSignUp?cartId=1234',
      // This must be true
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ios',
      androidPackageName: 'com.impokto.android',
      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '12');

  Future<void> login(String email, String password, context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {Fluttertoast.showToast(msg: "Login Successful")});
      User? user = _auth.currentUser;
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Tabbar()),
                (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      } else {
        Fluttertoast.showToast(msg: e.message.toString());
      }
    }
  }

  void Registration(
      String email,
      String password,
      var _formKey,
      var navID,
      BuildContext context,
      String name,
      ) async {
    if (_formKey.currentState.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
        postDetailsToFirestore(navID, context, name,)
      })
          .catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    }
  }

  void postDetailsToFirestore(
      var navID,
      BuildContext context,
      String name,
      ) async {
    //calling firestore and usermodel and sending value to cloud store

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = await _auth.currentUser;

    UserModel userModel = UserModel(
      uid: user!.uid,
      email: user.email!,
      name: name,
    );

    await firebaseFirestore
        .collection("user")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
  }

  // Sign Out
  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<UserModel> currentDetails() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user =  _auth.currentUser;

    var details =
    await firebaseFirestore.collection("user").doc(user!.uid).get();
    currentUserModel = UserModel.fromMap(details);
    return UserModel.fromMap(details);
  }

  Stream<UserModel> currentDetailsStream() {
    User? user = _auth.currentUser;
    var details = firebaseFirestore
        .collection("user")
        .doc(user!.uid)
        .snapshots()
        .map((snapshots) => UserModel.fromMap(snapshots.data()));

    return details;
  }

  Future<void> updateUser(UserModel data) async {
    User? user = _auth.currentUser;
    var details =
    firebaseFirestore.collection("user").doc(user!.uid).set(data.toMap());
  }

  void resendVerificationEmail() async {
    User? user = _auth.currentUser;
    user!.sendEmailVerification().then((value) => Fluttertoast.showToast(
        msg: "Please verify your email and try again login"));
  }

  Future<void> markUserEmailVerified() async {
    User? user = _auth.currentUser;
    await currentDetails();
    // currentUserModel.setEmailVerified(true);

    updateUser(currentUserModel);
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
