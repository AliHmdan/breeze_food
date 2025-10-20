import 'package:breezefood/data/model/search/restaurant_lite.dart';
import 'package:breezefood/presentation/widgets/search/search_meal_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/home/most_popular.dart'; // PopularItemCard

/// قائمة مطاعم رأسية، وتحت كل مطعم شريط أفقي لعناصره
class RestaurantHorizontalList extends StatelessWidget {
  final List<RestaurantGroup> restaurants;

  const RestaurantHorizontalList({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, i) {
        final restaurant = restaurants[i];

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
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),

            // الشريط الأفقي بالعناصر (تصميمك)
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
                            imagePath: item.image,
                            title: item.name,
                            subtitle: item.subtitle,
                            price: item.price,
                            onFavoriteToggle: () {
                              // TODO: toggle favorite لو لزم
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
