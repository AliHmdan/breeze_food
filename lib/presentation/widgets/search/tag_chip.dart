import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:breezefood/core/constans/color.dart';

/// وسم بسيط مع زر إغلاق
class TagChip extends StatelessWidget {
  final String text;
  final VoidCallback onRemove;

  const TagChip({super.key, required this.text, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 18.sp, color: AppColor.white),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: "Manrope",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
