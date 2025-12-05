import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/auth_repository.dart';

class LoginViewModel extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  final AuthRepository _repo = AuthRepository();

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and password cannot be empty");
      return;
    }

    try {
      isLoading(true);

      await _repo.login(email, password);

      if (!_repo.isEmailVerified()) {
        Get.snackbar("Email Verification", "Please verify your email first.");
        return;
      }

      Get.snackbar("Success", "Login Successful");
      Get.offAllNamed('/home');

    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
