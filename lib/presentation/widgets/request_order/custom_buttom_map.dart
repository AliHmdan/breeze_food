import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constans/color.dart';

class CustomButtomMap extends StatelessWidget {
  final String title;
  const CustomButtomMap({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 93.w,
      height: 40.h,
      child: TextField(
        decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: AppColor.LightActive, fontSize: 12.sp),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
