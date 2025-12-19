import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';
import '../../models/cleaning_service_model.dart';
import '../../models/booking_model.dart';
import '../../viewmodels/booking/booking_view_model.dart';

class BookingDetailScreen extends GetView<BookingViewModel> {
  const BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    (Get.arguments ?? {}) as Map<String, dynamic>;

    // ---------------- USER INFO ----------------
    final String name = args['name'] ?? '';
    final String phone = args['phone'] ?? '';
    final String address = args['address'] ?? '';

    // ---------------- BOOKING INFO ----------------
    final String mainType = args['mainType'] ?? '';
    final int totalPrice = args['totalPrice'] ?? 0;

    // ---------------- SERVICES (FIXED KEY) ----------------
    final List<CleaningServiceModel> services =
    (args['selectedServices'] ?? []).cast<CleaningServiceModel>();


    // ---------------- PROVIDER INFO ----------------
    final String providerName = args['providerName'] ?? '';
    final String providerPrice = args['providerPrice'] ?? '';
    final String providerRating = args['providerRating'] ?? '';
    final String providerImage = args['providerImage'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Detail"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- USER INFO ----------------
            _title("User Information"),
            _row("Name", name),
            _row("Phone", phone),
            _row("Address", address),

            const SizedBox(height: 16),

            // ---------------- PROVIDER ----------------
            _title("Selected Provider"),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: _providerImage(providerImage),
                title: Text(
                  providerName.isEmpty ? "No provider selected" : providerName,
                ),
                subtitle: Text("Rating: $providerRating"),
                trailing: Text("Rs $providerPrice"),
              ),
            ),

            const SizedBox(height: 16),

            // ---------------- SERVICES ----------------
            _title("Selected Services"),
            services.isEmpty
                ? const Text("No services selected")
                : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (_, index) {
                final s = services[index];
                return ListTile(
                  title: Text(s.category),
                  trailing: Text("Rs ${s.price}"),
                );
              },
            ),

            const Divider(height: 30),

            // ---------------- TOTAL ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rs $totalPrice",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ---------------- CONFIRM BUTTON ----------------
            Obx(
                  () => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isSubmitting.value
                      ? null
                      : () async {
                    final booking = BookingModel(
                      userId: "temp_user_id",
                      name: name,
                      phone: phone,
                      address: address,
                      mainType: mainType,
                      services: services,
                      totalPrice: totalPrice,
                    );

                    await controller.submitBooking(booking);

                    Get.snackbar(
                      "Success",
                      "Booking saved successfully",
                      backgroundColor: Colors.green.shade100,
                    );

                    Get.offAllNamed(Routes.home);
                  },
                  child: controller.isSubmitting.value
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text("Confirm Booking"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- IMAGE HANDLER ----------------
  Widget _providerImage(String image) {
    if (image.isEmpty) {
      return const Icon(Icons.person, size: 40);
    }

    if (image.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          image,
          width: 45,
          height: 45,
          fit: BoxFit.cover,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        image,
        width: 45,
        height: 45,
        fit: BoxFit.cover,
      ),
    );
  }

  // ---------------- UI HELPERS ----------------
  Widget _title(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text("$label: $value"),
  );
}
