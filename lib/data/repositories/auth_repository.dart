import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<UserCredential> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim().toLowerCase(),
      password: password.trim(),
    );


    await createProfileIfMissing(
      uid: credential.user!.uid,
      email: credential.user!.email!,
    );

    return credential;
  }


  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim().toLowerCase(),
      password: password.trim(),
    );
  }


  Future<void> saveUserToFirestore({
    required String uid,
    required String email,
    required String role, // "user" | "provider"
  }) async {
    await _firestore.collection("users").doc(uid).set({
      "email": email.trim().toLowerCase(),
      "role": role,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }


  Future<bool> doesUserProfileExist(String uid) async {
    final doc = await _firestore.collection("users").doc(uid).get();
    return doc.exists;
  }


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


  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  bool isEmailVerified() {
    return _auth.currentUser?.emailVerified ?? false;
  }


  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email.trim().toLowerCase(),
    );
  }


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


  Future<String> getCurrentUserRole() async {
    final user = _auth.currentUser;
    if (user == null) return "user";

    final doc =
    await _firestore.collection('users').doc(user.uid).get();

    return doc.data()?['role'] ?? 'user';
  }


  Future<void> logout() async {
    await _auth.signOut();
  }
}
