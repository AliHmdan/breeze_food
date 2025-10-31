import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/data/model/restaurant.dart' as uiModel;
import 'package:freeza_food/data/model/restaurant_mapper.dart';
import 'package:freeza_food/presentation/screens/store_details/market_page.dart';
import 'package:freeza_food/presentation/widgets/auth/custom_search.dart';
import 'package:freeza_food/presentation/widgets/custom_appbar_home.dart';
import 'package:freeza_food/presentation/widgets/home/custom_fast_food.dart';
import 'package:freeza_food/presentation/widgets/location_chip.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/restaurants/restaurants_cubit.dart';
import '../../blocs/restaurants/restaurants_state.dart';
import '../../data/repositories/restaurant_repository.dart';
import '../../linkapi.dart';

class StoresNavTab extends StatefulWidget {
  const StoresNavTab({super.key});

  @override
  State<StoresNavTab> createState() => _StoresNavTabState();
}

class _StoresNavTabState extends State<StoresNavTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // keep supermarkets static if sponsor endpoints not ready
  late final List<uiModel.Restaurant> _supermarkets;
  final List<String> _titles = const ["Restaurant", "Super Market"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _titles.length, vsync: this)
      ..addListener(() {
        if (mounted) setState(() {});
      });

    _supermarkets = <uiModel.Restaurant>[
      uiModel.Restaurant(
        imageUrl: "assets/images/004.jpg",
        name: "Fresh Market",
        rating: 4.6,
        orders: "1K+ Orders",
        time: "30M",
      ),
      // ابقي القوائم الافتراضية كما كانت
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestaurantCubit>(
      create: (_) => RestaurantCubit(
        repo: RestaurantRepository(), // يستخدم ApiConstants.BASE_URL داخل الrepo
      )..loadRestaurants(),
      child: Scaffold(
        backgroundColor: AppColor.Dark,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                const CustomAppbarHome(title: "Stores"),
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
                                color: isSelected ? AppColor.primaryColor : AppColor.white,
                                fontsize: 14.sp,
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeInOut,
                                margin: EdgeInsets.only(top: 4.h),
                                height: 3,
                                width: isSelected ? 130.w : 0,
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColor.primaryColor : Colors.transparent,
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
                CustomSearch(
                  hint: 'Search',
                  readOnly: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoute.search);
                  },
                ),
                SizedBox(height: 8.h),
                // LocationChip(
                //   text: "Your location",
                //   iconPath: "assets/icons/telegram.svg",
                //   onTap: () {},
                // ),
                SizedBox(height: 16.h),
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
                          // تبويب المطاعم: نستخدم BlocBuilder لعرض النتيجة
                          BlocBuilder<RestaurantCubit, RestaurantState>(
                            builder: (context, state) {
                              if (state is RestaurantLoading) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              if (state is RestaurantError) {
                                return Center(child: Text("Error: ${state.message}"));
                              }
                              if (state is RestaurantLoaded) {
                                // تحويل ApiRestaurant -> ui.Restaurant
                                final items = state.restaurants
                                    .map((api) => api.toUiModel(AppLink.server))
                                    .toList();

                                return _StoresTabList(
                                  key: const PageStorageKey('tab_restaurants'),
                                  items: items,
                                );
                              }
                              return const Center(child: CircularProgressIndicator());
                            },
                          ),
                          // تبويب السوبرماركت
                          _StoresTabList(
                            key: const PageStorageKey('tab_supermarket'),
                            items: _supermarkets,
                            onItemTap: (ctx, r) {
                              Navigator.of(ctx).push(
                                MaterialPageRoute(
                                  builder: (_) => const MarketPage(),
                                ),
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
      ),
    );
  }
}

/// باقي الكود كما في ملفك الأصلي
class _StoresTabList extends StatefulWidget {
  final List<uiModel.Restaurant> items;
  final void Function(BuildContext context, uiModel.Restaurant r)? onItemTap;

  const _StoresTabList({
    super.key,
    required this.items,
    this.onItemTap,
  });

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
            onTap: () {
              if (widget.onItemTap != null) {
                widget.onItemTap!(context, r);
              } else {
                Navigator.of(context).pushNamed(AppRoute.StoreDetails);
              }
            },
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
    return child;
  }
}
