import 'package:breezefood/core/constans/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constans/color.dart';
import '../widgets/custom_appbar_home.dart';
import '../widgets/auth/custom_search.dart';
import '../widgets/title/custom_sub_title.dart';
import '../widgets/location_chip.dart';
import '../widgets/CustomBottomNav.dart';
import '../widgets/title/custom_title.dart';

class Stores extends StatelessWidget {
  const Stores({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          const CustomAppbarHome(title: "Stores"),
          SizedBox(height: 40.h),
          const CustomSearch(
            hint: "Search food ,stores,restaurants",
            boxicon: 'assets/icons/boxsearch.svg',
          ),
          LocationChip(
            text: "LocationChip",
            iconPath: "assets/icons/telegram.svg",
            onTap: () {},
          ),
          SizedBox(height: 20.h),

          // 🔽 هنا نستخدم ListView.builder
        Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50.r),
    color: AppColor.LightActive,
  ),
  child: ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: restaurants.length,
    shrinkWrap: true, 
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final restaurant = restaurants[index];
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoute.StoreDetails);
        },
        child: Container(
          height: 120.h,
          margin: EdgeInsets.only(
            top: index == 0 ? 0 : 8.h, // ✅ أول عنصر بدون فراغ
            left: 8.w,
            right: 8.w,
            bottom: 8.h,
          ), // ✅ بدل الـ padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.r),
            image: DecorationImage(
              image: AssetImage(restaurant["image"]),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.r),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
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
                              CustomSubTitle(
                                subtitle:
                                    "${restaurant["rating"]} | ${restaurant["orders"]}",
                                color: AppColor.white,
                                fontsize: 10.sp,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timer,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              CustomSubTitle(
                                subtitle: restaurant["time"],
                                color: AppColor.white,
                                fontsize: 10.sp,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: CustomTitle(
                          title: restaurant["name"],
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
)

        ],
      ),
      // bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }
}
