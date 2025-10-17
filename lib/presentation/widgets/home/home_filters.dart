import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeFilters extends StatelessWidget {
  final Function(String section) onFilterTap;

  const HomeFilters({super.key, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric( vertical: 20.h),
      child: SizedBox(
        height: 30.h, // 👈 ضروري لتجنب الخطأ أو التجمّد
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          children: [
            _buildFilterButton("Open now", onTap: () => onFilterTap("open")),
            SizedBox(width: 10.w),
            _buildFilterButton("Popular", onTap: () => onFilterTap("popular")),
            SizedBox(width: 10.w),
            _buildFilterButton("Stores", onTap: () => onFilterTap("stores")),
            SizedBox(width: 10.w),
                        _buildFilterButton("Discounts", onTap: () => onFilterTap("discounts")),

          
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: CustomSubTitle(
          subtitle: label,
          color: AppColor.Dark,
          fontsize: 13.sp,
        ),
      ),
    );
  }
}
