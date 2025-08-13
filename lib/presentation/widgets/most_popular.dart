import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularItemCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback onFavoriteToggle;

  const PopularItemCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.onFavoriteToggle,
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
      width: 140.w,

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
            ],
          ),

          Container(

            decoration: BoxDecoration(
                color: AppColor.Dark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
    bottomRight: Radius.circular(8)
              )
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
