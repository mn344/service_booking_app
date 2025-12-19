import 'dart:typed_data';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import '../../config/cloudinary_config.dart';

class MediaRepo {
  late Cloudinary cloudinary;

  MediaRepo() {
    cloudinary = Cloudinary.full(
      apiKey: CloudinaryConfig.apiKey,
      apiSecret: CloudinaryConfig.apiSecret,
      cloudName: CloudinaryConfig.cloudName,
    );
  }


  Future<String?> uploadProfileImageBytes(Uint8List bytes) async {
    try {
      final response = await cloudinary.uploadResource(
        CloudinaryUploadResource(
          resourceType: CloudinaryResourceType.image,
          fileBytes: bytes,
          folder: "provider_profiles",
        ),
      );

      if (response.isSuccessful) {
        return response.secureUrl;
      }
      return null;
    } catch (e) {
      print("Cloudinary Upload Error: $e");
      return null;
    }
  }
}
