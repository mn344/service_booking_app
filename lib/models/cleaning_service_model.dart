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

  /// 🔥 Firestore / JSON → Model
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

  /// 🔁 Model → Firestore (Admin / Booking save)
  Map<String, dynamic> toJson() {
    return {
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
