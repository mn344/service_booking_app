import 'package:get/get.dart';
import '../../data/repositories/booking_repository.dart';
import '../../models/booking_model.dart';

class BookingViewModel extends GetxController {
  final BookingRepository _repository = BookingRepository();

  final RxBool isSubmitting = false.obs;

  Future<void> submitBooking(BookingModel booking) async {
    try {
      isSubmitting.value = true;
      await _repository.createBooking(booking);
    } finally {
      isSubmitting.value = false;
    }
  }
}
