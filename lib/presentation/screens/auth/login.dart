import 'package:breezefood/blocs/auth/login/login_bloc.dart';
import 'package:breezefood/blocs/auth/login/login_event.dart';
import 'package:breezefood/blocs/auth/login/login_state.dart';
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/data/repositories/auth_repository.dart';
import 'package:breezefood/presentation/screens/auth/new_passowrd.dart';
import 'package:breezefood/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(AuthRepository()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
            return Stack(
              children: [
                // Banner background
                Image.asset(
                  "assets/images/top-view-burgers-with-cherry-tomatoes.png",
                  width: double.infinity,
                  height: 265.h,
                  fit: BoxFit.cover,
                ),

                // Logo in center of banner
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.h),
                    child: Image.asset("assets/images/breeze-food2.png", width: 150.w),
                  ),
                ),

                // Login container
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0, // margin bottom
                  top: 228.h, // start after banner
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
                                    subtitle:
                                        "Please Enter your phone to login",
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
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          border: Border.all(
                                            color: AppColor.gry,
                                          ),
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
                                              style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),
                                              
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
                                          backgroundColor: AppColor.white,
                                          hintColor: AppColor.gry,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.h),

                                  // Password field
                                  CustomTextFormField(
                                    controller: passwordController,
                                    hintText: "Password",
                                    backgroundColor: AppColor.white,
                                    hintColor: AppColor.gry,
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
  
                                  // Button or loading
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
                                            // context.read<LoginBloc>().add(
                                            //   LoginSubmitted(
                                            //     phoneController.text,
                                            //     passwordController.text,
                                            //   ),
                                            // );
                                            Navigator.of(
                                              context,
                                            ).pushNamedAndRemoveUntil(
                                              "/home",
                                              (route) => false,
                                            );
                                          },
                                        ),
                                  // CustomButton(title: "Continue", onPressed: (){
                                  //   Navigator.of(context).pushNamed(AppRoute.home);
                                  // })
                                ],
                              ),
                            ),
                          ),

                          // ✅ Sign up link ثابت تحت
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
                                          Navigator.of(
                                            context,
                                          ).pushNamed(AppRoute.signUp);
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
            );
          },
        ),
      ),
    );
  }
}
