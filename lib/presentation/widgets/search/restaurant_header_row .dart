import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantHeaderRow extends StatelessWidget {
  final String logoPath;
  final String name;
  final String etaText;
  final double rating;
  final String ordersText;

  const RestaurantHeaderRow({
    super.key,
    required this.logoPath,
    required this.name,
    required this.etaText,
    required this.rating,
    required this.ordersText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            logoPath,
            width: 35.w,
            height: 35.w,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 8.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.white70, size: 14.sp),
                  SizedBox(width: 4.w),
                  Text(
                    etaText,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Container(
          height: 25.h,
          width: 1,
          color: Colors.white24,
          margin: EdgeInsets.symmetric(horizontal: 8.w),
        ),

        Row(
          children: [
            Icon(Icons.star, color: AppColor.yellow, size: 16.sp),
            SizedBox(width: 4.w),
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              ordersText,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
