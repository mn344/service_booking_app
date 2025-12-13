import 'package:get/get.dart';
import '../models/provider_model.dart';
import '../data/repositories/provider_repository.dart';

class ProviderViewModel extends GetxController {
  final ProviderRepository _repository = ProviderRepository();

  // Provider list
  final RxList<ProviderModel> providers = <ProviderModel>[].obs;

  // Selected index
  final RxInt selectedIndex = (-1).obs;

  // Selected provider getter
  ProviderModel? get selectedProvider =>
      selectedIndex.value == -1
          ? null
          : providers[selectedIndex.value];

  @override
  void onInit() {
    super.onInit();
    loadProviders();
  }

  // Load providers from repository
  void loadProviders() {
    providers.assignAll(_repository.fetchProviders());
  }

  // Select provider
  void selectProvider(int index) {
    selectedIndex.value = index;
  }
}
