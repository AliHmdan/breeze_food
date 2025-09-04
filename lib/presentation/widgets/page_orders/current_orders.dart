import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrentOrders extends StatelessWidget {
  const CurrentOrders({super.key});

  @override
  Widget build(BuildContext context) {

    final orders = [
      {
        "restaurant": "Chicken House",
        "items": "2 items",
        "total": "25.00\$",
        "date": "25/5/2025 09:00 PM",
        "image": "assets/images/003.jpg",
      },
      {
        "restaurant": "Pizza Point",
        "items": "3 items",
        "total": "40.00\$",
        "date": "24/5/2025 08:30 PM",
        "image": "assets/images/004.jpg",
      },
    ];

    return ListView.builder(
      // padding: const EdgeInsets.all(5),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Container(
          height: 110.h,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المطعم
              ClipOval(
                child: Image.asset(
                  order["image"]!,
                  width: 70.w,
                  height: 90.h,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // تفاصيل الطلب
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomSubTitle(subtitle:   order["restaurant"]!, color: AppColor.white, fontsize: 14.sp),

                    CustomSubTitle(subtitle:order["items"]!, color: AppColor.white, fontsize: 10.sp),

// SizedBox(height:15.h),
                  Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Total: ",
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 14.sp,
                                  fontFamily: "Manrope",
                                ),
                              ),
                              TextSpan(
                                text: "${order["total"]}",
                                style: TextStyle(
                                  color: Colors.yellow, // السعر باللون الأصفر
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Manrope",
                                ),
                              ),
                            ],
                          ),
                        ),

                        CustomSubTitle(subtitle: order["date"]!, color: AppColor.white, fontsize: 10.sp)
                      ],
                    ),

                  ],
                ),
              ),

              // التاريخ والوقت

            ],
          ),
        );
      },
    );
  }
}