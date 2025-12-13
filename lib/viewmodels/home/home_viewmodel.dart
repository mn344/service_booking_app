import 'package:get/get.dart';
import '../../models/main_service_model.dart';
import '../../data/repositories/main_service_repository.dart';

class HomeViewModel extends GetxController {

  // 🔵 Repository
  final MainServiceRepository _repo = MainServiceRepository();

  // 🔵 Services list (Firestore data)
  var services = <MainServiceModel>[].obs;

  // 🔵 Loading state
  var isLoading = false.obs;

  // 🔵 Load main services from Firestore
  Future<void> loadMainServices() async {
    try {
      isLoading.value = true;
      services.value = await _repo.getMainServices();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load services",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
