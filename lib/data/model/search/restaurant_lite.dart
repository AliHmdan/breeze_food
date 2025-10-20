import 'package:breezefood/data/model/search/menu_item_lite.dart';

class RestaurantLite {
  final String name;
  final String logoPath;   // شعار المطعم
  final String etaText;    // مدة التوصيل
  final double rating;     // التقييم
  final String ordersText; // عدد الطلبات
  final List<MenuItemLite> items;

  RestaurantLite({
    required this.name,
    required this.logoPath,
    required this.etaText,
    required this.rating,
    required this.ordersText,
    required this.items,
  });
}
