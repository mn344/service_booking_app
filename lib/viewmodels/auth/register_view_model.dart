import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../data/repositories/auth_repository.dart';

class RegisterViewModel extends GetxController {
  final regNoController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final AuthRepository _repo = AuthRepository();

  Future<void> register(String userType) async {
    final email = regNoController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Fields cannot be empty");
      return;
    }

    if (!email.contains("@")) {
      Get.snackbar("Error", "Enter a valid email");
      return;
    }

    try {
      isLoading(true);

      // 1️⃣ Firebase Auth
      final userCredential = await _repo.register(email, password);
      final uid = userCredential.user!.uid;

      await _repo.saveUserToFirestore(
        uid: uid,
        email: email,
        role: userType,
      );


      // 3️⃣ Email verification
      await _repo.sendEmailVerification();

      Get.snackbar(
        "Success",
        "Verification email sent. Please verify before login.",
      );

      // 4️⃣ Correct navigation
      if (userType == "provider") {
        Get.offAllNamed('/loginProvider');
      } else {
        Get.offAllNamed('/loginUser');
      }

    } catch (e) {
      Get.snackbar("SignUp Failed", e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    regNoController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
