class Restaurant {
  final int id;
  final String imageUrl;
  final String name;
  final double rating;
  final String orders;
  final String time;
  final bool isClosed;
  final String? closedText;

  Restaurant({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.orders,
    required this.time,
    this.isClosed = false,
    this.closedText,
  });
}