import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constans/color.dart';
import '../title/custom_sub_title.dart';

class CustomAdd extends StatefulWidget {
  const CustomAdd({super.key});

  @override
  State<CustomAdd> createState() => _CustomAddState();
}

class _CustomAddState extends State<CustomAdd> {
  String? _selectedAddon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  activeColor: AppColor.primaryColor,
                  side:  BorderSide(             // 👈 هنا تحدد لون وسمك الـ border
                    color: AppColor.white,
                    width: 2,

                  ),
                  shape: RoundedRectangleBorder(      // 👈 هنا تضبط الـ border radius
                    borderRadius: BorderRadius.circular(6), // غير القيمة حسب رغبتك
                  ),
                  value: _selectedAddon == "chips",
                  onChanged: (val) {
                    setState(() {
                      _selectedAddon = val! ? "chips" : null;
                    });
                  },
                ),
                CustomSubTitle(
                  subtitle: "Regular chips",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  activeColor: AppColor.primaryColor,
                  side:  BorderSide(             // 👈 هنا تحدد لون وسمك الـ border
                    color: AppColor.white,
                    width: 2,

                  ),
                  shape: RoundedRectangleBorder(      // 👈 هنا تضبط الـ border radius
                    borderRadius: BorderRadius.circular(6), // غير القيمة حسب رغبتك
                  ),
                  value: _selectedAddon == "rice",
                  onChanged: (val) {
                    setState(() {
                      _selectedAddon = val! ? "rice" : null;
                    });
                  },
                ),
                CustomSubTitle(
                  subtitle: "Spicy Rice",
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
      ],
    );
  }
}
