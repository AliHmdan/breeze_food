import 'package:breezefood/presentation/screens/auth/new_passowrd.dart';
import 'package:breezefood/presentation/screens/home/home.dart';
import 'package:breezefood/presentation/widgets/auth/social_login_buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../blocs/auth/login/login_bloc.dart';
import '../../../blocs/auth/login/login_event.dart';
import '../../../blocs/auth/login/login_state.dart';
import '../../../core/constans/routes.dart';
import '../../../data/repositories/auth_repository.dart';

import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(AuthRepository()),
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Login successful")));

              Navigator.pushNamed(context, AppRoute.verifyCode);
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 32.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTitle(
                            title: "Welcome to Foodgo",
                            color: Colors.white,
                          ),
                          SizedBox(height: 8.h),
                          CustomSubTitle(
                            subtitle: "Please Enter your phone to login",
                            color: AppColor.gry,
                            fontsize: 14.sp,
                          ),
                          SizedBox(height: 32.h),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
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
                                  controller: phoneController,
                                  hintText: "Phone Number",
                                  backgroundColor: AppColor.white,
                                  hintColor: AppColor.gry,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          CustomTextFormField(
                            controller: passwordController,
                            hintText: "Password",
                            backgroundColor: AppColor.white,
                            hintColor: AppColor.gry,
                            isPassword: true,
                            obscureInitially: true,
                          ),
                          GestureDetector(onTap: () {
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
                          state is LoginLoading
                              ? Center(
                                  child: Lottie.asset(
                                    'assets/lottie/loading.json',
                                    width: 120.w,
                                    height: 120.h,
                                  ),
                                )
                              : CustomButton(
                                  title: "Continue",
                                  onPressed: () {
                                    // إرسال الحدث فقط بدون تنقل مباشر
                                    context.read<LoginBloc>().add(
                                      LoginSubmitted(
                                        phoneController.text,
                                        passwordController.text,
                                      ),
                                    );
                                       Navigator.of(context).pushReplacementNamed(AppRoute.home);
                                  },
                                ),

                          SizedBox(height: 24.h),

                          // ✅ Divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(color: Colors.grey.shade300),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  "Or Sign in with",
                                  style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 14.sp,
                                    fontFamily: "Manrope",
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(color: Colors.grey.shade300),
                              ),
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
              Navigator.of(context).pushNamed(AppRoute.signUp);
            },
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
            );
          },
        ),
      ),
    );
  }
}
