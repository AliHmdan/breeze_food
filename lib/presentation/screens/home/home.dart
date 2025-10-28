import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/core/constans/routes.dart';
import 'package:freeza_food/data/model/restaurant.dart';
import 'package:freeza_food/presentation/screens/home/animated_background.dart';
import 'package:freeza_food/presentation/screens/home/appbar_home.dart';
import 'package:freeza_food/presentation/screens/home/discount_home.dart';
import 'package:freeza_food/presentation/screens/home/most_popular.dart';
import 'package:freeza_food/presentation/screens/home/open_now.dart';
import 'package:freeza_food/presentation/widgets/CustomBottomNav.dart';
import 'package:freeza_food/presentation/widgets/animated_background.dart';
import 'package:freeza_food/presentation/widgets/home/Stores.dart';
import 'package:freeza_food/presentation/widgets/button/custom_button_order.dart';
import 'package:freeza_food/presentation/widgets/auth/custom_search.dart';
import 'package:freeza_food/presentation/widgets/home/custom_title_section.dart';
import 'package:freeza_food/presentation/widgets/home/home_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freeza_food/blocs/home/home_cubit.dart';
import 'package:freeza_food/blocs/home/home_state.dart';
import 'package:freeza_food/data/model/home_model.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      alignment: 0.05,
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
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            List<AdModel>? ads;
            List<DiscountModel>? discounts;
            List<RestaurantModel>? nearbyRestaurants;
            List<MenuItemModel>? mostPopular;
            var showOrderButton = false;
            if (state is HomeLoaded) {
              ads = state.data.ads;
              discounts = state.data.discounts;
              nearbyRestaurants = state.data.nearbyRestaurants;
              mostPopular = state.data.mostPopular;
              showOrderButton = state.data.hasOrder;
            }

            return SingleChildScrollView(
              controller: _scrollController, // 👈 مهم
              child: (state is HomeLoading)
                  ? _buildShimmer()
                  : Column(
                      children: [
                        // AppBar + Search
                        AppbarHome(),

                        HomeFilters(onFilterTap: _onFilterTap),

                        Animated(),
                        const SizedBox(height: 5),
                        Container(key: _popularKey),
                        // Most Popular
                        MostPopular(mostPopular: mostPopular),

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
                        Stores(ads: ads),
                        SizedBox(height: 2.h),

                        // Discounts
                        Container(key: _discountsKey), // 👈 مرساة التمرير
                        const SizedBox(height: 10),
                        DiscountHome(discounts: discounts),

                        const SizedBox(height: 10),
                        Container(key: _openNowKey),

                        // const SizedBox(height: 10),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            OpenNow(nearbyRestaurants: nearbyRestaurants),
                            if (showOrderButton)
                              Positioned(
                                bottom: 85,
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    // Simple shimmer placeholder that mimics the main sections
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade500,
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Appbar placeholder
          Container(
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.black26,
          ),
          const SizedBox(height: 12),
          // Filters placeholder
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.black26,
          ),
          const SizedBox(height: 12),
          // Animated/banner placeholder
          Container(
            height: 140,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.black26,
          ),
          const SizedBox(height: 12),
          // Most popular placeholder
          Container(
            height: 178,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.black26,
          ),
          const SizedBox(height: 12),
          // Stores placeholder
          Container(
            height: 160,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.black26,
          ),
          const SizedBox(height: 12),
          // Discounts placeholder
          Container(
            height: 178,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.black26,
          ),
          const SizedBox(height: 12),
          // Open now placeholder
          Container(
            height: 320,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.black26,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
