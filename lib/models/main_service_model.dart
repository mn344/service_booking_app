class MainServiceModel {
  final String id;
  final String title;
  final String icon;
  final String type;
  final bool isActive;

  MainServiceModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.type,
    required this.isActive,
  });

  factory MainServiceModel.fromMap(
      String id,
      Map<String, dynamic> data,
      ) {
    return MainServiceModel(
      id: id,
      title: data['title'] ?? '',
      icon: data['icon'] ?? '',
      type: data['type'] ?? '',
      isActive: data['isActive'] ?? true,
    );
  }
}
