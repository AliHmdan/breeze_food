class ApiRestaurant {
  final int id;
  final String name;
  final String coverImage;
  final double ratingAvg;
  final int ratingCount;
  final int deliveryTime;

  ApiRestaurant({
    required this.id,
    required this.name,
    required this.coverImage,
    required this.ratingAvg,
    required this.ratingCount,
    required this.deliveryTime,
  });

  factory ApiRestaurant.fromJson(Map<String, dynamic> json) {
    return ApiRestaurant(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      coverImage: json["cover_image"] ?? "",
      ratingAvg: double.tryParse((json["rating_avg"] ?? 0).toString()) ?? 0.0,
      ratingCount: (json["rating_count"] ?? 0) is int
          ? json["rating_count"]
          : int.tryParse((json["rating_count"] ?? "0").toString()) ?? 0,
      deliveryTime: (json["delivery_time"] ?? 0) is int
          ? json["delivery_time"]
          : int.tryParse((json["delivery_time"] ?? "0").toString()) ?? 0,
    );
  }
}
