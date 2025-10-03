import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constans/color.dart';

class TiemPrice extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final String? svgPath;
  const TiemPrice({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6),
      width: 110.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(icon, color: AppColor.Dark, size: 16.sp)
          else if (svgPath != null)
            SvgPicture.asset(
              svgPath!,
              width: 24.w,
              height: 30.h,
              color: AppColor.Dark,
            ),

          Row(
            children: [
              CustomSubTitle(
                subtitle: title,
                color: AppColor.Dark,
                fontsize: 12.sp,
              ),
              CustomSubTitle(
                subtitle: subtitle,
                color: AppColor.Dark,
                fontsize: 12.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
