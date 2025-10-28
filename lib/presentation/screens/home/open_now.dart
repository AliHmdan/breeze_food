import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/data/model/home_model.dart';
import 'package:freeza_food/data/model/restaurant.dart' as ui_rest;
import 'package:freeza_food/presentation/widgets/home/custom_fast_food.dart';
import 'package:freeza_food/presentation/widgets/home/custom_title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenNow extends StatelessWidget {
  const OpenNow({super.key, this.nearbyRestaurants});

  final List<RestaurantModel>? nearbyRestaurants;

  @override
  Widget build(BuildContext context) {
    // Map API RestaurantModel -> UI Restaurant (lib/data/model/restaurant.dart)
    final List<ui_rest.Restaurant> restaurants =
        (nearbyRestaurants != null && nearbyRestaurants!.isNotEmpty)
        ? nearbyRestaurants!.map((r) {
            // choose image: prefer logo, then coverImage, fallback to asset
            final image = (r.logo != null && r.logo!.isNotEmpty)
                ? r.logo!
                : (r.coverImage != null && r.coverImage!.isNotEmpty)
                ? r.coverImage!
                : 'assets/images/004.jpg';

            return ui_rest.Restaurant(
              imageUrl: image.startsWith('http') || image.startsWith('/')
                  ? image
                  : image,
              name: r.name,
              rating: 0.0, // API doesn't supply rating in this payload
              orders: '',
              time: '',
            );
          }).toList()
        : [];

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTitleSection(title: "Open Now"),
          const SizedBox(height: 10),
          RepaintBoundary(
            child: Container(
              height: 320.h, // ثابت
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              decoration: BoxDecoration(
                color: AppColor.LightActive,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                primary: false,
                cacheExtent: 600,
                itemCount: restaurants.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final r = restaurants[index];
                  return RestaurantCard(
                    imageUrl: r.imageUrl,
                    name: r.name,
                    rating: r.rating,
                    orders: r.orders,
                    time: r.time,
                    isClosed: r.isClosed,
                    closedText: r.closedText,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
