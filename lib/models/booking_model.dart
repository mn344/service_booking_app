import 'package:cloud_firestore/cloud_firestore.dart';
import 'cleaning_service_model.dart';

class BookingModel {
  final String? id;
  final String userId;
  final String mainType;
  final List<CleaningServiceModel> services;
  final int totalPrice;
  final String name;
  final String phone;
  final String address;
  final String status;
  final Timestamp createdAt;

  BookingModel({
    this.id,
    required this.userId,
    required this.mainType,
    required this.services,
    required this.totalPrice,
    required this.name,
    required this.phone,
    required this.address,
    this.status = 'pending',
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  /// 🔁 Firestore SAVE
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'mainType': mainType,
      'services': services.map((e) => {
        'id': e.id,
        'category': e.category,
        'price': e.price,
      }).toList(),
      'totalPrice': totalPrice,
      'name': name,
      'phone': phone,
      'address': address,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
