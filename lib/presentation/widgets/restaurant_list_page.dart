
import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantListPage extends StatelessWidget {
  final List<Map<String, dynamic>> restaurants = [
    {
      "name": "Chicken King_Alhamra",
      "image": "assets/images/pourple.jpg",
      "rating": 4.9,
      "orders": "500+ Order",
      "time": "30M"
    },
    {
      "name": "Pizza Hut Center",
      "image": "assets/images/004.jpg",
      "rating": 4.7,
      "orders": "300+ Order",
      "time": "25M"
    },
    {
      "name": "Burger House",
      "image": "assets/images/003.jpg",
      "rating": 4.5,
      "orders": "200+ Order",
      "time": "20M"
    },
    {
      "name": "Shawarma Spot",
      "image": "assets/images/001.jpg",
      "rating": 4.8,
      "orders": "400+ Order",
      "time": "35M"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return

       ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage(restaurant["image"]), // صورة مختلفة
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Stack(
                children: [
                  // طبقة شفافة فوق الصورة
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(25),
                      ),

                    ),
                  ),

                  // النصوص والأيقونات
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الصف الأول (التقييم + الطلبات + الوقت)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.yellow, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  "${restaurant["rating"]} | ${restaurant["orders"]}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.timer,
                                    color: Colors.white, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  restaurant["time"],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const Spacer(),

                        // اسم المطعم
                        Text(
                          restaurant["name"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },

    );
  }
}
