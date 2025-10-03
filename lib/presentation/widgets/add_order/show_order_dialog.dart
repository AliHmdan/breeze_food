import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

void showUnpaidOrderDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColor.Dark, // نفس الخلفية الغامقة
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // الأيقونة في الأعلى
              SvgPicture.asset(
                "assets/icons/pay.svg",
                width: 60.w,
                height: 60.h,
              ),
              const SizedBox(height: 12),

              // العنوان
              Text(
                "Unpaid order",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Manrope",
                  color: AppColor.white,
                ),
              ),

              const SizedBox(height: 8),

              // النص الوصفي
              Text(
                "You have an unpaid order. Please pay it so you can order again.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 14.sp,
                  fontFamily: "Manrope",
                ),
              ),
              const SizedBox(height: 20),

              // الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر Pay
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          side: BorderSide(
                            color: AppColor.Dark, // لون البوردر
                            width: 1, // سمك البوردر
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 35.h),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoute.pay);
                      },
                      child: CustomSubTitle(
                        subtitle: "Pay",
                        color: AppColor.white,
                        fontsize: 14.sp,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // زر Cancel
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.black, // رمادي غامق
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          side: BorderSide(
                            color: AppColor.Dark, // لون البوردر
                            width: 1, // سمك البوردر
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 35.h),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: CustomSubTitle(
                        subtitle: "Cancel",
                        color: AppColor.white,
                        fontsize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
