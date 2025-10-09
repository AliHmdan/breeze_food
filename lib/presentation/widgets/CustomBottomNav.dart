import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/favorite_page.dart';
import 'package:freeza_food/presentation/screens/home/home.dart';
import 'package:freeza_food/presentation/screens/orders.dart';
import 'package:freeza_food/presentation/widgets/home/Stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Custombottomnav extends StatefulWidget {
  const Custombottomnav({super.key});

  @override
  State<Custombottomnav> createState() => _CustombottomnavState();
}

class _CustombottomnavState extends State<Custombottomnav> {
  int selectedIndex = 0;

  final List<IconData> icons = [
    Icons.home_outlined,
    Icons.storefront_outlined,
    Icons.favorite_border,
    Icons.receipt_long_outlined,
  ];

  final List<String> labels = ["Home", "Shop", "Favorites", "Orders"];

  final List<Widget> pages = [
    const Home(),
     Stores(),
    const FavoritePage(),
    const Orders(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: AppColor.black,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            bool isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 16 : 0,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    if (!isSelected)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.Dark,
                        ),
                        child: Icon(
                          icons[index],
                          size: 22.sp,
                          color: AppColor.gry,
                        ),
                      )
                    else
                      Row(
                        children: [
                          Icon(icons[index], color: AppColor.white),
                          const SizedBox(width: 6),
                          Text(
                            labels[index],
                            style: const TextStyle(
                              color: AppColor.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
