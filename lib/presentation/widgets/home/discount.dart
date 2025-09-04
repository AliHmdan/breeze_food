import 'package:breezefood/core/constans/color.dart';
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
    required this.onFavoriteToggle,  this.icons, required this.discount,
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
      duration: Duration(milliseconds: 300),
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
      width: 100.w,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.asset(
                  widget.imagePath,
                  height: 120.h,
                  width: 160.w,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: _toggleFavorite,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        // color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? AppColor.red : AppColor.gry,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6, // كان 4، زدته قليلاً للاتساق
                    vertical: 6,   // كان 8، قللته لتقليل الارتفاع
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20), // قللناه من 40
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // حتى يأخذ حجم المحتوى فقط
                    children: [
                      Text(
                        widget.discount,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),

                      Container(


                        child: SvgPicture.asset(
                          'assets/icons/nspah.svg',
                          width: 24.w,
                          height: 24.h,
                          color: AppColor.white,
                        ),
                      ),

                    ],
                  ),
                ),
              )

            ],
          ),

          Container(
            decoration: BoxDecoration(
              color: AppColor.Dark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),

            child: Column(
              children: [
                Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                      fontFamily: "Manrope",
                      color: AppColor.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.subtitle,
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 10.sp,
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.w400,
                    ),
                    // maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4),
                Center(
                  child: Text(
                    widget.price,
                    style: TextStyle(
                      color: AppColor.green,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      fontFamily: "Manrope",
                    ),
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
