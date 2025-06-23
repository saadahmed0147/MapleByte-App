// service_model.dart
class ServiceModel {
  final String name;
  final String imagePath;
  final String price;

  ServiceModel({
    required this.name,
    required this.imagePath,
    required this.price,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      name: map['name'] ?? '',
      imagePath: map['image'] ?? '',
      price: map['price'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'image': imagePath, 'price': price};
  }

  // ✅ This helper function converts List<Map> into List<ServiceModel>
  static List<ServiceModel> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => ServiceModel.fromMap(map)).toList();
  }
}
