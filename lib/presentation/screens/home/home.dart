import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/data/model/restaurant.dart';

import 'package:breezefood/presentation/widgets/animated_background.dart';

import 'package:breezefood/presentation/widgets/home/Stores.dart';
import 'package:breezefood/presentation/widgets/button/custom_button_order.dart';
import 'package:breezefood/presentation/widgets/auth/custom_search.dart';

import 'package:breezefood/presentation/widgets/home/custom_title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_appbar_home.dart';

import '../../widgets/home/custom_fast_food.dart';
import '../../widgets/home/discount.dart';
import '../../widgets/home/most_popular.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      imageUrl: "assets/images/002.jpg",
      name: "Chicken King_Alhamra",
      rating: 4.9,
      orders: "500+ Order",
      time: "20M",
      isClosed: true,
      closedText: "Open tomorrow at 09:00 AM",
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 35 + 32,
            ), // ارتفاع البار + هامش

            child: Column(
              children: [
                CustomAppbarHome(
                  title: "Deliver to",
                  subtitle: "Poplar Ave,CA",
                  image: "assets/icons/location.svg",
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoute.profile);
                  },
                  icon: Icons.keyboard_arrow_down,
                ),
                const SizedBox(height: 15),
                CustomSearch(
                  hint: 'Search',
                  readOnly: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoute.search);
                  },
                ),

                SizedBox(height: 20),
                // BrunchCarousel(),
                AnimatedBackground(
                  height: 100.h,
                  child: Center(
                    child: Text(
                      'مرحباً 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  characters: const [
                    CartoonSvg(
                      alignment: Alignment.topRight,
                      width: 56,
                      assetPath: 'assets/characters/star.svg',
                      margin: EdgeInsets.only(top: 10, right: 10),
                      floatAmplitude: 4,
                      phaseShift: 1.2,
                    ),
                    CartoonSvg(
                      alignment: Alignment.bottomLeft,
                      width: 90,
                      assetPath: 'assets/characters/astronaut.svg',
                      margin: EdgeInsets.only(left: 12, bottom: 8),
                      rotationDeg: -6,
                      floatAmplitude: 6,
                      phaseShift: 0.0,
                    ),
                    CartoonSvg(
                      alignment: Alignment.bottomRight,
                      width: 110,
                      assetPath: 'assets/characters/planet.svg',
                      margin: EdgeInsets.only(right: 14, bottom: 6),
                      floatAmplitude: 8,
                      phaseShift: 2.2,
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                CustomTitleSection(
                  title: "Most popular",
                  all: "All",
                  icon: Icons.arrow_forward_ios_outlined,
                  ontap: () {
                    Navigator.of(context).pushNamed(AppRoute.PopularGridPage);
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(
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
                      double itemWidth = constraints.maxWidth / 2.3;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: itemWidth,
                            margin: EdgeInsets.only(right: 10.w),
                            child: PopularItemCard(
                              imagePath: 'assets/images/004.jpg',
                              title: 'Chicken shish without...',
                              subtitle: 'burger king',
                              price: '2.00\$',
                              onFavoriteToggle: () {
                                print('تم الضغط على المفضلة للعنصر رقم $index');
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomTitleSection(title: "Stores"),
                Stores(),
                SizedBox(height: 2.h),
                // RatingStores(),
                const SizedBox(height: 10),
                CustomTitleSection(
                  title: "Discounts",
                  all: "All",
                  icon: Icons.arrow_forward_ios_outlined,
                  ontap: () {
                    Navigator.of(context).pushNamed(AppRoute.discountDetails);
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 8,
                    right: 0.5,
                  ),

                  decoration: BoxDecoration(
                    color: AppColor.LightActive,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 178,

                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double itemWidth = constraints.maxWidth / 2.3;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: itemWidth,
                            margin: EdgeInsets.only(right: 10.w),

                            child: Discount(
                              imagePath: 'assets/images/004.jpg',
                              title: 'Chicken shish without...',
                              subtitle: 'burger king',
                              price: '2.00\$',
                              onFavoriteToggle: () {
                                print('تم الضغط على المفضلة للعنصر رقم $index');
                              },
                              // icons: Icons.close,
                              discount: "50",
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomTitleSection(title: "Fast food"),
                const SizedBox(height: 10),

                Stack(
                  clipBehavior: Clip.none, // ضروري حتى يظهر الزر خارج الحاوية
                  children: [
                    Container(
                      height: 320.h,
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.LightActive,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurants[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 1,
                              vertical: 6,
                            ),
                            child: RestaurantCard(
                              imageUrl: restaurant.imageUrl,
                              name: restaurant.name,
                              rating: restaurant.rating,
                              orders: restaurant.orders,
                              time: restaurant.time,
                              isClosed: restaurant.isClosed,
                              closedText: restaurant.closedText,
                            ),
                          );
                        },
                      ),
                    ),

                    // الزر في المنتصف ويطفو فوق الحافة
                    Positioned(
                      bottom: 85, // نصف الزر تحت الحافة
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CustomButtonOrder(
                          title: "Your order",
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
