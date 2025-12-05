import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/auth_repository.dart';

class ChangePasswordViewModel extends GetxController {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();

  final isLoading = false.obs;

  final AuthRepository _repo = AuthRepository();

  Future<void> changePassword() async {
    final oldPass = oldPassController.text.trim();
    final newPass = newPassController.text.trim();

    if (oldPass.isEmpty || newPass.isEmpty) {
      Get.snackbar("Error", "Fields cannot be empty");
      return;
    }

    try {
      isLoading(true);

      await _repo.changePassword(
        oldPass: oldPass,
        newPass: newPass,
      );

      Get.snackbar("Success", "Password updated");

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
