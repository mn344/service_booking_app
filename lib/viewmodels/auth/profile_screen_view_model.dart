import 'package:get/get.dart';
import '../../../../data/repositories/auth_repository.dart';

class ProfileScreenViewModel extends GetxController {
  final AuthRepository _repo = AuthRepository();

  Future<void> logout() async {
    await _repo.logout();
    Get.offAllNamed('/login');
  }
}
