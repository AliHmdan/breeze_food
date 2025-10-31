class RestaurantGeneralModel {
  final int id;
  final String name;
  final String description;
  final int avgRating;
  final int totalOrders;
  final int deliveryTime;
  final num deliveryCash;
  final String logo;
  final String cover;

  RestaurantGeneralModel({
    required this.id,
    required this.name,
    required this.description,
    required this.avgRating,
    required this.totalOrders,
    required this.deliveryTime,
    required this.deliveryCash,
    required this.logo,
    required this.cover,
  });

  factory RestaurantGeneralModel.fromJson(Map<String, dynamic> json) {
    return RestaurantGeneralModel(
      id: json["id"],
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      avgRating: json["avg_rating"] ?? 0,
      totalOrders: json["total_completed_orders"] ?? 0,
      deliveryTime: json["delivery_time"] ?? 0,
      deliveryCash: json["delivery_cash"] ?? 0,
      logo: json["logo"] ?? "",
      cover: json["cover"] ?? "",
    );
  }
}
class RestaurantItemModel {
  final int id;
  final num price;
  final String image;
  final bool isFavorite;
  final String name;

  RestaurantItemModel({
    required this.id,
    required this.price,
    required this.image,
    required this.isFavorite,
    required this.name,
  });

  factory RestaurantItemModel.fromJson(Map<String, dynamic> json) {
    return RestaurantItemModel(
      id: json["id"],
      price: json["price"] ?? 0,
      image: json["image"] ?? "",
      isFavorite: json["is_favorite"] ?? false,
      name: json["name_ar"] ?? "",
    );
  }
}
class RestaurantDetailsModel {
  final RestaurantGeneralModel general;
  final List<RestaurantItemModel> myOrders;
  final List<RestaurantItemModel> myFavorites;
  final List<RestaurantItemModel> menuItems;

  RestaurantDetailsModel({
    required this.general,
    required this.myOrders,
    required this.myFavorites,
    required this.menuItems,
  });

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailsModel(
      general: RestaurantGeneralModel.fromJson(json["general"]),
      myOrders: (json["my_orders_from_restaurant"] as List)
          .map((e) => RestaurantItemModel.fromJson(e))
          .toList(),
      myFavorites: (json["my_favorites_in_restaurant"] as List)
          .map((e) => RestaurantItemModel.fromJson(e))
          .toList(),
      menuItems: (json["restaurant_menu_items"]["data"] as List)
          .map((e) => RestaurantItemModel.fromJson(e))
          .toList(),
    );
  }
}
