import 'package:freeza_food/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DiscountDetails extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onFavoriteToggle;
  final IconData? icons;
  final String discount;

  const DiscountDetails({
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
  State<DiscountDetails> createState() => _DiscountDetailsState();
}

class _DiscountDetailsState extends State<DiscountDetails>
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
      width: 160.w, // 👈 يتغير مع حجم الشاشة
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
                child: Image.asset(
                  widget.imagePath,
                  height: 120.h, // 👈 مرن حسب ارتفاع الشاشة
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// ❤️ زر المفضلة
              Positioned(
                top: 8.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: _toggleFavorite,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? AppColor.red : AppColor.gry,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ),
              ),

              /// 🔖 علامة الخصم
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 4.h,
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
                          fontSize: 11.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      SvgPicture.asset(
                        'assets/icons/nspah.svg',
                        width: 14.w,
                        height: 14.h,
                        color: AppColor.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// 📦 التفاصيل
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.Dark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    fontFamily: "Manrope",
                    color: AppColor.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.white.withOpacity(0.8),
                    fontSize: 10.sp,
                    fontFamily: "Manrope",
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.price,
                  style: TextStyle(
                    color: AppColor.yellow,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    fontFamily: "Manrope",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
