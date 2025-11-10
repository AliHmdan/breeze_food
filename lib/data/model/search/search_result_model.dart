class SearchResultItem {
  final Restaurant restaurant;
  final List<Item> items;

  SearchResultItem({
    required this.restaurant,
    required this.items,
  });

  factory SearchResultItem.fromJson(Map<String, dynamic> json) {
    return SearchResultItem(
      restaurant: Restaurant.fromJson(json['restaurant']),
      items: (json['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList(),
    );
  }
}

class Restaurant {
  final int id;
  final String name;
  final String logo;
  final Rating rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.logo,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      rating: Rating.fromJson(json['rating']),
    );
  }
}

class Rating {
  final double? avg;
  final int count;

  Rating({
    this.avg,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      avg: json['avg']?.toDouble(),
      count: json['count'],
    );
  }
}

// class Item {
//   final int id;
//   final Names names;
//
//   Item({
//     required this.id,
//     required this.names,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       id: json['id'],
//       names: Names.fromJson(json['names']),
//     );
//   }
// }
class Item {
  final int id;
  final Names names;
  final String basePrice;
  final int ordersCount;
  final String imageUrl;

  Item({
    required this.id,
    required this.names,
    required this.basePrice,
    required this.ordersCount,
    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      names: Names.fromJson(json['names']),
      basePrice: json['base_price'],
      ordersCount: json['orders_count'] ?? 0,
      imageUrl: json['image_url'] ?? '',
    );
  }
}

class Names {
  final String ar;
  final String en;

  Names({
    required this.ar,
    required this.en,
  });

  factory Names.fromJson(Map<String, dynamic> json) {
    return Names(
      ar: json['ar'],
      en: json['en'],
    );
  }
}

class SearchResultModel {
  final bool success;
  final List<SearchResultItem> data;

  SearchResultModel({
    required this.success,
    required this.data,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      success: json['success'],
      data: (json['data'] as List)
          .map((item) => SearchResultItem.fromJson(item))
          .toList(),
    );
  }
}