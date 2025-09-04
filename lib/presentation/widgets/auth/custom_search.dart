import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constans/color.dart';

class CustomSearch extends StatelessWidget {
  final IconData? icon;
  final String hint;
  final String? boxicon;
  const CustomSearch({super.key, required this.hint,  this.icon, this.boxicon});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        if (icon != null)
        Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: IconButton(
            icon: Icon(
              icon,
              color: AppColor.black,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(

              hintText: hint,
              hintStyle: TextStyle(
                color: AppColor.gry,
                fontSize: 14.sp,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  color: AppColor.gry,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              contentPadding: EdgeInsets.all(10),
              filled: true,
              fillColor: AppColor.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 5.w,),
        if (boxicon !=null)
          Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child:
          SvgPicture.asset(
            boxicon!,
            width: 30.w,
            height: 30.h,
          ),
        ),
      ],
    );
  }
}
