import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constans/color.dart';

class CustomTitleSection extends StatelessWidget {
  final String title;
  final String? all;
  final IconData? icon;
  const CustomTitleSection({super.key, required this.title,  this.all, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColor.white,
            fontSize: 14.sp,
            fontFamily: "Manrope",
          ),
        ),
        Row(
          children: [
            Text(
             all ?? "",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColor.white,
                fontSize: 12.sp,
                fontFamily: "Manrope",
              ),
            ),
            SizedBox(width: 10.w,),
            Icon(
              icon,
              size: 12.sp,
              color: AppColor.white,
            ),
          ],
        ),
      ],
    );
  }
}


