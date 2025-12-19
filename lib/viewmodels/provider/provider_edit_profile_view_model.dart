import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/media_repository.dart';

class ProviderEditProfileVM extends GetxController {
  final MediaRepo _mediaRepo = MediaRepo();

  var isLoading = false.obs;
  var profileImageUrl = "".obs;
  var name = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // ================= FETCH PROFILE =================
  Future<void> fetchProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      name.value = data['name'] ?? '';
      profileImageUrl.value = data['profileImageUrl'] ?? '';
    }
  }

  // ================= UPDATE PROFILE =================
  Future<bool> updateProfile({
    required String name,
    Uint8List? imageBytes, // ✅ WEB SAFE
  }) async {
    try {
      isLoading.value = true;

      final uid = FirebaseAuth.instance.currentUser!.uid;
      String imageUrl = profileImageUrl.value;

      // upload only if new image selected
      if (imageBytes != null) {
        final uploadedUrl =
        await _mediaRepo.uploadProfileImageBytes(imageBytes);

        if (uploadedUrl != null) {
          imageUrl = uploadedUrl;
        }
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({
        'name': name,
        'profileImageUrl': imageUrl,
      });

      this.name.value = name;
      profileImageUrl.value = imageUrl;

      return true;
    } catch (e) {
      print("Update Profile Error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
