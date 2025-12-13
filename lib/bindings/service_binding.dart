import 'package:get/get.dart';
import 'package:service_booking_app/viewmodels/services/service_viewmodel.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceViewModel>(() => ServiceViewModel());
  }
}
