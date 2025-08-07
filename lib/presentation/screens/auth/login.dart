import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/custom_button.dart';
import 'package:breezefood/presentation/widgets/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/custom_text_form_field.dart';
import 'package:breezefood/presentation/widgets/custom_title.dart';
import 'package:breezefood/presentation/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ✅ رأس الشاشة مع الشعار
            SizedBox(
              width: double.infinity,
              height: 265.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/top-view-burgers-with-cherry-tomatoes.png",
                    width: double.infinity,
                    height: 265.h,
                    fit: BoxFit.cover,
                  ),
                  Image.asset("assets/images/logo.png", width: 150.w),
                ],
              ),
            ),

            // ✅ القسم السفلي
            Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/background_auth.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),

                    CustomTitle(
                      title: "Welcome to Foodgo",
                      color: AppColor.white,
                    ),

                    SizedBox(height: 8.h),

                    CustomSubTitle(
                      subtitle: "Please Enter your phone to login",
                      color: AppColor.gry,
                      fontsize: 14.sp,
                    ),

                    SizedBox(height: 32.h),


                    // const PhoneInputWidget(),
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
                              // صورة علم سوريا (تأكد من أنك أضفت الصورة في assets و pubspec.yaml)
                              Image.asset(
                                'assets/icons/syria.png', // ضع المسار الصحيح للصورة
                                width: 30.w,
                                height: 30.h,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '+963',
                                style: TextStyle(fontSize: 14.sp,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // حقل إدخال رقم الهاتف
                        Expanded(
                          child: CustomTextFormField( hintText: "Phone Number",
                            backgroundColor: AppColor.white,
                            hintColor: AppColor.gry,


                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // ✅ كلمة المرور
                    CustomTextFormField(
                      hintText: "Password",
                      backgroundColor: AppColor.white,
                      hintColor: AppColor.gry,
                      isPassword: true,
                      obscureInitially: true,
                    ),

                    SizedBox(height: 8.h),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomSubTitle(
                        subtitle: "Forget password",
                        color: AppColor.primaryColor,
                        fontsize: 12.sp,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    CustomButton(title: "Continue",onPressed: (){},),

                    SizedBox(height: 24.h),

                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            "or sign in with",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 12.sp,
                              fontFamily: "Manrope",
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: AppColor.white)),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    const SocialLoginButtons(),

                    SizedBox(height: 24.h),

                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "Don’t have an account? ",
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 12.sp,
                            fontFamily: "Manrope",
                          ),
                          children: [
                            TextSpan(
                              text: "Sign up Now",
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold,
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
