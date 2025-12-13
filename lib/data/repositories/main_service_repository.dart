import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/main_service_model.dart';
import '../../models/cleaning_service_model.dart';

class MainServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 MAIN SERVICES (Home / Admin)
  Future<List<MainServiceModel>> getMainServices() async {
    final snapshot = await _firestore.collection('main_services').get();

    return snapshot.docs
        .map((doc) => MainServiceModel.fromMap(doc.id, doc.data()))
        .toList();
  }


  Future<List<CleaningServiceModel>> getCleaningServicesByType(
      String mainType) async {
    final snapshot = await _firestore
        .collection('cleaning_services')
        .where('mainType', isEqualTo: mainType)
        .where('isActive', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((doc) =>
        CleaningServiceModel.fromJson(doc.id, doc.data()))
        .toList();
  }
}
