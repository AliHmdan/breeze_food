class PopularItemModel {
  final String restaurantName;
  final String image;
  final String price;
  final String nameAr;
  final bool isFavorite;

  PopularItemModel({
    required this.restaurantName,
    required this.image,
    required this.price,
    required this.nameAr,
    required this.isFavorite,
  });

  factory PopularItemModel.fromJson(Map<String, dynamic> json) {
    return PopularItemModel(
      restaurantName: json["restaurant"]?["name"] ?? "",
      image: json["primary_image"]?["image_url"] ?? "",
      price: json["base_price"]?.toString() ?? "0",
      nameAr: json["name_ar"] ?? "",
      isFavorite: json["is_favorite"] ?? false,
    );
  }
}
