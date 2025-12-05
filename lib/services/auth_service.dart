import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Signup
  Future<User?> register(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";
      if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already in use.";
      } else if (e.code == 'weak-password') {
        errorMessage = "The password is too weak.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is not valid.";
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Login
  Future<User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is not valid.";
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is not valid.";
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Change Password
  Future<void> changePassword(String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("User not logged in");
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";
      if (e.code == 'weak-password') {
        errorMessage = "The new password is too weak.";
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("An error occurred while logging out: ${e.toString()}");
    }
  }

  // Email verification
  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("User not logged in");
      await user.sendEmailVerification();
    } catch (e) {
      throw Exception("An error occurred while sending email verification: ${e.toString()}");
    }
  }

  // Auth Stream
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
