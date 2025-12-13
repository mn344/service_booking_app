import 'package:get/get.dart';
import '../../../../data/repositories/auth_repository.dart';

class ResetPasswordViewModel extends GetxController {
  final RxBool isLoading = false.obs;
  final AuthRepository _repo = AuthRepository();

  /// Sends password reset email
  /// Throws String on validation / error
  Future<void> sendResetLink(String email) async {
    final String trimmedEmail = email.trim();

    // Validation
    if (trimmedEmail.isEmpty) {
      throw "Email cannot be empty";
    }

    if (!GetUtils.isEmail(trimmedEmail)) {
      throw "Enter a valid email address";
    }

    try {
      isLoading.value = true;
      await _repo.resetPassword(trimmedEmail);
    } catch (e) {
      throw e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
