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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login successful")),
              );

              Navigator.pushNamed(context, AppRoute.verfiy_code);
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
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
                      Image.asset(
                        "assets/images/logo.png",
                        width: 150.w,
                      ),
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
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTitle(
                            title: "Welcome to Foodgo",
                            color: Colors.black,
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
                                    Text('+963', style: TextStyle(fontSize: 14.sp)),
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
                            },
                          )
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
