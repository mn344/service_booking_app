import 'package:get/get.dart';
import '../viewmodels/provider_viewmodel.dart';

class ProviderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderViewModel>(() => ProviderViewModel());
  }
}
