import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constans/color.dart';

class CustomArrow extends StatelessWidget {
  final void Function()? onTap ;
  const CustomArrow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,

        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 9),
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.Dark,
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}
