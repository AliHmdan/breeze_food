import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/request_order/counter_request.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealCard extends StatefulWidget {
  const MealCard({super.key});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {


  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(left: 1,right: 10),
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // صورة الوجبة
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              topRight: Radius.circular(40),   // ممكن تغير القيمة حسب اللي يعجبك
              bottomRight: Radius.circular(40),
            ),            child: Image.asset(
              "assets/images/003.jpg",
              width: 85.w,
              height: 105.h,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // تفاصيل الوجبة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              CustomSubTitle(subtitle: "Chicken shish", color: AppColor.white, fontsize: 14.sp),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Size : ",
                        style: TextStyle(
                          color: AppColor.gry,
                          fontSize: 16.sp,

                        ),
                      ),

                      TextSpan(
                        text: " M",
                        style: TextStyle(
                          color: AppColor.gry,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                )
,
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Price : ",
                        style: TextStyle(
                          color: AppColor.gry,
                          fontSize: 16.sp,

                        ),
                      ),

                      TextSpan(
                        text: "5.00\$ ",
                        style: TextStyle(
                          color: AppColor.yellow,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // أزرار التحكم بالعدد
          CounterRequest()
        ],
      ),
    );
  }
}
