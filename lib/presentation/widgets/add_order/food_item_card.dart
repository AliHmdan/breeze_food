import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodItemCard extends StatelessWidget {
  final String title;
  final String size;
  final String price;
  final String image;

  const FoodItemCard({
    super.key,
    required this.title,
    required this.size,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      margin: const EdgeInsets.symmetric(vertical: 6, ),
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // الصورة
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(52.r),
               topLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(52.r),
               bottomLeft: Radius.circular(12.r),
            ),
            child: Image.asset(
              image,
              width: 100.w,
              height: 140.h,
              fit: BoxFit.cover,
            ),
          ),
          // النصوص
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomSubTitle(
                      subtitle: title,
                      color: AppColor.white,
                      fontsize: 16.sp,
                    ),
                  ),
                  const SizedBox(height: 4),
              
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomSubTitle(
                      subtitle: "Size : $size",
                      color: AppColor.white,
                      fontsize: 14.sp,
                    ),
                  ),
                  const SizedBox(height: 4),
               
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.h),
                    child: Row(
                      children: [
                        CustomSubTitle(
                          subtitle: "Price : ",
                          color: AppColor.white,
                          fontsize: 14.sp,
                        ),
                        CustomSubTitle(
                          subtitle: "$price \$",
                          color: AppColor.yellow,
                          fontsize: 14.sp,
                        ),
                      ],
                    ),
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
