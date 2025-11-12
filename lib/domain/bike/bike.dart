class Bike {
  final String id;
  final String model;
  String brand;
  double price;
  String? imageUrl;
  Bike({
    required this.id,
    required this.model,
    required this.brand,
    required this.price,
    this.imageUrl,
  }) {
    if (model.trim().isEmpty) {
      throw ArgumentError('modelName cannot be empty');
    }
    if (brand.trim().isEmpty) {
      throw ArgumentError('brand cannot be empty');
    }
    if (price < 0) {
      throw ArgumentError('price cannot be negative');
    }
  }

  Bike copyWith({
    String? id,
    String? model,
    String? brand,
    double? price,
    String? imageUrl,
  }) {
    return Bike(
      id: id ?? this.id,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
