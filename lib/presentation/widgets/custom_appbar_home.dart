import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constans/color.dart';
import 'custom_sub_title.dart';
import 'custom_title.dart';

class CustomAppbarHome extends StatelessWidget {
  const CustomAppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // صورة البروفايل
        CircleAvatar(
          radius: 30.r,
          backgroundImage: AssetImage('assets/images/01.jpg'),
        ),

        // النص والموقع
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTitle(title: "Deliver to", color: AppColor.white),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/location.svg',
                  color: AppColor.gry,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 4),
                CustomSubTitle(
                  subtitle: "Poplar Ave,CA",
                  color: AppColor.gry,
                  fontsize: 12.sp,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.gry,
                  size: 24.sp,
                ),
              ],
            ),
          ],
        ),

        // أيقونة الإشعارات
        Container(
          width: 50.w,
          height: 50.h,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColor.LightActive, width: 2),
          ),
          child: SvgPicture.asset(
            'assets/icons/notification.svg',
            color: Colors.white,
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }
}
