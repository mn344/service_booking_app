import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/views/provider/provider_manage_services_screen.dart';
import '../../routes.dart';


// PROVIDER SCREENS
import 'package:service_booking_app/views/provider/provider_job_detail_screen.dart';
import 'package:service_booking_app/views/provider/provider_edit_profile_screen.dart';
import 'package:service_booking_app/views/provider/provider_update_category_screen.dart';
import 'package:service_booking_app/views/provider/chat/provider_chat_list_screen.dart';
import 'package:service_booking_app/views/provider/provider_bookings_screen.dart';

class ProviderHomeScreen extends StatelessWidget {
  ProviderHomeScreen({super.key});

  final List<Map<String, dynamic>> providerJobs = const [
    {
      "name": "Sofa Cleaning Expert",
      "image": "assets/images/sofa_cleaner.png",
      "address": "Dhakkan Wala Kua, Trade House, Indore",
      "date": "23 April, 2022 11:00 am",
      "price": "₹ 800"
    },
    {
      "name": "Deep Cleaning Service",
      "image": "assets/images/deep_cleaner.png",
      "address": "214-215, Trade House, Indore",
      "date": "23 April, 2022 11:00 am",
      "price": "₹ 950"
    },
    {
      "name": "Bathroom Cleaning",
      "image": "assets/images/bathroom_cleaner.png",
      "address": "S Tukoganj Road, Indore",
      "date": "23 April, 2022 11:00 am",
      "price": "₹ 700"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      drawer: const ProviderDrawer(),

      appBar: AppBar(
        backgroundColor: const Color(0xFF06BEE1),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Hello Jonathen James",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search Jobs...",
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: Colors.blue),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: providerJobs.length,
              itemBuilder: (context, index) {
                final job = providerJobs[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          job["image"],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job["name"],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              job["address"],
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              job["date"],
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.blue),
                            ),
                            const SizedBox(height: 8),

                            Row(
                              children: [
                                Text(
                                  job["price"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                                const Spacer(),

                                IconButton(
                                  icon: const Icon(Icons.call, color: Colors.blue),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.chat, color: Colors.blue),
                                  onPressed: () {},
                                ),

                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple.shade100,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                  onPressed: () {
                                    Get.to(() => const ProviderJobDetailScreen());
                                  },
                                  child: const Text(
                                    "Details",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ====================================================
// PROVIDER DRAWER — UPDATED TO GETX ✔
// ====================================================

class ProviderDrawer extends StatelessWidget {
  const ProviderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xFF2A2D52),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                        AssetImage("assets/images/bathroom_cleaner.png"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Jonathan",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        "john@mail.com",
                        style:
                        TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.to(() => const ProviderEditProfileScreen());
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ================= DRAWER ITEMS =================

            _drawerItem(
              Icons.home_outlined,
              "Home",
                  () {
                Get.back();
              },
            ),

            _drawerItem(
              Icons.work_outline,
              "Job Details",
                  () {
                Get.back();
                Get.to(() => const ProviderJobDetailScreen());
              },
            ),

            _drawerItem(
              Icons.assignment_outlined,
              "Bookings",
                  () {
                Get.back();
                Get.to(() => const ProviderBookingsScreen());
              },
            ),

            _drawerItem(
              Icons.category_outlined,
              "Add & Update Category",
                  () {
                Get.back();
                Get.to(() => const ProviderUpdateCategoryScreen());
              },
            ),

            // ✅ ALREADY CORRECT (kept same)
            _drawerItem(
              Icons.design_services_outlined,
              "Manage Services",
                  () {
                Get.back();
                Get.toNamed(Routes.providerManageServices);
              },
            ),

            _drawerItem(
              Icons.chat_outlined,
              "Chat List",
                  () {
                Get.back();
                Get.to(() => const ProviderChatListScreen());
              },
            ),

            _drawerItem(
              Icons.help_outline,
              "Help & Support",
                  () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}




Widget _drawerItem(IconData icon, String text, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: Colors.black87),
    title: Text(text, style: const TextStyle(color: Colors.black87)),
    onTap: onTap,
  );
}