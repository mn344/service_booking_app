import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/change_password_screen.dart';
// ROUTES
import '../../routes.dart';

// PROVIDER SCREENS
import 'provider_job_detail_screen.dart';
import 'provider_edit_profile_screen.dart';
import 'provider_update_category_screen.dart';
import 'provider_bookings_screen.dart';
import 'chat/provider_chat_list_screen.dart';

class ProviderHomeScreen extends StatelessWidget {
  ProviderHomeScreen({super.key});

  // ================= STATIC PROVIDER JOBS =================
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

      // ================= DRAWER =================
      drawer: const ProviderDrawer(),

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xFF06BEE1),
        elevation: 0,
        centerTitle: true,
        title: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            final data = snapshot.data?.data() as Map<String, dynamic>?;
            final name = data?['name'] ?? "Provider";

            return Text(
              "Hello $name",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            );
          },
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),

      // ================= BODY (STATIC JOBS) =================
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
                  BoxShadow(color: Colors.black12, blurRadius: 6),
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
                      BoxShadow(color: Colors.black12, blurRadius: 6),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              job["address"],
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              job["date"],
                              style: const TextStyle(color: Colors.blue),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  job["price"],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(
                                            () => const ProviderJobDetailScreen());
                                  },
                                  child: const Text("Details"),
                                )
                              ],
                            )
                          ],
                        ),
                      )
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

// =======================================================
// PROVIDER DRAWER (DYNAMIC – FIRESTORE)
// =======================================================

class ProviderDrawer extends StatelessWidget {
  const ProviderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Drawer(
      backgroundColor: Colors.white,
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.data?.data() as Map<String, dynamic>?;

          final name = data?['name'] ?? "Provider";
          final email = data?['email'] ?? "";
          final imageUrl = data?['profileImageUrl'];

          return ListView(
            children: [
              DrawerHeader(
                decoration:
                const BoxDecoration(color: Color(0xFF2A2D52)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: imageUrl != null &&
                          imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl)
                          : const AssetImage(
                          "assets/images/bathroom_cleaner.png")
                      as ImageProvider,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      name,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      email,
                      style:
                      const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              _drawerItem(Icons.home, "Home", () => Get.back()),
              _drawerItem(Icons.work, "Job Details",
                      () => Get.to(() => const ProviderJobDetailScreen())),
              _drawerItem(Icons.assignment, "Bookings",
                      () => Get.to(() => const ProviderBookingsScreen())),
              _drawerItem(Icons.category, "Add & Update Category",
                      () => Get.to(() => const ProviderUpdateCategoryScreen())),
              _drawerItem(Icons.design_services, "Manage Services",
                      () => Get.toNamed(Routes.providerManageServices)),
              _drawerItem(Icons.lock, "Change Password",
                      () => Get.to(() => ChangePasswordScreen())),
              _drawerItem(Icons.edit, "Edit Profile",
                      () => Get.to(() => const ProviderEditProfileScreen())),
              _drawerItem(Icons.chat, "Chat List",
                      () => Get.to(() => const ProviderChatListScreen())),
              _drawerItem(Icons.logout, "Logout", () {
                Get.defaultDialog(
                  title: "Confirm logout",
                  middleText: "Are you sure you want to log out?",
                  textCancel: "Cancel",
                  textConfirm: "OK",
                  confirmTextColor: Colors.white,
                  onConfirm: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.offAllNamed(Routes.loginProvider);
                  },
                );
              }),

            ],
          );
        },
      ),
    );
  }
}

// =======================================================
// DRAWER ITEM WIDGET
// =======================================================

Widget _drawerItem(
    IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: Colors.black87),
    title:
    Text(title, style: const TextStyle(color: Colors.black87)),
    onTap: onTap,
  );
}
