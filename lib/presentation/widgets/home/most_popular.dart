import 'package:breezefood/core/constans/color.dart';
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
      onTap: widget.onTap, // ✅ صار على الكرت كامل
      child: SizedBox(
        width: 140.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    widget.imagePath,
                    height: 120.h,
                    width: 165.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: _toggleFavorite,
                    borderRadius: BorderRadius.circular(20),
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? AppColor.red : AppColor.gry,
                          size: 22.sp,
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
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
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
                      ),
                    ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.oldPrice != null) // ✅ يظهر فقط لو فيه قيمة
                        Text(
                          widget.oldPrice!,
                          style: TextStyle(
                            color: AppColor.red,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            fontFamily: "Manrope",
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColor.red,
                            decorationThickness: 2,
                          ),
                        ),
                      if (widget.oldPrice != null) const SizedBox(width: 12),
                      Text(
                        widget.price,
                        style: TextStyle(
                          color: AppColor.green,
                          fontWeight: FontWeight.w400,
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
          ],
        ),
      ),
    );
  }
}
