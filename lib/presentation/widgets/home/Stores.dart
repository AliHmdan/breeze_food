import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/core/constans/routes.dart';
// Removed unused import: rating_stores.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freeza_food/data/model/home_model.dart';

class Stores extends StatelessWidget {
  // Accept optional stores data from the home response. If null or empty,
  // the widget falls back to the local static `items` list below.
  final List<StoryItem>? stores;

  Stores({super.key, this.stores});

  final List<Map<String, String>> items = [];
  final double height = 160.h;
  @override
  Widget build(BuildContext context) {
    // Build a list of items to display. If `stores` was passed in, try to
    // map each store to the internal Map<String,String> shape we expect.
    final List<Map<String, String>> displayedItems =
        (stores != null && stores!.isNotEmpty)
        ? stores!
              .map<Map<String, String>>(
                (s) => {
                  'image': s.image,
                  'title': s.title,
                  'subtitle': s.description,
                  'label': '',
                  'link': '',
                },
              )
              .toList()
        : items;
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
          itemCount: displayedItems.length,
          itemBuilder: (context, index, realIndex) {
            final item = displayedItems[index];
            return Stack(
              alignment: Alignment.center,
              children: [
                // خلفية الصورة
                Container(
                  height: height,
                  width: 361.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item["image"]!),

                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
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
                          item["subtitle"]!,
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          item["title"]!,
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          item["label"]!, // ✅ صححنا الحرف
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
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoute.orders);
                          },
                          child: Text(
                            "Order Now",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        // SizedBox(height: 4.h),

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
