class ProviderServiceModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String mainType;
  final bool isActive;

  ProviderServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.mainType,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'mainType': mainType,
      'isActive': isActive,
    };
  }

  factory ProviderServiceModel.fromMap(
      String id, Map<String, dynamic> map) {
    return ProviderServiceModel(
      id: id,
      title: map['title'],
      description: map['description'],
      price: (map['price'] as num).toDouble(),
      mainType: map['mainType'],
      isActive: map['isActive'],
    );
  }
}
