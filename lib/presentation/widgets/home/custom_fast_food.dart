import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double rating;
  final String orders;
  final String time;
  final bool isClosed;
  final String? closedText;

  const RestaurantCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.orders,
    required this.time,
    this.isClosed = false,
    this.closedText,
  });

  Widget _buildImage(String path) {
    if (path.startsWith('http') || path.startsWith('/')) {
      final src = path.startsWith('http') ? path : '${AppLink.server}$path';
      return Image.network(
        src,
        height: 110.h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Container(height: 110.h, color: Colors.grey.shade300),
      );
    }
    return Image.asset(
      path,
      height: 110.h,
      width: double.infinity,
      cacheWidth: 600,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.r), // حواف بيضاوية كبيرة
      child: Stack(
        children: [
          // الخلفية (ملونة أو أبيض وأسود إذا مغلق)
          ColorFiltered(
            colorFilter: isClosed
                ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
                : const ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.multiply,
                  ),
            child: _buildImage(imageUrl),
          ),

          // التدرج العلوي والأسفل لتوضيح النص
          Container(
            height: 110.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.4),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // المحتوى
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // الصف العلوي (تقييم يسار + وقت يمين)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // تقييم
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: rating,
                              itemBuilder: (context, index) =>
                                  const Icon(Icons.star, color: Colors.yellow),
                              itemCount: 1,
                              itemSize: 14,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating.toString(),
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "|",
                              style: TextStyle(color: Colors.white54),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              orders,
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),

                        // الوقت
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              time,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // اسم المطعم + نص إضافي إذا مغلق
                  Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (isClosed && closedText != null)
                        Text(
                          closedText!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
