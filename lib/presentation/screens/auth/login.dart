import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/presentation/screens/auth/new_passowrd.dart';
import 'package:breezefood/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
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
          // Banner background
          Image.asset(
            "assets/images/top-view-burgers-with-cherry-tomatoes.png",
            width: double.infinity,
            height: 265.h,
            fit: BoxFit.cover,
            cacheWidth: 600,
          ),

          // Logo
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

          // Login container
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 228.h,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.Dark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 32.h,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTitle(
                              title: "Welcome to breeze",
                              color: Colors.white,
                            ),
                            SizedBox(height: 2.h),
                            CustomSubTitle(
                              subtitle: "Please Enter your phone to login",
                              color: AppColor.gry,
                              fontsize: 12.sp,
                            ),
                            SizedBox(height: 32.h),

                            // Phone field
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
                                    keyboardType: TextInputType.number,
                                    hintText: "Phone Number",
                                 
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            // Password
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: "Password",
                             
                              isPassword: true,
                              obscureInitially: true,
                            ),
                            SizedBox(height: 10.h),

                            // Forget password
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NewPassowrd(),
                                  ),
                                );
                              },
                              child: CustomSubTitle(
                                subtitle: "Forget password? ",
                                color: AppColor.primaryColor,
                                fontsize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 24.h),

                            CustomButton(
                              title: "Continue",
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoute.home);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Sign up
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 12.sp,
                              fontFamily: "Manrope",
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign Up Now",
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  fontFamily: "Manrope",
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoute.signUp);
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
