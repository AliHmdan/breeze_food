import 'package:breezefood/blocs/auth/login/login_bloc.dart';
import 'package:breezefood/blocs/auth/login/login_event.dart';
import 'package:breezefood/blocs/auth/login/login_state.dart';
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/core/constans/routes.dart';
import 'package:breezefood/data/repositories/auth_repository.dart';
import 'package:breezefood/presentation/screens/auth/new_passowrd.dart';
import 'package:breezefood/presentation/widgets/auth/custom_text_form_field.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/main_shell.dart';
import 'package:breezefood/presentation/widgets/title/custom_sub_title.dart';
import 'package:breezefood/presentation/widgets/title/custom_title.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // helper لعرض SnackBar موحّد
  void _showSnackBar(
    BuildContext context, {
    required String message,
    Color? background,
    IconData? icon,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars(); // تنظيف أي رسالة قديمة
    messenger.showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: background ?? Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(AuthRepository()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.primaryColor,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoginFailure) {
              _showSnackBar(
                context,
                message: state.error,
                background: Colors.redAccent,
                icon: Icons.error_outline,
              );
            } else if (state is LoginSuccess) {
              _showSnackBar(
                context,
                message: "تم تسجيل الدخول بنجاح ✅",
                background: AppColor.primaryColor,
                icon: Icons.check_circle_outline,
              );
              // الانتقال مباشرة
            Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (_) => const MainShell()),
  (_) => false,
);
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;

            return Stack(
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
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 32.h,
                        ),
                        child: Form(
                          key: _formKey,
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
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              border: Border.all(
                                                  color: AppColor.gry),
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
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: CustomTextFormField(
                                              controller: phoneController,
                                              keyboardType:
                                                  TextInputType.number,
                                              hintText: "Phone Number",
                                              validator: (v) {
                                                final val = (v ?? '').trim();
                                                if (val.isEmpty) {
                                                  return 'أدخل رقم الهاتف';
                                                }
                                                if (val.length < 8) {
                                                  return 'رقم الهاتف غير صالح';
                                                }
                                                return null;
                                              },
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
                                        validator: (v) {
                                          final val = (v ?? '').trim();
                                          if (val.isEmpty) {
                                            return 'أدخل كلمة المرور';
                                          }
                                          if (val.length < 6) {
                                            return 'كلمة المرور قصيرة';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 10.h),

                                      // Forget password
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const NewPassowrd(),
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

                                      // Button or loader
                                      if (isLoading)
                                        Center(
                                          child: Lottie.asset(
                                            'assets/lottie/loading.json',
                                            width: 120.w,
                                            height: 120.h,
                                          ),
                                        )
                                      else
                                        CustomButton(
                                          title: "Continue",
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context.read<LoginBloc>().add(
                                                    LoginSubmitted(
                                                      phoneController.text,
                                                      passwordController.text,
                                                    ),
                                                  );
                                            } else {
                                              _showSnackBar(
                                                context,
                                                message:
                                                    'تحقق من الحقول المطلوبة',
                                                background: Colors.orange,
                                                icon: Icons.info_outline,
                                              );
                                            }
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
