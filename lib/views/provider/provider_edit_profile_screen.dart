import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../viewmodels/provider/provider_edit_profile_view_model.dart';

class ProviderEditProfileScreen extends StatefulWidget {
  const ProviderEditProfileScreen({super.key});

  @override
  State<ProviderEditProfileScreen> createState() =>
      _ProviderEditProfileScreenState();
}

class _ProviderEditProfileScreenState
    extends State<ProviderEditProfileScreen> {

  final ProviderEditProfileVM viewModel =
  Get.put(ProviderEditProfileVM());

  final TextEditingController nameController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Uint8List? _selectedImageBytes; // ✅ WEB SAFE

  @override
  void initState() {
    super.initState();

    /// auto fill name
    ever(viewModel.name, (value) {
      nameController.text = value;
    });
  }

  // ================= PICK IMAGE =================
  Future<void> pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _selectedImageBytes = bytes;
      });
    }
  }

  // ================= IMAGE PROVIDER =================
  ImageProvider _getProfileImage() {
    if (_selectedImageBytes != null) {
      return MemoryImage(_selectedImageBytes!); // ✅ FIX
    }

    if (viewModel.profileImageUrl.value.isNotEmpty) {
      return NetworkImage(viewModel.profileImageUrl.value);
    }

    return const AssetImage("assets/images/bathroom_cleaner.png");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Color(0xFF2A2D52),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ================= PROFILE IMAGE =================
            Obx(() {
              return Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _getProfileImage(),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2A2D52),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 30),

            // ================= NAME =================
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Name",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 6),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter Name",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ================= SAVE BUTTON =================
            Obx(() {
              return GestureDetector(
                onTap: viewModel.isLoading.value
                    ? null
                    : () async {
                  final success =
                  await viewModel.updateProfile(
                    name: nameController.text.trim(),
                    imageBytes: _selectedImageBytes, // ✅ FIX
                  );

                  if (success && mounted) {
                    Get.back();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: viewModel.isLoading.value
                        ? Colors.grey
                        : Colors.lightBlueAccent.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: viewModel.isLoading.value
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      "Save Changes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
