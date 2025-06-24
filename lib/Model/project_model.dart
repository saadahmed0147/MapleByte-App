class Project {
  final String id;
  final String title;
  final String description;
  final String image;
  final String price;
  final String status;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.status,
  });

  factory Project.fromMap(String id, Map<String, dynamic> map) {
    return Project(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      price: map['price'] ?? '',
      status: map['status'] ?? 'todo',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'status': status,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
