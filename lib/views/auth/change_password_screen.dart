import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodels/auth/change_password_view_model.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordViewModel viewModel = Get.put(ChangePasswordViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🔵 Full white background
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // OLD PASSWORD LABEL
            const Text(
              "Old Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,   // Increased size
              ),
            ),
            const SizedBox(height: 8),

            // OLD PASSWORD FIELD
            TextField(
              controller: viewModel.oldPassController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            // NEW PASSWORD LABEL
            const Text(
              "New Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13, // Increased size
              ),
            ),
            const SizedBox(height: 8),

            // NEW PASSWORD FIELD
            TextField(
              controller: viewModel.newPassController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: true,
            ),

            const SizedBox(height: 30),

            // UPDATE BUTTON
            Obx(() => SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // 🔵 Blue button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: viewModel.isLoading.value
                    ? null
                    : () async {
                  await viewModel.changePassword();
                },
                child: viewModel.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  "Update Password",
                  style: TextStyle(
                    color: Colors.white,  // White text
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
