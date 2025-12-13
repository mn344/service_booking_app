import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/cleaning_service_model.dart';

class CleaningServiceRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<CleaningServiceModel>> fetchServicesByMainType(
      String mainType,
      ) async {
    final snapshot = await _db
        .collection('cleaning_services')
        .where('mainType', isEqualTo: mainType)
        .where('isActive', isEqualTo: true)
        .get();



    return snapshot.docs.map((doc) {
      return CleaningServiceModel.fromJson(
        doc.id,
        doc.data(),
      );
    }).toList();
  }
}
