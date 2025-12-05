import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/auth/profile_screen_view_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // Inject ViewModel
  final ProfileScreenViewModel viewModel = Get.put(ProfileScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // HEADER
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),

          // PROFILE IMAGE (overlapping)
          Transform.translate(
            offset: const Offset(0, -60),
            child: const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                AssetImage("assets/images/chimny_cleaner.png"),
              ),
            ),
          ),

          // USER NAME (Static — update later if you want dynamic)
          const Text(
            "Maham Fatima",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // PHONE + EMAIL INFO
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Phone",
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                    Text("+5999-771-7171",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email",
                        style: TextStyle(color: Colors.grey, fontSize: 16)),
                    Text("mahamzaman364@gmail.com",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
          const Divider(),

          // ----------------------------------
          // SETTINGS SECTION
          // ----------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: const Text("Dark mode"),
                  trailing: Switch(
                    value: false,
                    onChanged: (v) {},
                  ),
                ),
                const Divider(),

                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text("Profile details"),
                  onTap: () {},
                ),
                const Divider(),

                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text("Settings"),
                  onTap: () {},
                ),
                const Divider(),

                // -------------------
                // LOGOUT BUTTON (MVVM)
                // -------------------
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Log out"),
                  onTap: () {
                    viewModel.logout();   // Call ViewModel logout
                  },
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
