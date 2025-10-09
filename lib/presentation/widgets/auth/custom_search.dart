import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constans/color.dart';

class CustomSearch extends StatelessWidget {
  final IconData? icon;
  final String hint;
  final String? boxicon;
  final void Function()? onTap;
  final bool readOnly;
  final double height; // ✅ باراميتر للتحكم بالارتفاع
  final double borderRadius; // ✅ باراميتر للتحكم بالـ radius

  const CustomSearch({
    super.key,
    required this.hint,
    this.icon,
    this.boxicon,
    this.onTap,
    this.readOnly = true,
    this.height = 50, // قيمة افتراضية
    this.borderRadius = 30, // قيمة افتراضية
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: IconButton(
              icon: Icon(
                icon,
                color: AppColor.black,
                size: 18.sp, // ✅ متجاوب
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        SizedBox(width: 8.w),
        Expanded(
          child: SizedBox(
            height: height.h, // ✅ تحكم بالارتفاع
            child: TextFormField(
              readOnly: readOnly,
              onTap: onTap,
              style: TextStyle(
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: AppColor.LightActive,
                  fontSize: 14.sp,
                  fontFamily: "Manrope",
                  // fontWeight: FontWeight.w400,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(12.w), // ✅ متجاوب
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    color: AppColor.LightActive,
                    width: 8.w,
                    height: 8.w,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 10.h,
                ),
                filled: true,
                fillColor: AppColor.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 3.w),
        if (boxicon != null)
          Container(
            width: 40.w,
            height: 40.w,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: SvgPicture.asset(
              boxicon!,
              width: 40.w,
              height: 40.w,
            ),
          ),
      ],
    );
  }
}
