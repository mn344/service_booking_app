import 'package:get/get.dart';
import '../viewmodels/booking/booking_view_model.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingViewModel>(
          () => BookingViewModel(),
      fenix: true,
    );
  }
}
