// ignore_for_file: nullable_type_in_catch_clause, avoid_print, use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/src/core/utils/show_snackbar.dart';
import 'package:event_app/src/features/auth/data/model/user_model.dart';
import 'package:event_app/src/features/auth/presentation/views/base_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserModel> getUserDetails() async {
    final snap =
        await _firestore
            .collection('Users')
            .where('userId', isEqualTo: _firebaseAuth.currentUser!.uid)
            .get();
    return UserModel.fromSnap(snap.docs.first);
  }

  Future<UserModel?> signUpUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        UserModel user = UserModel(
          userId: firebaseUser.uid,
          email: firebaseUser.email ?? '',
        );
        await _firestore.collection('Users').add(user.toJson());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BaseView()),
          (route) => false,
        );
        return user;
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<UserModel?> signinuser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String res = "Some error occured";

    try {
      if (password.isNotEmpty || email.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        res = "Success";
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BaseView()),
          (route) => false,
        );
      } else {
        showSnackbar(msg: 'Please fill all fields', ctx: context);

        res = "Please fill all fields";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "user-not-found") {
        showSnackbar(msg: 'User not found', ctx: context);
        res = "User not registred";
      } else if (err.code == "wrong-password") {
        showSnackbar(msg: 'Invalid Password', ctx: context);

        res = "Wrong password";
      }
    } catch (err) {
      print(err.toString());
    }

    return null;
  }

  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }
}
