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
    this.productCount = 1,
    required this.productDescription,
    required this.kcal,
    required this.category,
    required this.image,
    required this.productName,
    required this.productPrice,
    required this.productWeight,
  });

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
      productCount: productCount ??
          this.productCount, // Si no se pasa, mantiene el valor actual
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
}
