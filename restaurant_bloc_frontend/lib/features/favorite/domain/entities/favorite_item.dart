class Favorite {
  final String id;
  final String userId;
  final List<String>
      productIds; 
  final DateTime createdAt;

  Favorite({
    required this.id,
    required this.userId,
    required this.productIds,
    required this.createdAt,
  });
}
