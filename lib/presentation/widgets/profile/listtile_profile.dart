import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/presentation/widgets/title/custom_sub_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListtileProfile extends StatelessWidget {
  final IconData? iconData;       // Nullable
  final String? svgPath;          // Nullable
  final String title;
  final void Function()? onTap;

  const ListtileProfile({
    super.key,
    this.iconData,                // يا أيقونة
    this.svgPath,                 // يا SVG
    required this.title, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: ListTile(
        leading: Container(
          
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColor.Dark,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColor.LightActive,
              width: 1.w,
            ),
          ),
          child: svgPath != null
              ? SvgPicture.asset(
                  svgPath!,
                  width: 17.sp,
                  height: 17.sp,
                  colorFilter: const ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                )
              : Icon(
                  iconData,
                  size: 18.sp,
                  color: AppColor.white,
                ),
        ),
        title: CustomSubTitle(
          subtitle: title,
          color: AppColor.white,
          fontsize: 14.sp,
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 22.sp,
          color: AppColor.white,
        ),
      ),
    );
  }
}
