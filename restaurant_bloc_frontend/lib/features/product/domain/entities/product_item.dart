class Product {
  final String id;
  final String image;
  final String productName;
  final double productPrice;
  final int productWeight;
  final String category;
  final int kcal;
  int productCount;
  final String productDescription;

  Product({
    required this.id,
    this.productCount = 0,
    required this.productDescription,
    required this.kcal,
    required this.category,
    required this.image,
    required this.productName,
    required this.productPrice,
    required this.productWeight,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      productName:
          json['name'] ?? 'Sin nombre', // Cambié 'productName' por 'name'
      productPrice:
          (json['price'] ?? 0).toDouble(), // Cambié 'productPrice' por 'price'
      productWeight: json['productWeight'] ?? 0,
      category: json['category'] ?? 'Sin categoría',
      kcal: json['kcal'] ?? 0,
      productCount: json['productCount'] ?? 0,
      productDescription: json['description'] ??
          'Sin descripción', // Cambié 'productDescription' por 'description'
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'productWeight': productWeight,
      'category': category,
      'kcal': kcal,
      'productCount': productCount,
      'productDescription': productDescription,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'Product(name: $productName, price: $productPrice, count: $productCount)';
  }

  Product copyWith({int? productCount}) {
    return Product(
      id: id,
      category: category,
      productName: productName,
      productDescription: productDescription,
      image: image,
      kcal: kcal,
      productWeight: productWeight,
      productPrice: productPrice,
      productCount: productCount ?? this.productCount,
    );
  }
}
