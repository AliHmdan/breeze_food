import 'package:breezefood/core/constans/color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrunchCarousel extends StatelessWidget {
  const BrunchCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {
        "image": "assets/images/001.jpg",
        "title": "BRUNCH\nFREE",
        "subtitle":
        "Enjoy a delicious meal at brunch, omelets, steaks, and all your breakfast and lunch favorites.",
        "price": "10",
        "priceLabel": "ONLY"
      },
      {
        "image": "assets/images/002.jpg",
        "title": "BURGER\nDEAL",
        "subtitle": "Juicy burgers with fresh toppings and delicious sauces.",
        "price": "8",
        "priceLabel": "ONLY"
      },
      {
        "image": "assets/images/003.jpg",
        "title": "BURGER\nDEAL",
        "subtitle": "Juicy burgers with fresh toppings and delicious sauces.",
        "price": "8",
        "priceLabel": "ONLY"
      }
    ];

    return SizedBox(
      height: 140.h, 
      width: 361.w,// ارتفاع ثابت حتى داخل ListView أو SingleChildScrollView
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 140.h,
         
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        itemCount: items.length,
        itemBuilder: (context, index, realIndex) {
          final item = items[index];
          return  Stack(
  alignment: Alignment.center,
  children: [
    // 1- الخلفية صورة
    Container(
      height: 140.h,
      width: 361.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(item["image"]!,),
          
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),

    // 2- طبقة شفافية فوق الصورة
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.black.withOpacity(0.4),
      ),
    ),

    // 3- النصوص + الدائرة
    Positioned(
      left: 12.w,
      top: 10.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item["title"]!,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.white,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 100.w,
            height: 42.h,
            child: Text(
              item["subtitle"]!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColor.white,
              ),
            ),
          ),
        ],
      ),
    ),

    Align(
      alignment: Alignment.center,
      child: Container(
        width: 53.w,
        height: 53.h,
        decoration: BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item["priceLabel"]!,
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                fontFamily: "Manrope",
              ),
            ),
            Text(
              "\$${item["price"]!}",
              style: TextStyle(
                color: AppColor.red,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                fontFamily: "Manrope",
              ),
            ),
          ],
        ),
      ),
    ),
  ],
);

        },
      ),
    );
  }
}
