import 'dart:ui';
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/favorite_page.dart';
import 'package:breezefood/presentation/screens/home/home.dart';
import 'package:breezefood/presentation/screens/orders.dart';
import 'package:breezefood/presentation/screens/stores_nav_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Custombottomnav extends StatefulWidget {
  const Custombottomnav({super.key});

  @override
  State<Custombottomnav> createState() => _CustombottomnavState();
}

class _CustombottomnavState extends State<Custombottomnav> {
  int selectedIndex = 0;

  final List<String> svgIcons = const [
    'assets/icons/home-linear.svg',
    'assets/icons/stores.svg',
    'assets/icons/favorite.svg',
    'assets/icons/ordernav.svg',
  ];

  final List<String> labels = const ["Home", "Stores", "Favorites", "Orders"];

  final List<Widget> pages = const [
    Home(),
    StoresNavTab(),
    FavoritePage(),
    Orders(),
  ];

  static const double _barHeight = 60;

  Widget _buildSvgIcon(String path, {required bool selected, double size = 22}) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        selected ? AppColor.white : AppColor.gry.withOpacity(0.8),
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = [
      svgIcons.length,
      labels.length,
      pages.length,
    ].reduce((a, b) => a < b ? a : b);

    return Scaffold(
      backgroundColor: Colors.transparent,

      body: IndexedStack(
        index: selectedIndex.clamp(0, itemCount - 1),
        children: pages.take(itemCount).toList(),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        // minimum: const EdgeInsets.only(bottom: 8,),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: _barHeight,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.15), width: 0.8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(itemCount, (index) {
                  final bool isSelected = selectedIndex == index;

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => selectedIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,
                      // 👇 عرض متغير عند التحديد
                      width: isSelected ? 113.w : 50.w,
                      height: 40.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSelected ? 12.w : 0,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(25), // 👈 radius الخلفية
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSvgIcon(
                            svgIcons[index],
                            selected: isSelected,
                            size: 22.sp,
                          ),
                          // 👇 النص يظهر فقط وقت التحديد
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, anim) => FadeTransition(
                              opacity: anim,
                              child: SizeTransition(
                                sizeFactor: anim,
                                axis: Axis.horizontal,
                                child: child,
                              ),
                            ),
                            child: isSelected
                                ? Padding(
                                    key: ValueKey(index),
                                    padding: EdgeInsets.only(left: 4.w),
                                    child: Text(
                                      labels[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Manrope",
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
