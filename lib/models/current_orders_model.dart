class CurrentOrderItem {
  final int id;
  final String status;
  final double totalPrice;
  final String createdAt;
  final String restaurantName;
  final String restaurantLogo;
  final String itemName;
  final int itemQuantity;
  final String itemImage;
  final int deliveryTime;

  CurrentOrderItem({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.restaurantName,
    required this.restaurantLogo,
    required this.itemName,
    required this.itemQuantity,
    required this.itemImage,
    required this.deliveryTime,
  });

  factory CurrentOrderItem.fromJson(Map<String, dynamic> json) {
    final order = json['order'];
    final restaurant = json['restaurant'];
    final items = (json['items'] as List).isNotEmpty ? json['items'][0] : null;

    return CurrentOrderItem(
      id: order['id'],
      status: order['status'],
      totalPrice: (order['total_price'] as num).toDouble(),
      createdAt: order['created_at'],
      restaurantName: restaurant['name'],
      restaurantLogo: restaurant['logo'],
      itemName: items?['name_ar'] ?? '',
      itemQuantity: items?['quantity'] ?? 0,
      itemImage: items?['image'] ?? '',
      deliveryTime: items?['delivery_time'] ?? 0,
    );
  }
}
