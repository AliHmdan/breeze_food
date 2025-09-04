import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:breezefood/presentation/widgets/auth/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ✅ الجزء العلوي - صورة الخلفية مع الشعار
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/top-view-burgers-with-cherry-tomatoes.png",
                  width: double.infinity,
                  height: 265.h,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  width: 150.w,
                ),
              ],
            ),

            // ✅ النموذج - الخلفية البيضاء
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                image: const DecorationImage(
                  image: AssetImage("assets/images/background_auth.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitle(
                      title: "Welcome to breeze",
                      color: AppColor.white,
                    ),
                    SizedBox(height: 8.h),
                    CustomSubTitle(
                      subtitle: "Please Enter your phone to signup",
                      color: AppColor.gry,
                      fontsize: 14.sp,
                    ),
                    SizedBox(height: 32.h),

                    // ✅ Phone Number
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

                    SizedBox(height: 16.h),

                    // ✅ Password
                    CustomTextFormField(
                      hintText: "Password",
                      backgroundColor: AppColor.white,
                      hintColor: AppColor.gry,
                      isPassword: true,
                      obscureInitially: true,
                    ),
                    SizedBox(height: 16.h),

                    // ✅ Password
                    CustomTextFormField(
                      hintText: "Confirm Password",
                      backgroundColor: AppColor.white,
                      hintColor: AppColor.gry,
                      isPassword: true,
                      obscureInitially: true,
                    ),
                    SizedBox(height: 8.h),




                    // ✅ زر الدخول
                    CustomButton(
                      title: "Continue",
                      onPressed: () {},
                    ),

                    SizedBox(height: 24.h),

                    // ✅ Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            "Or Register with",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 14.sp,
                              fontFamily: "Manrope",
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    SizedBox(height: 16.h),


                    const SocialLoginButtons(),

                    SizedBox(height: 30.h),

                    // ✅ التسجيل
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 14.sp,
                            fontFamily: "Manrope",
                            fontWeight: FontWeight.w400
                          ),
                          children: [
                            TextSpan(
                              text: "Login Now",
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                fontFamily: "Manrope",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
