import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';

import 'package:breezefood/presentation/screens/home/animated_background.dart';
import 'package:breezefood/presentation/screens/home/appbar_home.dart';
import 'package:breezefood/presentation/screens/home/discount_home.dart';
import 'package:breezefood/presentation/screens/home/most_popular.dart';
import 'package:breezefood/presentation/screens/home/open_now.dart';
import 'package:breezefood/presentation/screens/ads/page_ads.dart';

import 'package:breezefood/presentation/widgets/home/Stores.dart';
import 'package:breezefood/presentation/widgets/button/custom_button_order.dart';

import 'package:breezefood/presentation/widgets/home/custom_title_section.dart';
import 'package:breezefood/presentation/widgets/home/home_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        child: SingleChildScrollView(
          controller: _scrollController, // 👈 مهم

          child: Column(
            children: [
              // AppBar + Search
              AppbarHome(),

              //  أزرار الفلاتر + تمرير على الأقسام
              HomeFilters(onFilterTap: _onFilterTap),
              // Ads
              GestureDetector(onTap: () {
                Navigator.of(context).push(
  MaterialPageRoute(builder: (_) => const ReferralAdPage(
    // يمكن تمرير باراميترات للتخصيص
    // highlight: '25',
    // currency: 'AED',
    // referralCode: 'APP-9M2Q4',
  )),
);
              },child: Animated()),
              const SizedBox(height: 5),
              Container(key: _popularKey),
              // Most Popular
              MostPopular(),

              const SizedBox(height: 10),
              // Stores
              Container(key: _storesKey),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: CustomTitleSection(title: "Stores"),
              ),
              const SizedBox(height: 5),
              Stores(),
              SizedBox(height: 2.h),

              // Discounts
              Container(key: _discountsKey), // 👈 مرساة التمرير
              const SizedBox(height: 10),
              DiscountHome(),

              const SizedBox(height: 10),
              Container(key: _openNowKey),

              // const SizedBox(height: 10),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  OpenNow(),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CustomButtonOrder(
                        title: "Your order",
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoute.pay_your_order);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
