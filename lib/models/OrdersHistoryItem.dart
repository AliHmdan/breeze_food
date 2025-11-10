class OrdersHistoryItem {
  final int id;
  final String status;
  final double totalPrice;
  final double deliveryFee;
  final String paymentMethod;
  final String paymentStatus;
  final String notes;
  final String createdAt;
  final int itemsCount;
  final String restaurantName;
  final String restaurantLogo;

  OrdersHistoryItem({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.deliveryFee,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.notes,
    required this.createdAt,
    required this.itemsCount,
    required this.restaurantName,
    required this.restaurantLogo,
  });

  factory OrdersHistoryItem.fromJson(Map<String, dynamic> json) {
    final order = json['order'];
    final restaurant = json['restaurant'];
    return OrdersHistoryItem(
      id: order['id'],
      status: order['status'],
      totalPrice: (order['total_price'] as num).toDouble(),
      deliveryFee: (order['delivery_fee'] as num).toDouble(),
      paymentMethod: order['payment_method'],
      paymentStatus: order['payment_status'],
      notes: order['notes'] ?? '',
      createdAt: order['created_at'],
      itemsCount: order['items_count'],
      restaurantName: restaurant['name'],
      restaurantLogo: restaurant['logo'],
    );
  }
}
