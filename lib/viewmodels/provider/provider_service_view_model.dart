import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/provider_service_model.dart';
import '../../data/repositories/provider_service_repository.dart';

class ProviderServiceViewModel extends GetxController {
  final _repo = ProviderServiceRepository();
  final providerId = FirebaseAuth.instance.currentUser!.uid;

  // READ
  Stream<List<ProviderServiceModel>> services() {
    return _repo.getServices(providerId);
  }

  // CREATE
  Future<void> addService(ProviderServiceModel service) {
    return _repo.addService(providerId, service);
  }

  // UPDATE
  Future<void> updateService(ProviderServiceModel service) {
    return _repo.updateService(providerId, service);
  }

  // DELETE
  Future<void> deleteService(String serviceId) {
    return _repo.deleteService(providerId, serviceId);
  }
}
