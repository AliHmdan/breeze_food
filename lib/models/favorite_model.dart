class FavoriteItem {
  final int id;
  final double price;
  final String image;
  final bool isFavorite;
  final String nameAr;
  final String nameEn;
  final int restaurantId;
  final String restaurantName;

  FavoriteItem({
    required this.id,
    required this.price,
    required this.image,
    required this.isFavorite,
    required this.nameAr,
    required this.nameEn,
    required this.restaurantId,
    required this.restaurantName,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      price: (json['price'] as num).toDouble(),
      image: json['image'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
      nameAr: json['name_ar'] ?? '',
      nameEn: json['name_en'] ?? '',
      restaurantId: json['restaurant_id'],
      restaurantName: json['restaurant_name'] ?? '',
    );
  }
}
