import 'dart:math';

import 'package:freeza_food/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Discount extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onFavoriteToggle;
  final IconData? icons;
  final String discount;

  const Discount({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onFavoriteToggle,
    this.icons,
    required this.discount,
  }) : super(key: key);

  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.onFavoriteToggle();
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w, // متجاوب مع العرض
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: Image.asset(
                  widget.imagePath,
                  height: 100.h,
                  width: double.infinity, 
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4.h,
                right: 2.w,
                child: GestureDetector(
                  onTap: _toggleFavorite,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? AppColor.red : AppColor.gry,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    // vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.discount,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      SvgPicture.asset(
                        'assets/icons/nspah.svg',
                        width: 24.w,
                        height: 24.h,
                        color: AppColor.white,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),

          // الجزء السفلي
          Container(
            decoration: BoxDecoration(
              color: AppColor.Dark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        // fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        fontFamily: "Manrope",
                        color: AppColor.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 10.sp,
                        fontFamily: "Manrope",
                        // fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // SizedBox(height: 2.h),
                  Center(
                    child: Text(
                      widget.price,
                      style: TextStyle(
                        color: AppColor.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        fontFamily: "Manrope",
                      ),
                    ),
                  ),
                //  SizedBox(height: 2.h,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
