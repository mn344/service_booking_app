import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/auth_repository.dart';

class RegisterViewModel extends GetxController {
  final regNoController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  final AuthRepository _repo = AuthRepository();

  Future<void> register() async {
    final regNo = regNoController.text.trim();
    final password = passwordController.text.trim();

    if (regNo.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Fields cannot be empty");
      return;
    }

    final email = "$regNo@myapp.com";

    try {
      isLoading(true);

      await _repo.register(email, password);
      await _repo.sendEmailVerification();

      Get.snackbar("Success", "Verification email sent");
      Get.offAllNamed('/login');

    } catch (e) {
      Get.snackbar("SignUp Failed", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
