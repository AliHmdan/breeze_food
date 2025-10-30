import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/core/constans/routes.dart';

import 'package:freeza_food/presentation/screens/home/animated_background.dart';
import 'package:freeza_food/presentation/screens/home/appbar_home.dart';
import 'package:freeza_food/presentation/screens/home/discount_home.dart';
import 'package:freeza_food/presentation/screens/home/most_popular.dart';
import 'package:freeza_food/presentation/screens/home/open_now.dart';
import 'package:freeza_food/presentation/screens/ads/page_ads.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/blocs/home/home_cubit.dart';
import 'package:freeza_food/data/repositories/home_repository.dart';
import 'package:freeza_food/blocs/home/home_state.dart';

import 'package:freeza_food/presentation/widgets/home/Stores.dart';
import 'package:freeza_food/presentation/widgets/button/custom_button_order.dart';

import 'package:freeza_food/presentation/widgets/home/custom_title_section.dart';
import 'package:freeza_food/presentation/widgets/home/home_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 👇 مفاتيح الأقسام + كنترولر للسكرول
  final _scrollController = ScrollController();
  final _openNowKey = GlobalKey();
  final _storesKey = GlobalKey();
  final _discountsKey = GlobalKey();
  final _popularKey = GlobalKey();

  Future<void> _scrollToKey(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.05, // خليه ينزل شوي تحت الهيدر
    );
  }

  void _onFilterTap(String section) {
    if (section == "open") _scrollToKey(_openNowKey);
    if (section == "popular") _scrollToKey(_popularKey);
    if (section == "stores") _scrollToKey(_storesKey);
    if (section == "discounts") _scrollToKey(_discountsKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: SafeArea(
        child: BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(HomeRepository())..loadHome(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final isLoaded = state is HomeLoaded;
              final isLoading = state is HomeLoading;
              // Use type-test expression but keep `data` dynamic so we can safely
              // access optional fields (like `stores`) without static getter errors.
              final dynamic data = state is HomeLoaded ? state.data : null;

              // Loading UX: show shimmer placeholders while HomeLoading
              if (isLoading) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      AppbarHome(),
                      HomeFilters(onFilterTap: _onFilterTap),
                      // Shimmer ad
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade500,
                          child: Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Shimmer Most Popular
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade500,
                          child: Container(
                            height: 178,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Shimmer Discounts
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade500,
                          child: Container(
                            height: 178,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Shimmer Open Now
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade500,
                          child: Container(
                            height: 320.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                controller: _scrollController, // 👈 مهم
                child: Column(
                  children: [
                    // AppBar + Search
                    AppbarHome(),

                    //  أزرار الفلاتر + تمرير على الأقسام
                    HomeFilters(onFilterTap: _onFilterTap),

                    // Ads (use first ad if available)
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ReferralAdPage(),
                          ),
                        );
                      },
                      child: Animated(
                        ad: isLoaded && data!.ads.isNotEmpty
                            ? data.ads.first
                            : null,
                      ),
                    ),

                    const SizedBox(height: 5),
                    Container(key: _popularKey),

                    // Most Popular
                    MostPopular(popular: isLoaded ? data!.mostPopular : null),

                    const SizedBox(height: 10),

                    // Stores
                    Container(key: _storesKey),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 10,
                        right: 10,
                      ),
                      child: CustomTitleSection(title: "Stores"),
                    ),
                    const SizedBox(height: 5),
                    // Pass stores data when available; Stores will fallback to static items if null
                    Stores(stores: data?.stores),
                    SizedBox(height: 2.h),

                    // Discounts
                    Container(key: _discountsKey), // 👈 مرساة التمرير
                    const SizedBox(height: 10),
                    DiscountHome(discounts: isLoaded ? data!.discounts : null),

                    const SizedBox(height: 10),
                    Container(key: _openNowKey),

                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        OpenNow(
                          nearbyRestaurants: isLoaded
                              ? data!.nearbyRestaurants
                              : null,
                        ),
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CustomButtonOrder(
                              title: "Your order",
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(AppRoute.pay_your_order);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
