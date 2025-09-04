import 'package:breezefood/core/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonOrder extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const CustomButtonOrder({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96.w,
      height: 44.h,
      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        child: Row(
          children: [
         SvgPicture.asset(
              'assets/icons/box.svg',
              width: 20.w,
              height: 20.h,
              color: AppColor.white, // لو تريد التحكم باللون
            ),
            SizedBox(width: 5.w,),
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
    );
  }
}
