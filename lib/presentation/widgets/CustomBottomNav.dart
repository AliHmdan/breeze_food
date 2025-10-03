import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5), // ✅ شفاف
          borderRadius: BorderRadius.circular(40.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, "Home", 0),
            _buildNavItem(Icons.storefront_sharp, "Stores", 1),
            _buildNavItem(Icons.favorite_border, "Favorites", 2),
            _buildNavItem(Icons.receipt_sharp, "Orders", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(30.r),
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: isSelected ? 14.w : 10.w,
        ),
        decoration: BoxDecoration(
          shape: isSelected ? BoxShape.rectangle : BoxShape.circle,
          color: isSelected ? AppColor.primaryColor : Colors.transparent,
          borderRadius: isSelected ? BorderRadius.circular(50.r) : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22.sp),
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(left: 6.w),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
