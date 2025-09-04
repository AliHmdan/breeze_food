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
      height: 200.h, // ارتفاع ثابت حتى داخل ListView أو SingleChildScrollView
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 200.h,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        itemCount: items.length,
        itemBuilder: (context, index, realIndex) {
          final item = items[index];
          return Stack(
            alignment: Alignment.center,
            children: [
              // الخلفية صورة
              Container(
                width: double.infinity,
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              // النصوص على اليسار
              Positioned(
                left: 16,
                top: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["title"]!,
                      style:  TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 120.w,
                      height: 50.h,
                      child: Text(
                        item["subtitle"]!,
                        style:  TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.gry,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // الدائرة في المنتصف
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 80.w,
                  height: 80.h,
                  decoration:  BoxDecoration(
                    color:AppColor.white,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item["priceLabel"]!,
                        style:  TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Manrope"
                        ),
                      ),
                      Text(
                        "\$${item["price"]!}",
                        style:  TextStyle(
                          color:AppColor.red,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                            fontFamily: "Manrope"
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
