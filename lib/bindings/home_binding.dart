import 'package:get/get.dart';
import '../viewmodels/home/home_viewmodel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeViewModel());
  }
}
