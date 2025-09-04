import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/screens/orders.dart';
import 'package:flutter/material.dart';

import '../screens/home/home.dart';
import '../screens/stores.dart';


class CustomBottomNav extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNav({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  void _navigate(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const Home();
        break;
      case 1:
        page = const Stores();
        break;
      // case 2:
      //   page = const FavoritesPage();
      //   break;
      case 3:
        page = const Orders();
        break;
      default:
        page = const Home();
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(0.2, 0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.home_outlined, "Home", 0),
            _buildNavItem(context, Icons.storefront_sharp, "Stores", 1),
            _buildNavItem(context, Icons.favorite_border, "Favorites", 2),
            _buildNavItem(context, Icons.receipt_sharp, "Orders", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => _navigate(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: isSelected ? 16 : 12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.cyanAccent
              : AppColor.Dark, // خلفية سوداء خفيفة
          borderRadius: BorderRadius.circular(50),
          border: isSelected
              ? null
              : Border.all(
            color: AppColor.Dark,
            width: 1.2,
          ), // حد فقط في حالة غير مفعّلة
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColor.white :  AppColor.white,size: 20,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.3, 0),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: isSelected
                  ? Padding(
                padding: const EdgeInsets.only(left: 6),
                key: ValueKey(label),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
