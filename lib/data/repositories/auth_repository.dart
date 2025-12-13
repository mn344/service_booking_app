import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------------- LOGIN ----------------
  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim().toLowerCase(), // 🔴 normalize email
      password: password.trim(),
    );
  }

  // ---------------- REGISTER ----------------
  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim().toLowerCase(), // 🔴 normalize email
      password: password.trim(),
    );
  }

  // ---------------- SAVE USER DATA ----------------
  Future<void> saveUserToFirestore({
    required String uid,
    required String email,
    required String role,
  }) async {
    await _firestore.collection("users").doc(uid).set({
      "email": email.trim().toLowerCase(), // 🔴 normalize email
      "role": role,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  // 🔴 NEW: CHECK USER PROFILE EXISTS
  Future<bool> doesUserProfileExist(String uid) async {
    final doc =
    await _firestore.collection("users").doc(uid).get();
    return doc.exists;
  }

  // 🔴 NEW: AUTO CREATE PROFILE IF MISSING (LOGIN SAFETY)
  Future<void> createProfileIfMissing({
    required String uid,
    required String email,
  }) async {
    final exists = await doesUserProfileExist(uid);

    if (!exists) {
      await saveUserToFirestore(
        uid: uid,
        email: email,
        role: "user", // default role
      );
    }
  }

  // ---------------- EMAIL VERIFICATION ----------------
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  bool isEmailVerified() {
    final user = _auth.currentUser;
    return user?.emailVerified ?? false;
  }

  // ---------------- RESET PASSWORD ----------------
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email.trim().toLowerCase(), // 🔴 normalize email
    );
  }

  // ---------------- CHANGE PASSWORD ----------------
  Future<void> changePassword({
    required String oldPass,
    required String newPass,
  }) async {
    final user = _auth.currentUser;

    if (user == null || user.email == null) {
      throw Exception("User not logged in");
    }

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: oldPass,
    );

    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPass);
  }

  // ---------------- LOGOUT ----------------
  Future<void> logout() async {
    await _auth.signOut();
  }
}
