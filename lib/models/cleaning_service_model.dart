class CleaningServiceModel {
  final String id;
  final String mainType;
  final String category;
  final String description;
  final int price;
  final String icon;

  const CleaningServiceModel({
    required this.id,
    required this.mainType,
    required this.category,
    required this.description,
    required this.price,
    required this.icon,
  });

  /// 🔥 Firestore / JSON → Model (with document id)
  factory CleaningServiceModel.fromJson(
      String id,
      Map<String, dynamic> json,
      ) {
    return CleaningServiceModel(
      id: id,
      mainType: json['mainType'] as String? ?? '',
      category: json['category'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      icon: json['icon'] as String? ?? 'cleaning_services',
    );
  }

  /// 🔥 Map → Model (FOR GET.arguments / BookingDetail)
  factory CleaningServiceModel.fromMap(Map<String, dynamic> map) {
    return CleaningServiceModel(
      id: map['id'] ?? '', // safe default
      mainType: map['mainType'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] as num?)?.toInt() ?? 0,
      icon: map['icon'] ?? 'cleaning_services',
    );
  }

  /// 🔁 Model → Firestore / Navigation
  Map<String, dynamic> toJson() {
    return {
      'id': id, // 🔥 important for booking flow
      'mainType': mainType,
      'category': category,
      'description': description,
      'price': price,
      'icon': icon,
    };
  }

  /// ✅ Equality override (important for selection logic)
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CleaningServiceModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
