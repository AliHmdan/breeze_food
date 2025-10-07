import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController ReferralLink;
  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    ReferralLink = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          // ✅ Banner
          Image.asset(
            "assets/images/top-view-burgers-with-cherry-tomatoes.png",
            width: double.infinity,
            height: 265.h,
            fit: BoxFit.cover,
          ),

          // ✅ Logo
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 80.h),
              child: Image.asset(
                "assets/images/breeze-food2.png",
                width: 150.w,
              ),
            ),
          ),

          // ✅ Form
          Positioned(
            left: 0,
            right: 0,
            top: 228.h,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.Dark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                // image: const DecorationImage(
                //   image: AssetImage("assets/images/background_auth.png"),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(color: AppColor.gry),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/syria.png',
                                        width: 24.w,
                                        height: 24.h,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        '+963',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: phoneController,
                                    hintText: "Phone Number",
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            // ✅ Password
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: "Password",

                              isPassword: true,
                              obscureInitially: true,
                            ),
                            SizedBox(height: 16.h),
                            // ✅ Confirm Password
                            CustomTextFormField(
                              controller: confirmPasswordController,
                              hintText: "Confirm Password",

                              isPassword: true,
                              obscureInitially: true,
                            ),
                            SizedBox(height: 16.h),
                            // ✅ Referral link
                            CustomTextFormField(
                              controller: ReferralLink,
                              hintText: "Referral link",
                            ),
                            SizedBox(height: 30.h),
                            // ✅ زر Continue
                            CustomButton(
                              title: "Continue",
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed(AppRoute.verifyCode);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ✅ النص في الأسفل
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 14.sp,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w400,
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
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(AppRoute.login);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
