class ProductItem {
  final String image;
  final String productName;
  final double productPrice;
  final int productWeight;
  final String category;
  final int kcal;
  int productCount;
  final String productDescription;
  ProductItem({
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
}
