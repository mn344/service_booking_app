import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../data/repositories/auth_repository.dart';

class LoginViewModel extends GetxController {
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  final AuthRepository _repo = AuthRepository();

  Future<String> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw "Email and password cannot be empty";
    }

    try {
      isLoading(true);

      final userCredential = await _repo.login(email, password);
      final user = userCredential.user;

      if (user == null) {
        throw "Login failed";
      }

      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser == null || !refreshedUser.emailVerified) {
        await _repo.logout();
        throw "Please verify your email before login";
      }

      final snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(refreshedUser.uid)
          .get();

      if (!snap.exists) {
        throw "User profile not found";
      }

      final String? role = snap.data()?['role'] as String?;

      if (role == null) {
        throw "Role not assigned";
      }

      if (role != 'user' && role != 'provider') {
        throw "Invalid role assigned";
      }

      return role;
    } finally {
      isLoading(false);
    }
  }
}
