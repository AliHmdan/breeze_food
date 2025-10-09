import 'package:freeza_food/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularItemCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String? subtitle;
  final String price;
  final String? oldPrice;
  final void Function()? onTap;
  final VoidCallback onFavoriteToggle;

  const PopularItemCard({
    Key? key,
    required this.imagePath,
    required this.title,
    this.subtitle,
    required this.price,
    required this.onFavoriteToggle,
    this.oldPrice,
    this.onTap,
  }) : super(key: key);

  @override
  State<PopularItemCard> createState() => _PopularItemCardState();
}

class _PopularItemCardState extends State<PopularItemCard>
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
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 160.w, // ✅ عرض موحد لكل الكرت
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
                  child: InkWell(
                    onTap: _toggleFavorite,
                    borderRadius: BorderRadius.circular(20.r),
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
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.Dark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, ),
                child: Column(
                  children: [
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
                    if (widget.subtitle != null)
                      Center(
                        child: Text(
                          widget.subtitle!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 10.sp,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.oldPrice != null)
                          Text(
                            widget.oldPrice!,
                            style: TextStyle(
                              color: AppColor.red,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              fontFamily: "Manrope",
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColor.red,
                              decorationThickness: 2,
                            ),
                          ),
                        if (widget.oldPrice != null) SizedBox(width: 8.w),
                        Text(
                          widget.price,
                          style: TextStyle(
                            color: AppColor.yellow,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            fontFamily: "Manrope",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
