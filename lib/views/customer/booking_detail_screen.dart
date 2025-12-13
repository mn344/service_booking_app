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

    final String name = args['name'] ?? '';
    final String phone = args['phone'] ?? '';
    final String address = args['address'] ?? '';
    final String mainType = args['mainType'] ?? '';
    final int totalPrice = args['totalPrice'] ?? 0;

    final List<CleaningServiceModel> services =
    args['services'] != null
        ? List<CleaningServiceModel>.from(args['services'])
        : [];

    return Scaffold(
      appBar: AppBar(title: const Text("Booking Detail")),
      body: SingleChildScrollView( // 🔥 overflow FIX
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title("User Information"),
              _row("Name", name),
              _row("Phone", phone),
              _row("Address", address),

              const SizedBox(height: 16),

              _title("Selected Services"),
              services.isEmpty
                  ? const Center(child: Text("No services selected"))
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

              const Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rs $totalPrice",
                    style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// 🔥 CONFIRM BUTTON
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
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Confirm Booking"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  Widget _title(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style:
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text("$label: $value"),
  );
}
