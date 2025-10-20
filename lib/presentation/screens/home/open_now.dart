import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/data/model/restaurant.dart';
import 'package:freeza_food/presentation/widgets/home/custom_fast_food.dart';
import 'package:freeza_food/presentation/widgets/home/custom_title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OpenNow extends StatelessWidget {
  const OpenNow({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = [
      Restaurant(
        imageUrl: "assets/images/004.jpg",
        name: "Chicken King_Alhamra",
        rating: 4.9,
        orders: "500+ Order",
        time: "20M",
      ),
      Restaurant(
        imageUrl: "assets/images/002.jpg",
        name: "Chicken King_Alhamra",
        rating: 4.9,
        orders: "500+ Order",
        time: "20M",
        isClosed: true,
        closedText: "Open tomorrow at 09:00 AM",
      ),
      Restaurant(
        imageUrl: "assets/images/003.jpg",
        name: "Chicken King_Alhamra",
        rating: 4.9,
        orders: "500+ Order",
        time: "20M",
      ),
      Restaurant(
        imageUrl: "assets/images/004.jpg",
        name: "Chicken King_Alhamra",
        rating: 4.9,
        orders: "500+ Order",
        time: "20M",
      ),
      Restaurant(
        imageUrl: "assets/images/002.jpg",
        name: "Chicken King_Alhamra",
        rating: 4.9,
        orders: "500+ Order",
        time: "20M",
        isClosed: true,
        closedText: "Open tomorrow at 09:00 AM",
      ),
    ];

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
                // ✅ فعّل التمرير (اختَر واحدة):
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ), // iOS-like

                // physics: const ClampingScrollPhysics(), // Android-like
                primary: false, // مهم داخل شجرة فيها Scroll أخرى
                // shrinkWrap: false, // اتركها افتراضيًا (أفضل أداءً هنا)
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
