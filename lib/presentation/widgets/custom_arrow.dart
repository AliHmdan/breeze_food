import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomArrow extends StatelessWidget {
  final void Function()? onTap ;
  final Color color;
  final Color background;
  const CustomArrow({super.key, required this.onTap, required this.color, required this.background});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,

        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 9),
          child: Icon(
            Icons.arrow_back_ios,
            color: color,
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}
