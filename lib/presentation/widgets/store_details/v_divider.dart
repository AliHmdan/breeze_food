import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constans/color.dart';

class VDividerThin extends StatelessWidget {
  const VDividerThin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w,
      height: 18.h,
      color: AppColor.light,
      margin: EdgeInsets.symmetric(horizontal: 6.w),
    );
  }
}
