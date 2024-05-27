import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _firebaseAuth.currentUser!.uid;
    } catch (error) {
      print("Error signing in: $error");
      throw error;
    }
  }

  Future<String> createUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _firebaseAuth.currentUser!.uid;
    } catch (error) {
      print("Error creating user: $error");
      throw error;
    }
  }

  Future<String?> currentUser() async {
    User? user = _firebaseAuth.currentUser;
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _firebaseStorage.ref().child('images/$fileName');
      await ref.putFile(imageFile);
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print("Error uploading image: $error");
      throw error;
    }
  }
}
