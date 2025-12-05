import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/auth_repository.dart';

class ResetPasswordViewModel extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  final AuthRepository _repo = AuthRepository();

  Future<void> sendResetLink() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar("Error", "Email cannot be empty");
      return;
    }

    try {
      isLoading(true);

      await _repo.resetPassword(email);

      Get.snackbar("Success", "Password reset email sent");

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
