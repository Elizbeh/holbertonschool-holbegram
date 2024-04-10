import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';
import 'package:logger/logger.dart';

final logger = Logger();


class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> login({required String email, required String password}) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return "Please fill all the fields";
    }
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } catch (e) {
      logger.e('Error occurred while logging in: $e');
      return e.toString();
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
      try {
        if (email.isEmpty || password.isEmpty || username.isEmpty) {
          return "Please fill all the fields";
    }
      if (password.length < 6 ) {
        return "PAssword must be at least 6 characters long";
      }
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'username': username,
        });
        return 'success';
      } else {
        return 'An error occurred while signing up';
      }
    } catch (e) {
      logger.e('Error signing up: $e');
      return 'An error occurred while signing up';
    }
  }
}
