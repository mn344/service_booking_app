import 'package:get/get.dart';
import '../../models/cleaning_service_model.dart';
import '../../data/repositories/main_service_repository.dart';

class ServiceViewModel extends GetxController {
  final MainServiceRepository _repository = MainServiceRepository();

  // 🔵 Loading state
  final RxBool isLoading = false.obs;

  // 🔵 All services
  final RxList<CleaningServiceModel> services =
      <CleaningServiceModel>[].obs;

  // 🔵 Selected services
  final RxList<CleaningServiceModel> selectedServices =
      <CleaningServiceModel>[].obs;

  // 🔵 TOTAL PRICE
  final RxInt totalPrice = 0.obs;

  // 🔵 Load services by mainType
  Future<void> loadServices(String mainType) async {
    try {
      isLoading.value = true;
      services.value =
      await _repository.getCleaningServicesByType(mainType);
    } finally {
      isLoading.value = false;
    }
  }

  // 🔵 Select / Deselect service
  void toggleService(CleaningServiceModel service) {
    if (selectedServices.contains(service)) {
      selectedServices.remove(service);
    } else {
      selectedServices.add(service);
    }

    // 🔥 Recalculate total price
    totalPrice.value = selectedServices.fold(
      0,
          (sum, item) => sum + item.price,
    );
  }

  // 🔵 Clear selection
  void clearSelection() {
    selectedServices.clear();
    totalPrice.value = 0;
  }
}
