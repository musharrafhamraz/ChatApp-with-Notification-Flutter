import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of auth

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get the current user

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign in method

  Future<UserCredential> signInWithEmailandPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // _firestore
      //     .collection('Users')
      //     .doc(userCredential.user!.uid)
      //     .set({'uid': userCredential.user!.uid, 'email': email});

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // signup with email and password

  Future<UserCredential> signUpWithEmailandPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      // save user's data in a separate document
      _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email, 'name': name});

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // signout method

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
