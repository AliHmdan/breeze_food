import 'package:breezefood/presentation/widgets/home/most_popular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/data/model/search/menu_item_lite.dart';
// استخدم كاردك الخاصة بالعنصر (عدّل المسار إذا مختلف)

/// ViewModel مبسّط لعرض اسم المطعم + عناصره ضمن الشريط الأفقي
class RestaurantGroup {
  final String name;
  final List<MenuItemLite> items;

  const RestaurantGroup({
    required this.name,
    required this.items,
  });
}

/// قائمة مطاعم رأسية، وتحـت كل مطعم شريط أفقي لعناصره
class RestaurantList extends StatelessWidget {
  final List<RestaurantGroup> restaurants;

  const RestaurantList({
    super.key,
    required this.restaurants,
  });

  /// بيانات تجريبية (اختيارية) للاستعراض فقط
  static final List<RestaurantGroup> demoData = [
    RestaurantGroup(
      name: "Chicken House",
      items: [
        MenuItemLite(
          name: "Chicken shish",
          subtitle: "Burger King",
          image: "assets/images/004.jpg",
          price: "2.00\$",
        ),
        MenuItemLite(
          name: "Grilled Chicken",
          subtitle: "Burger King",
          image: "assets/images/004.jpg",
          price: "3.50\$",
        ),
      ],
    ),
    RestaurantGroup(
      name: "Pizza Hut",
      items: [
        MenuItemLite(
          name: "Pepperoni Pizza",
          subtitle: "Cheesy crust",
          image: "assets/images/004.jpg",
          price: "5.00\$",
        ),
        MenuItemLite(
          name: "Veggie Pizza",
          subtitle: "Extra cheese",
          image: "assets/images/004.jpg",
          price: "4.50\$",
        ),
        MenuItemLite(
          name: "Margherita",
          subtitle: "Classic",
          image: "assets/images/004.jpg",
          price: "3.75\$",
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final list = restaurants.isEmpty ? demoData : restaurants;

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final restaurant = list[i];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اسم المطعم
            Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 10),
              child: Text(
                restaurant.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            // الشريط الأفقي لعناصر المطعم
            RepaintBoundary(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 8,
                  right: 0.2,
                ),
                decoration: BoxDecoration(
                  color: AppColor.LightActive,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 178,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = constraints.maxWidth / 2.3;

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurant.items.length,
                      itemBuilder: (context, index) {
                        final item = restaurant.items[index];

                        return Container(
                          width: itemWidth,
                          margin: EdgeInsets.only(right: 10.w),
                          child: PopularItemCard(
                            imagePath: item.image, // لو Network: عدّل ويدجتك تدعمه
                            title: item.name,
                            subtitle: item.subtitle,
                            price: item.price,
                            onFavoriteToggle: () {
                              // TODO: toggle favorite
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
