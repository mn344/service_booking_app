import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodels/provider_viewmodel.dart';
import '../../routes.dart';

class ProviderListScreen extends StatelessWidget {
  ProviderListScreen({super.key});

  // ✅ Receive arguments via GetX
  final Map<String, dynamic> args =
  Get.arguments as Map<String, dynamic>;

  late final String name = args['name'];
  late final String phone = args['phone'];
  late final String address = args['address'];
  late final String mainType = args['mainType'];
  late final int totalPrice = args['totalPrice'];
  late final List services = args['services'];

  @override
  Widget build(BuildContext context) {
    final ProviderViewModel vm = Get.find<ProviderViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Provider"),
      ),

      body: Obx(
            () => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: vm.providers.length,
          itemBuilder: (context, index) {
            final provider = vm.providers[index];
            final isSelected = vm.selectedIndex.value == index;

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Image.asset(
                  provider.image,
                  width: 45,
                  height: 45,
                ),
                title: Text(provider.name),
                subtitle: Text(provider.price),
                trailing: Icon(
                  Icons.check_circle,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                onTap: () => vm.selectProvider(index),
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: Obx(
            () => Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: vm.selectedProvider == null
                ? null
                : () {
              final p = vm.selectedProvider!;

              // ✅ CORRECT GetX navigation
              Get.toNamed(
                Routes.bookingDetail,
                arguments: {
                  'name': name,
                  'phone': phone,
                  'address': address,
                  'mainType': mainType,
                  'totalPrice': totalPrice,
                  'services': services,

                  // provider info
                  'providerName': p.name,
                  'providerPrice': p.price,
                  'providerRating': p.rating,
                  'providerImage': p.image,
                },
              );
            },
            child: const Text(
              "NEXT",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
