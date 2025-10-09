import 'package:freeza_food/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonOrder extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const CustomButtonOrder({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth( // ✅ العرض يصير حسب المحتوى
      child: SizedBox(
        height: 44.h, // ارتفاع متجاوب
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            backgroundColor: AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // ✅ يمنع أخذ عرض كامل
            children: [
              SvgPicture.asset(
                'assets/icons/box.svg',
                width: 20.w,
                height: 20.h,
                color: AppColor.white,
              ),
              SizedBox(width: 6.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.white,
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
