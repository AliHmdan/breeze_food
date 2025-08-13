import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Stores extends StatelessWidget {
  const Stores({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      height: 250.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage(
            "assets/images/003.jpg", // ضع رابط الصورة هنا
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12)
        ),
      ),
      // المحتوى العلوي
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  "SECRET RECIPES",
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                 Text(
                  "BEST MENU\nTODAY",
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                 Text(
                  "Discount Up to 50% OFF",
                  style: TextStyle(
                    color: AppColor.gry,
                    fontSize: 10.sp,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {},
                  child:  Text("Order Now",style: TextStyle(color: AppColor.white),),
                ),
                SizedBox(height: 5.h,),
                InkWell(onTap: (){},
                  child: Text(
                    "www.resturant.com",
                    style: TextStyle(
                      color: AppColor.gry,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // الصف السفلي (التقييم + النص)

        ],
      ),
    );
  }
}
