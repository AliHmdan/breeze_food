import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constans/color.dart';
import 'title/custom_sub_title.dart';
import 'title/custom_title.dart';

class CustomAppbarHome extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? image;
  final IconData? icon;
  final void Function()? onTap;
  const CustomAppbarHome({super.key,  this.image, this.icon,  this.subtitle, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // صورة البروفايل
       InkWell(onTap:onTap ,
         child: CircleAvatar(
           radius: 20.r,
           child: ClipOval(
             child: Image.asset(
               'assets/images/01.jpg',
               width: 40.w,
               height: 40.h,
               fit: BoxFit.cover,
             ),
           ),
         ),
       ),

        // النص والموقع
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTitle(title: title, color: AppColor.white),
            Row(
              children: [
                if (image != null) // <-- شرط حتى لا يعطي خطأ لو null
                  SvgPicture.asset(
                    image!,
                    color: AppColor.LightActive,
                    width: 20,
                    height: 20,
                  ),
                SizedBox(width: image != null ? 4 : 0),
                if (subtitle !=null)
                CustomSubTitle(
                  subtitle: "$subtitle",
                  color: AppColor.LightActive,
                  fontsize: 12.sp,
                ),
                if (icon != null)
                  Icon(
                    icon,
                    color: AppColor.LightActive,
                    size: 24.sp,
                  ),
              ],
            ),
          ],
        ),

        // أيقونة الإشعارات
        Container(
          width: 35.w,
          height: 35.h,
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
