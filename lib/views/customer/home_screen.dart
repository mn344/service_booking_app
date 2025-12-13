import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../viewmodels/home/home_viewmodel.dart';
import '../../routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // 🔵 STEP 4: ViewModel inject
  final HomeViewModel controller = Get.find<HomeViewModel>();

  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    controller.loadMainServices(); // 🔵 Firestore call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(context),

      body: SafeArea(
        child: Column(
          children: [

            // ---------------- HEADER ----------------
            _buildHeader(),

            const SizedBox(height: 14),

            // ---------------- GRID (FROM FIRESTORE) ----------------
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.services.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (context, index) {
                    final service = controller.services[index];

                    return _serviceCard(
                      index: index,
                      title: service.title,
                      icon: _mapIcon(service.icon),
                      onTap: () {
                        Get.toNamed(
                          Routes.booking,
                          arguments: service.type, // 🔵 mainType
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- SERVICE CARD ----------------
  Widget _serviceCard({
    required int index,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0A3D62) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon,
                size: 34,
                color: isSelected ? Colors.white : Colors.black87),
            const SizedBox(height: 18),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.arrow_forward,
                size: 20,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- ICON MAP ----------------
  IconData _mapIcon(String icon) {
    switch (icon) {
      case 'house':
        return Icons.house_rounded;
      case 'apartment':
        return Icons.apartment_rounded;
      case 'cleaning':
        return Icons.cleaning_services_rounded;
      case 'laundry':
        return Icons.local_laundry_service_rounded;
      default:
        return Icons.cleaning_services;
    }
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff06BEE1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello Maham",
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "How can we help?",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- DRAWER ----------------
  Widget _buildDrawer(BuildContext context) {
    return const Drawer(); // tumhara existing drawer
  }
}
