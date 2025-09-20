import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constans/color.dart';
import '../../widgets/title/custom_sub_title.dart';
import '../../widgets/auth/custom_text_form_field.dart';
import '../../widgets/title/custom_title.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/background_auth.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
          child: Scaffold(
            backgroundColor: Colors.transparent,

            body: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                  )
                  ,
                  SizedBox(height: 10.h),
                  CustomTitle(title: "Enter Your Number", color: AppColor.white),
                  SizedBox(height: 8.h),
                  CustomSubTitle(
                    subtitle:
                    "We’ll send a code for verification",
                    color: AppColor.gry,
                    fontsize: 14.sp,
                  ),
                  SizedBox(height: 45.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/syria.png',
                              width: 30.w,
                              height: 30.h,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '+963',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomTextFormField(
                          hintText: "Phone Number",
                          backgroundColor: AppColor.white,
                          hintColor: AppColor.gry,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h),
CustomButton(title: "Continue", onPressed: (){})
                
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
