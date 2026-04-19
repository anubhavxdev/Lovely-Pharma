class MedicineModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final String image;
  final int stock;
  final String category;
  final bool requiresPrescription;

  MedicineModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.stock,
    this.category = 'General',
    this.requiresPrescription = false,
  });

  factory MedicineModel.fromMap(Map<String, dynamic> map, String documentId) {
    return MedicineModel(
      id: documentId,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      stock: map['stock'] ?? 0,
      category: map['category'] ?? 'General',
      requiresPrescription: map['requiresPrescription'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'stock': stock,
      'category': category,
      'requiresPrescription': requiresPrescription,
    };
  }
}
