import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/constans/color.dart';
import '../../widgets/custom_sub_title.dart';
import '../../widgets/custom_title.dart';

class VerfiyCode extends StatelessWidget {
  const VerfiyCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background_auth.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                ),
                SizedBox(height: 10.h),
                CustomTitle(title: "Enter the Code", color: AppColor.white),
                SizedBox(height: 8.h),
                CustomSubTitle(
                  subtitle: "Enter the verification code we just sent to +963938204147",
                  color: AppColor.gry,
                  fontsize: 14.sp,
                ),
                SizedBox(height: 45.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: PinCodeTextField(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    appContext: context,
                    length: 4,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 60,
                      fieldWidth: 60,
                      activeColor: AppColor.primaryColor,
                      selectedColor: AppColor.primaryColor,
                      inactiveColor: AppColor.gry,
                      activeBorderWidth: 4,
                      selectedBorderWidth: 4,
                      inactiveBorderWidth: 4,
                      activeFillColor: AppColor.white,
                      selectedFillColor: AppColor.white,
                      inactiveFillColor: AppColor.gry,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onCompleted: (v) => print("Completed: $v"),
                    onChanged: (value) => print("Changed: $value"),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {},
                  child: CustomSubTitle(
                    subtitle: "Resend Code",
                    color: AppColor.primaryColor,
                    fontsize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
