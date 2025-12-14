import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodels/provider/provider_service_view_model.dart';
import '../../models/provider_service_model.dart';
import 'provider_add_update_service_screen.dart';

class ProviderManageServicesScreen extends StatefulWidget {
  const ProviderManageServicesScreen({super.key});

  @override
  State<ProviderManageServicesScreen> createState() =>
      _ProviderManageServicesScreenState();
}

class _ProviderManageServicesScreenState
    extends State<ProviderManageServicesScreen> {
  // ✅ ViewModel (SAFE)
  late final ProviderServiceViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = Get.find<ProviderServiceViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF06BEE1),
        title: const Text("Manage Services"),
        centerTitle: true,
      ),

      // =========================
      // ADD SERVICE
      // =========================
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF06BEE1),
        onPressed: () {
          // 👇 yahan direct screen OK hai (VM already exists)
          Get.to(() => const AddUpdateServiceScreen());
        },
        child: const Icon(Icons.add),
      ),

      // =========================
      // SERVICES LIST
      // =========================
      body: StreamBuilder<List<ProviderServiceModel>>(
        stream: vm.services(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No services added yet",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final services = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final s = services[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT ICON
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF06BEE1).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.cleaning_services,
                        color: Color(0xFF06BEE1),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // SERVICE INFO
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            s.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Rs ${s.price}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ACTIONS
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Get.to(
                                  () => AddUpdateServiceScreen(service: s),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            vm.deleteService(s.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
