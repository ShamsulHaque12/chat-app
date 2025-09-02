class HomeModel {
  final String id;
  final String name;
  final String imagePath;
  final String membar;
  final String button;

  HomeModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.membar,
    required this.button,
  });

  // Convert JSON to HomeModel
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      imagePath: json['imagePath'] as String? ?? 'assets/default_image.png',
      membar: json['membar'] as String? ?? '',
      button: json['button'] as String? ?? 'Button',
    );
  }

  // Convert HomeModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'membar': membar,
      'button': button,
    };
  }
}
