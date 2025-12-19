import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodels/provider_viewmodel.dart';
import '../../routes.dart';

class ProviderListScreen extends StatefulWidget {
  const ProviderListScreen({super.key});

  @override
  State<ProviderListScreen> createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen> {
  late ProviderViewModel vm;

  // 🔹 RECEIVED ARGUMENTS
  late String name;
  late String phone;
  late String address;
  late String mainType;
  late int totalPrice;
  late List<dynamic> selectedServices;

  @override
  void initState() {
    super.initState();

    vm = Get.find<ProviderViewModel>();

    final Map<String, dynamic> args =
    (Get.arguments ?? {}) as Map<String, dynamic>;

    name = args['name'] ?? '';
    phone = args['phone'] ?? '';
    address = args['address'] ?? '';
    mainType = args['mainType'] ?? '';
    totalPrice = args['totalPrice'] ?? 0;
    selectedServices = args['selectedServices'] ?? [];

    // ✅ FIXED: no argument
    vm.loadProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Select Provider"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      // ---------------- PROVIDER LIST ----------------
      body: Obx(() {
        if (vm.providers.isEmpty) {
          return const Center(child: Text("No providers available"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: vm.providers.length,
          itemBuilder: (context, index) {
            final provider = vm.providers[index];
            final isSelected = vm.selectedIndex.value == index;

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: _providerImage(provider.image),
                title: Text(
                  provider.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text("Rs ${provider.price}"),
                trailing: Icon(
                  Icons.check_circle,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                onTap: () => vm.selectProvider(index),
              ),
            );
          },
        );
      }),

      // ---------------- NEXT BUTTON ----------------
      bottomNavigationBar: Obx(
            () => Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: vm.selectedIndex.value == -1
                ? null
                : () {
              final p = vm.selectedProvider!;

              Get.toNamed(
                Routes.bookingDetail,
                arguments: {
                  'name': name,
                  'phone': phone,
                  'address': address,
                  'mainType': mainType,
                  'totalPrice': totalPrice,
                  'selectedServices': selectedServices,

                  // ✅ PROVIDER DATA
                  'providerName': p.name,
                  'providerPrice': p.price,
                  'providerRating': p.rating,
                  'providerImage': p.image,
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              disabledBackgroundColor:
              Colors.blue.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text("NEXT", style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }

  Widget _providerImage(String? image) {
    if (image != null && image.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(image, width: 45, height: 45, fit: BoxFit.cover),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        image ?? 'assets/images/user_avatar.jpg',
        width: 45,
        height: 45,
        fit: BoxFit.cover,
      ),
    );
  }
}
