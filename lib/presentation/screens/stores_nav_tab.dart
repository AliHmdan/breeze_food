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
  late final TabController _tabController;

  // Keep data outside build() to avoid re-creating on every rebuild
  late final List<Restaurant> _restaurants;
  late final List<Restaurant> _supermarkets;
  final List<String> _titles = const ["Restaurant", "Super Market"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _titles.length, vsync: this)
      ..addListener(() {
        if (mounted) setState(() {}); // refresh custom tab indicator
      });

    _restaurants = <Restaurant>[
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
        Restaurant(
        imageUrl: "assets/images/003.jpg",
        name: "Sushi Roll",
        rating: 4.8,
        orders: "220+ Order",
        time: "25M",
      ),
        Restaurant(
        imageUrl: "assets/images/003.jpg",
        name: "Sushi Roll",
        rating: 4.8,
        orders: "220+ Order",
        time: "25M",
      ),
        Restaurant(
        imageUrl: "assets/images/003.jpg",
        name: "Sushi Roll",
        rating: 4.8,
        orders: "220+ Order",
        time: "25M",
      ),
        Restaurant(
        imageUrl: "assets/images/003.jpg",
        name: "Sushi Roll",
        rating: 4.8,
        orders: "220+ Order",
        time: "25M",
      ),
    ];

    _supermarkets = <Restaurant>[
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              const CustomAppbarHome(title: "Stores"),

              // Custom tabs header using TabController index
              Row(
                children: List.generate(_titles.length, (index) {
                  final bool isSelected = _tabController.index == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _tabController.animateTo(
                        index,
                        duration: const Duration(milliseconds: 320),
                        curve: Curves.easeInOutCubic,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomSubTitle(
                              subtitle: _titles[index],
                              color:
                                  isSelected ? AppColor.primaryColor : AppColor.white,
                              fontsize: 14.sp,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
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

              // Content
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
                      controller: _tabController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _StoresTabList(
                          key: const PageStorageKey('tab_restaurants'),
                          items: _restaurants,
                        ),
                        _StoresTabList(
                          key: const PageStorageKey('tab_supermarket'),
                          items: _supermarkets,
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

/// A performant list for a stores tab, keeps scroll position alive per tab.
class _StoresTabList extends StatefulWidget {
  final List<Restaurant> items;
  const _StoresTabList({super.key, required this.items});

  @override
  State<_StoresTabList> createState() => _StoresTabListState();
}

class _StoresTabListState extends State<_StoresTabList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScrollConfiguration(
      behavior: const _NoGlowBehavior(),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        physics: const ClampingScrollPhysics(),
        itemCount: widget.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final r = widget.items[index];
          return GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRoute.StoreDetails),
            child: RestaurantCard(
              imageUrl: r.imageUrl,
              name: r.name,
              rating: r.rating,
              orders: r.orders,
              time: r.time,
              isClosed: r.isClosed,
              closedText: r.closedText,
            ),
          );
        },
      ),
    );
  }
}

class _NoGlowBehavior extends ScrollBehavior {
  const _NoGlowBehavior();
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // remove default glow effect
  }
}
