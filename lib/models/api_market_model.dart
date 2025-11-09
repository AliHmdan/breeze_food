class ApiMarket {
  final int id;
  final String name;
  final String? logo;
  final double ratingAvg;
  final int ratingCount;
  final double distanceKm;
  final int deliveryTime;

  ApiMarket({
    required this.id,
    required this.name,
    required this.logo,
    required this.ratingAvg,
    required this.ratingCount,
    required this.distanceKm,
    required this.deliveryTime,
  });

  factory ApiMarket.fromJson(Map<String, dynamic> json) {
    return ApiMarket(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      ratingAvg: (json['rating_avg'] ?? 0).toDouble(),
      ratingCount: json['rating_count'] ?? 0,
      distanceKm: (json['distance_km'] ?? 0).toDouble(),
      deliveryTime: json['delivery_time'] ?? 0,
    );
  }
}
