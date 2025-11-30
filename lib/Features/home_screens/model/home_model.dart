class HomeModel {
  final String id;
  final String name;
  final String imagePath;

  HomeModel({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  // Convert JSON to HomeModel
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      imagePath: json['imagePath'] as String? ?? 'assets/default_image.png',
    );
  }

  // Convert HomeModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
    };
  }
}
