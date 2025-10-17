import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constans/color.dart';
import '../title/custom_sub_title.dart';

class CustomHot extends StatefulWidget {
  const CustomHot({super.key});

  @override
  State<CustomHot> createState() => _CustomHotState();
}

class _CustomHotState extends State<CustomHot> {
  String? _selectedAddon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ الخيار الأول
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    activeColor: AppColor.primaryColor,
                    side: BorderSide(
                      color: AppColor.white,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    value: _selectedAddon == "Hot",
                    onChanged: (val) {
                      setState(() {
                        _selectedAddon = val! ? "Hot" : null;
                      });
                    },
                  ),
                  CustomSubTitle(
                    subtitle: "Hot",
                    color: AppColor.white,
                    fontsize: 14.sp,
                  ),
                ],
              ),
              CustomSubTitle(
                subtitle: "2.00\$",
                color: AppColor.yellow,
                fontsize: 14.sp,
              ),
            ],
          ),
        ),

        // ✅ الخيار الثاني
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    activeColor: AppColor.primaryColor,
                    side: BorderSide(
                      color: AppColor.white,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    value: _selectedAddon == "No Hot",
                    onChanged: (val) {
                      setState(() {
                        _selectedAddon = val! ? "No Hot" : null;
                      });
                    },
                  ),
                  CustomSubTitle(
                    subtitle: "No Hot",
                    color: AppColor.white,
                    fontsize: 14.sp,
                  ),
                ],
              ),
              CustomSubTitle(
                subtitle: "2.00\$",
                color: AppColor.yellow,
                fontsize: 14.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
