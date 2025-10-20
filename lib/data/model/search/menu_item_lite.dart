/// Model مبسّط لبطاقة الوجبة داخل الشريط الأفقي
class MenuItemLite {
  final String name;
  final String subtitle;
  final String image; // asset أو network
  final String price;

  const MenuItemLite({
    required this.name,
    required this.subtitle,
    required this.image,
    required this.price,
  });
}
