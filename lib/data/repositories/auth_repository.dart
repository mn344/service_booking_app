import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ----------------------------
  // LOGIN
  // ----------------------------
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // ----------------------------
  // REGISTER
  // ----------------------------
  Future<void> register(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // ----------------------------
  // EMAIL VERIFICATION
  // ----------------------------
  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  // ----------------------------
  // RESET PASSWORD
  // ----------------------------
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // ----------------------------
  // CHANGE PASSWORD
  // ----------------------------
  Future<void> changePassword(
      {required String oldPass, required String newPass}) async {
    User? user = _auth.currentUser;

    if (user == null) throw FirebaseAuthException(code: "no-user");

    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: oldPass,
    );

    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPass);
  }

  // ----------------------------
  // LOGOUT
  // ----------------------------
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ----------------------------
  // CHECK EMAIL VERIFIED
  // ----------------------------
  bool isEmailVerified() {
    return _auth.currentUser?.emailVerified ?? false;
  }
}
