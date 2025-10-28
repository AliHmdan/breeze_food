import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/home/rating_stores.dart';
import 'package:freeza_food/data/model/home_model.dart';
import 'package:freeza_food/linkapi.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Stores extends StatelessWidget {
  Stores({super.key, this.ads});

  final List<AdModel>? ads;

  final List<Map<String, String>> items = [];
  final double height = 160.h;
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: height,
        width: 361.w,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: height,

            autoPlay: true,
            enlargeCenterPage: true,
          ),
          itemCount: (ads != null && ads!.isNotEmpty)
              ? ads!.length
              : items.length,
          itemBuilder: (context, index, realIndex) {
            final item = (ads != null && ads!.isNotEmpty) ? null : items[index];
            final subtitle = (ads != null && ads!.isNotEmpty)
                ? ads![index].description
                : (item?['subtitle'] ?? '');
            final titleText = (ads != null && ads!.isNotEmpty)
                ? (ads![index].title)
                : (item?['title'] ?? '');
            final label = (ads != null && ads!.isNotEmpty)
                ? ''
                : (item?['label'] ?? '');
            final link = (ads != null && ads!.isNotEmpty)
                ? (ads![index].url ?? '')
                : (item?['link'] ?? '');

            return Stack(
              alignment: Alignment.center,
              children: [
                // خلفية الصورة
                Container(
                  height: height,
                  width: 361.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: (ads != null && ads!.isNotEmpty)
                        ? Image.network(
                            // build ad image URL; ad.image may be relative
                            ads![index].image.startsWith('http')
                                ? ads![index].image
                                : '${AppLink.server}${ads![index].image}',
                            height: height,
                            width: 361.w,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, st) => Container(
                              height: height,
                              color: Colors.grey.shade300,
                            ),
                          )
                        : Image.asset(
                            item!["image"]!,
                            height: height,
                            width: 361.w,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                // طبقة شفافة
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          titleText,
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          label,
                          style: TextStyle(
                            color: AppColor.gry,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 2.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Order Now",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        // SizedBox(height: 4.h),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            link,
                            style: TextStyle(
                              color: AppColor.gry,
                              fontSize: 10.sp,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        // RatingStores(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
