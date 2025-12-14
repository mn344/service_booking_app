import 'package:get/get.dart';
import '../viewmodels/provider/provider_service_view_model.dart';

class ProviderServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderServiceViewModel>(
            () => ProviderServiceViewModel(),
    );
  }
}
