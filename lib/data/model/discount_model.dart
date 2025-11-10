class DiscountModel {
  final String restaurantName;
  final String nameAr;
  final String price;
  final String image;
  final String discountType;
  final dynamic discountValue;
  final bool isFavorite;

  DiscountModel({
    required this.restaurantName,
    required this.nameAr,
    required this.price,
    required this.image,
    required this.discountType,
    required this.discountValue,
    required this.isFavorite,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
      restaurantName: json["restaurant_name"] ?? "",
      nameAr: json["name_ar"] ?? "",
      price: (json["price"] ?? 0).toString(),
      image: json["image"] ?? "",
      discountType: json["discount_type"] ?? "",
      discountValue: json["discount_value"] ?? 0,
      isFavorite: json["is_favorite"] ?? false,
    );
  }
}
