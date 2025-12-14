import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/provider_service_model.dart';

class ProviderServiceRepository {
  final _db = FirebaseFirestore.instance;

  CollectionReference _ref(String providerId) {
    return _db
        .collection('provider_services')
        .doc(providerId)
        .collection('services');
  }

  // CREATE
  Future<void> addService(
      String providerId, ProviderServiceModel service) {
    return _ref(providerId).add(service.toMap());
  }

  // READ
  Stream<List<ProviderServiceModel>> getServices(String providerId) {
    return _ref(providerId).snapshots().map((snap) =>
        snap.docs.map((doc) =>
            ProviderServiceModel.fromMap(
                doc.id, doc.data() as Map<String, dynamic>)
        ).toList()
    );
  }

  // UPDATE
  Future<void> updateService(
      String providerId, ProviderServiceModel service) {
    return _ref(providerId)
        .doc(service.id)
        .update(service.toMap());
  }

  // DELETE
  Future<void> deleteService(
      String providerId, String serviceId) {
    return _ref(providerId).doc(serviceId).delete();
  }
}
