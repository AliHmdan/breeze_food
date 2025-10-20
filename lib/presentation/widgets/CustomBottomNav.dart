import 'dart:ui';

import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/favorite_page.dart';
import 'package:freeza_food/presentation/screens/home/home.dart';
import 'package:freeza_food/presentation/screens/orders.dart';
import 'package:freeza_food/presentation/screens/stores_nav_tab.dart';
import 'package:freeza_food/presentation/widgets/home/Stores.dart';
import 'package:freeza_food/presentation/widgets/restaurant_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // <-- مهم لاستخدام SVG

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


  final List<Widget> pages =  [
    Home(),
    StoresNavTab(),
    FavoritePage(),
    Orders(),
  ];

  static const double _barHeight = 60;

  // ويدجت مساعدة لعرض SVG مع لون
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
    // حماية في حال تغيّر الأطوال (يفترض تكون كلها 4)
    final int itemCount = [
      svgIcons.length,
      labels.length,
      pages.length,
    ].reduce((a, b) => a < b ? a : b);

    return Scaffold(
      backgroundColor: Colors.transparent, // لا خلفية للـ Scaffold
      extendBody: true, // يسمح للمحتوى بالتمدد خلف البار
      body: Stack(
        children: [
          /// ====== المحتوى ======
          IndexedStack(
            index: selectedIndex.clamp(0, itemCount - 1),
            children: pages.take(itemCount).toList(),
          ),

          /// ====== البار العائم فوق كل العناصر ======
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SafeArea(
              top: false,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // تأثير زجاجي خفيف
                  child: Container(
                    height: _barHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4), // ضع 0.0 لشفافية كاملة
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(itemCount, (index) {
                        final bool isSelected = selectedIndex == index;
                        return GestureDetector(
                          onTap: () => setState(() => selectedIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: EdgeInsets.symmetric(
                              horizontal: isSelected ? 16 : 0,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.primaryColor.withOpacity(0.9)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                // الأيقونة بصيغة SVG
                                _buildSvgIcon(
                                  svgIcons[index],
                                  selected: isSelected,
                                  size: 22.sp,
                                ),
                                if (isSelected) ...[
                                  const SizedBox(width: 6),
                                  Text(
                                    labels[index],
                                    style: const TextStyle(
                                      color: AppColor.white,
                                      fontSize: 14,
                                      fontFamily: "Manrope",
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }
}
