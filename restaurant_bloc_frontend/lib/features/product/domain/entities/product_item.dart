class Product {
  final String image;
  final String productName;
  final double productPrice;
  final int productWeight;
  final String category;
  final int kcal;
  int productCount;
  final String productDescription;
  Product({
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
    return 'ProductItem(name: $productName, price: $productPrice, count: $productCount)';
  }

  Product copyWith({int? productCount}) {
    return Product(
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
}
