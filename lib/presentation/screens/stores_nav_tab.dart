import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/data/model/restaurant.dart';
import 'package:breezefood/presentation/widgets/auth/custom_search.dart';
import 'package:breezefood/presentation/widgets/custom_appbar_home.dart';
import 'package:breezefood/presentation/widgets/home/custom_fast_food.dart';
import 'package:breezefood/presentation/widgets/location_chip.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoresNavTab extends StatefulWidget {
  const StoresNavTab({super.key});

  @override
  State<StoresNavTab> createState() => _StoresNavTabState();
}

class _StoresNavTabState extends State<StoresNavTab>
    with SingleTickerProviderStateMixin {
  // 👈 هذا هو المطلوب
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {}); // لتحديث مؤشر التبويب المخصص
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = <Restaurant>[
      Restaurant(
        imageUrl: "assets/images/004.jpg",
        name: "Chicken King_Alhamra",
        rating: 4.9,
        orders: "500+ Order",
        time: "20M",
      ),
      Restaurant(
        imageUrl: "assets/images/002.jpg",
        name: "Burger Master",
        rating: 4.7,
        orders: "300+ Order",
        time: "18M",
        isClosed: true,
        closedText: "Open tomorrow at 09:00 AM",
      ),
      Restaurant(
        imageUrl: "assets/images/003.jpg",
        name: "Sushi Roll",
        rating: 4.8,
        orders: "220+ Order",
        time: "25M",
      ),
    ];

    final supermarkets = <Restaurant>[
      Restaurant(
        imageUrl: "assets/images/004.jpg",
        name: "Fresh Market",
        rating: 4.6,
        orders: "1K+ Orders",
        time: "30M",
      ),
      Restaurant(
        imageUrl: "assets/images/003.jpg",
        name: "Daily Mart",
        rating: 4.5,
        orders: "800+ Orders",
        time: "28M",
      ),
    ];

    final titles = ["Restaurant", "Super Market"];

    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              const CustomAppbarHome(title: "Stores"),

              // تبويبك المخصص المعتمد على _tabController.index
              Row(
                children: List.generate(2, (index) {
                  final isSelected = _tabController.index == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _tabController.animateTo(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutCubic,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomSubTitle(
                              subtitle: titles[index],
                              color: isSelected
                                  ? AppColor.primaryColor
                                  : AppColor.white,
                              fontsize: 14.sp,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              margin: EdgeInsets.only(top: 4.h),
                              height: 3,
                              width: isSelected ? 130.w : 0,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 24.h),

              const CustomSearch(
                hint: "Search food, stores, restaurants",
                boxicon: 'assets/icons/boxsearch.svg',
              ),
              SizedBox(height: 8.h),

              LocationChip(
                text: "Your location",
                iconPath: "assets/icons/telegram.svg",
                onTap: () {},
              ),
              SizedBox(height: 16.h),

              // المحتوى مع نفس الستايل
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.LightActive,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                        width: 1,
                      ),
                    ),
                    child: TabBarView(
                      controller: _tabController, // 👈 مهم
                      children: [
                        ListView.builder(
                          key: const PageStorageKey('tab_restaurants'),
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 5,
                          ),
                          physics: const ClampingScrollPhysics(),
                          itemCount: restaurants.length,
                          itemBuilder: (context, index) {
                            final r = restaurants[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(
                                    context,
                                  ).pushNamed(AppRoute.StoreDetails),
                                  child: RestaurantCard(
                                    imageUrl: r.imageUrl,
                                    name: r.name,
                                    rating: r.rating,
                                    orders: r.orders,
                                    time: r.time,
                                    isClosed: r.isClosed,
                                    closedText: r.closedText,
                                  ),
                                ),
                                if (index != restaurants.length - 1)
                                  const SizedBox(
                                    height: 12,
                                  ), // فاصل بين العناصر فقط
                              ],
                            );
                          },
                        ),
                        ListView.builder(
                          key: const PageStorageKey('tab_supermarket'),
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 5,
                          ),
                          physics: const ClampingScrollPhysics(),
                          itemCount: supermarkets.length,
                          itemBuilder: (context, index) {
                            final s = supermarkets[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(
                                    context,
                                  ).pushNamed(AppRoute.StoreDetails),
                                  child: RestaurantCard(
                                    imageUrl: s.imageUrl,
                                    name: s.name,
                                    rating: s.rating,
                                    orders: s.orders,
                                    time: s.time,
                                    isClosed: s.isClosed,
                                    closedText: s.closedText,
                                  ),
                                ),
                                // 🔹 نضيف مسافة بين العناصر فقط إذا لم يكن العنصر الأخير
                                if (index != supermarkets.length - 1)
                                  const SizedBox(height: 12),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
